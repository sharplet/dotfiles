#!/usr/bin/swift
//
// Usage:
//   git prlog [<options>] [<revision>] [<base>]

import Util

extension String {
  var isOption: Bool {
    return hasPrefix("-")
  }
}

struct ArgumentParser {
  private(set) var arguments: ArraySlice<String>

  init(arguments: [String]) {
    self.arguments = arguments.dropFirst()
  }

  mutating func parse() {
    var base = "master"
    var revision = ""
    let argumentsIndex = firstPositionalArgumentIndex

    var hasMoreArguments: Bool {
      return argumentsIndex < arguments.endIndex && arguments[argumentsIndex] != "--"
    }

    if hasMoreArguments {
      revision = arguments.remove(at: argumentsIndex)

      if hasMoreArguments {
        base = arguments.remove(at: argumentsIndex)
      }
    }

    arguments.insert("\(base)..\(revision)", at: argumentsIndex)
    arguments.insert("log", at: arguments.startIndex)
  }

  var firstPositionalArgumentIndex: Int {
    var index = arguments.startIndex

    search: while index < arguments.endIndex {
      switch arguments[index] {
      case "--":
        break search
      case let argument where !argument.isOption:
        break search
      default:
        arguments.formIndex(after: &index)
      }
    }

    return index
  }
}

var parser = ArgumentParser(arguments: CommandLine.arguments)
parser.parse()
try exec("git", arguments: parser.arguments)
