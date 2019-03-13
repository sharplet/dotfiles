#!/usr/bin/swift
//
// Usage:
//   git prlog [<options>] [<revision>] [<base>]

import Util

extension String {
  var isArgumentTerminator: Bool {
    return self == "--"
  }

  var isOption: Bool {
    return hasPrefix("-") && !isArgumentTerminator
  }
}

struct ArgumentParser {
  private(set) var arguments: [String]

  init() {
    self.init(arguments: CommandLine.arguments.dropFirst())
  }

  init<Arguments: Collection>(arguments: Arguments) where Arguments.Element == String {
    self.arguments = Array(arguments)
  }

  mutating func parse() {
    var base = "master"
    var revision = ""
    let argumentsIndex = firstPositionalArgumentIndex

    var hasMoreArguments: Bool {
      return argumentsIndex < arguments.endIndex && !arguments[argumentsIndex].isArgumentTerminator
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
      case not(\.isOption), \.isArgumentTerminator:
        break search
      default:
        arguments.formIndex(after: &index)
      }
    }

    return index
  }
}

var parser = ArgumentParser()
parser.parse()
try exec("git", arguments: parser.arguments)
