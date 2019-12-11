import Foundation
import Regex
import Util

enum ParsingState {
  case option
  case value(option: String)
  case done
}

var arguments = CommandLine.arguments.dropFirst()
var state = ParsingState.option

var exclude: Regex?
var include: Regex?

do {
  try arguments.removeAll { argument in
    switch (state, argument) {
    case (.done, _):
      return false

    case (_, "--"):
      state = .done
      return true

    case (.option, Regex("^[^-]")):
      state = .done
      return false

    case let (.value(option: "exclude"), pattern):
      exclude = try Regex(string: pattern)
      state = .option
      return true

    case (.option, Regex("--exclude=(.+)")):
      let pattern = Regex.lastMatch!.captures[0]!
      exclude = try Regex(string: pattern)
      return true

    case (.option, "--exclude"):
      state = .value(option: "exclude")
      return true

    case let (.value(option: "include"), pattern):
      include = try Regex(string: pattern)
      state = .option
      return true

    case (.option, Regex("--include=(.+)")):
      let pattern = Regex.lastMatch!.captures[0]!
      include = try Regex(string: pattern)
      return true

    case (.option, "--include"):
      state = .value(option: "include")
      return true

    case let (.value(option), _):
      fatalError("unexpected option \(option)")

    case (.option, _):
      fputs("Usage: \(CommandLine.arguments[0]) [--exclude <pattern>] [--include <pattern>]\n", stderr)
      exit(1)
    }
  }
} catch {
  fputs("fatal: \(error)\n", stderr)
  exit(1)
}

let root = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)

let repos = FindPublisher(root: root, minimumDepth: 2, maximumDepth: 4)
  .prune { exclude?.matches($0.relativePath) ?? false }
  .filter { $0.lastPathComponent == ".git" }
  .filter { include?.matches($0.relativePath) ?? true }
  .prune()
  .map { $0.deletingLastPathComponent() }

_ = repos.sink(
  receiveCompletion: { completion in
    if case let .failure(error) = completion {
      fputs("fatal: \(error)\n", stderr)
      exit(1)
    }
  },
  receiveValue: { url in
    print(url.relativePath)
  }
)
