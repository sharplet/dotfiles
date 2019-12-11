import Combine
import Foundation
import Util

enum DirectoryEnumeratorError: Error {
  case creationFailed(URL)
}

private enum FileAction {
  case prune
  case pruneBelowDepth(Int)
  case pruneMatching((URL) -> Bool)
  case skipAboveDepth(Int)
  case skipMatching((URL) -> Bool)

  var isSkipAction: Bool {
    switch self {
    case .prune, .pruneBelowDepth, .pruneMatching:
      return false
    case .skipAboveDepth, .skipMatching:
      return true
    }
  }
}

struct FindPublisher: Publisher {
  typealias Output = URL
  typealias Failure = Error

  let root: URL
  let fileManager: FileManager

  let maximumDepth: Int?
  let minimumDepth: Int?
  let skipsHiddenFiles: Bool

  fileprivate var actions: [FileAction] = []

  init(root: URL, minimumDepth: Int? = nil, maximumDepth: Int? = nil, skipsHiddenFiles: Bool = false, fileManager: FileManager = .default) {
    self.fileManager = fileManager
    self.maximumDepth = maximumDepth
    self.minimumDepth = minimumDepth
    self.root = root
    self.skipsHiddenFiles = skipsHiddenFiles
  }

  func receive<S: Subscriber>(subscriber: S) where S.Input == Output, S.Failure == Failure {
    let subscription = FindSubscription(publisher: self, subscriber: subscriber)
    subscriber.receive(subscription: subscription)
  }
}

extension FindPublisher {
  func filter(_ isFileIncluded: @escaping (URL) -> Bool) -> FindPublisher {
    var publisher = self
    publisher.actions.append(.skipMatching({ !isFileIncluded($0) }))
    return publisher
  }

  func prune(_ shouldPruneBranch: @escaping (URL) -> Bool) -> FindPublisher {
    var publisher = self
    publisher.actions.append(.pruneMatching(shouldPruneBranch))
    return publisher
  }

  func prune() -> FindPublisher {
    var publisher = self
    publisher.actions.append(.prune)
    return publisher
  }
}

private class FindSubscription<S: Subscriber> where S.Input == URL, S.Failure == Error {
  enum State {
    case active(FileManager.DirectoryEnumerator)
    case cancelled
  }

  let actions: [FileAction]
  let publisher: FindPublisher
  let subscriber: S

  private var demand: Subscribers.Demand
  private var state: State

  init(publisher: FindPublisher, subscriber: S) {
    var actions = publisher.actions

    if let maximumDepth = publisher.maximumDepth {
      actions.insert(.pruneBelowDepth(maximumDepth), at: 0)
    }

    if let minimumDepth = publisher.minimumDepth {
      let index = actions.firstIndex(where: { $0.isSkipAction }) ?? actions.endIndex
      actions.insert(.skipAboveDepth(minimumDepth), at: index)
    }

    self.actions = actions
    self.demand = .none
    self.publisher = publisher
    self.subscriber = subscriber

    var options: FileManager.DirectoryEnumerationOptions = []
    options.insert(.producesRelativePathURLs)
    if publisher.skipsHiddenFiles {
      options.insert(.skipsHiddenFiles)
    }

    let enumerator = publisher.fileManager.enumerator(
      at: publisher.root,
      includingPropertiesForKeys: [.isDirectoryKey],
      options: options
    )

    if let enumerator = enumerator {
      self.state = .active(enumerator)
    } else {
      self.state = .cancelled
      subscriber.receive(completion: .failure(DirectoryEnumeratorError.creationFailed(publisher.root)))
    }
  }

  func serviceDemand() {
    guard case let .active(enumerator) = state else { return }

    while demand > 0 {
      guard let next = enumerator.nextObject() else {
        demand = .none
        state = .cancelled
        subscriber.receive(completion: .finished)
        return
      }

      var currentURL = next as? URL

      actions: for action in actions {
        switch (action, currentURL) {
        case let (.prune, url?) where url.isDirectory:
          enumerator.skipDescendents()
        case (.prune, _):
          break

        case let (.pruneBelowDepth(maximumDepth), url?) where enumerator.level >= maximumDepth && url.isDirectory:
          enumerator.skipDescendents()
        case (.pruneBelowDepth, _):
          break

        case let (.pruneMatching(shouldPrune), url?) where url.isDirectory:
          if shouldPrune(url) {
            enumerator.skipDescendents()
          }
        case (.pruneMatching, _):
          break

        case let (.skipAboveDepth(minimumDepth), _) where enumerator.level < minimumDepth:
          currentURL = nil
          break actions
        case (.skipAboveDepth, _):
          break

        case let (.skipMatching(shouldSkip), url?):
          if shouldSkip(url) {
            currentURL = nil
            break actions
          }
        case (.skipMatching, _):
          break
        }
      }

      if let url = currentURL {
        demand += subscriber.receive(url)
      }
    }
  }
}

private extension URL {
  var isDirectory: Bool {
    (try? resourceValues(forKeys: [.isDirectoryKey]).isDirectory) == true
  }
}

extension FindSubscription: Cancellable {
  func cancel() {}
}

extension FindSubscription: Subscription {
  func request(_ demand: Subscribers.Demand) {
    self.demand += demand
    serviceDemand()
  }
}
