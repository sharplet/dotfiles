import ArgumentParser
import AppKit
import System

var env: [String: String] {
  ProcessInfo.processInfo.environment
}

struct Focus: ParsableCommand {
  @Argument(help: "A new Focus")
  var newFocus: [String] = []

  func run() throws {
    let path = FilePath(NSHomeDirectory()).appending(".focus")
    let controller = FocusController(path: path)

    if !newFocus.isEmpty {
      let newFocus = newFocus.joined(separator: " ")
      try controller.setFocus(newFocus)
      refreshXbarIfNecessary()
    }

    guard let focus = try controller.focus else {
      throw ValidationError("Current focus not set")
    }

    print(focus)
  }

  func refreshXbarIfNecessary() {
    guard let plugin = findFocusPlugin() else { return }
    var components = URLComponents(string: "xbar://app.xbar.com/refreshPlugin")!
    components.queryItems = [URLQueryItem(name: "path", value: plugin)]
    openWithoutActivating(components.url!)
  }

  func expand(_ path: String) -> URL {
    URL(fileURLWithPath: (path as NSString).expandingTildeInPath)
  }

  func findFocusPlugin() -> String? {
    let fs = FileManager.default
    let pluginsURL = expand("~/Library/Application Support/xbar/plugins")
    guard let plugins = try? fs.contentsOfDirectory(at: pluginsURL, includingPropertiesForKeys: nil)
      else { return nil }
    return plugins.lazy.compactMap(matchFocusPlugin).first
  }

  func matchFocusPlugin(_ url: URL) -> String? {
    let name = url.lastPathComponent
    return name.hasPrefix("focus") && name.hasSuffix(".sh") ? name : nil
  }

  @discardableResult
  func openWithoutActivating(_ url: URL) -> Bool {
    var success = true
    let config = NSWorkspace.OpenConfiguration()
    config.activates = false
    NSWorkspace.shared.open(url, configuration: config) { _, error in
      success = error == nil
      CFRunLoopStop(CFRunLoopGetMain())
    }
    CFRunLoopRun()
    return success
  }
}

Focus.main()
