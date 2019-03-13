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
    var index = arguments.startIndex

    if formNextPositionalArgumentIndex(&index) {
      revision = arguments.remove(at: index)

      if formNextPositionalArgumentIndex(&index) {
        base = arguments.remove(at: index)
      }
    }

    arguments.insert("\(base)..\(revision)", at: index)
    arguments.insert("log", at: arguments.startIndex)
  }

  func formNextPositionalArgumentIndex(_ index: inout Int) -> Bool {
    while index < arguments.endIndex {
      switch arguments[index] {
      case not(\.isOption), \.isArgumentTerminator:
        return true

      default:
        arguments.formIndex(after: &index)
      }
    }

    return false
  }
}

var parser = ArgumentParser()
parser.parse()
try exec("git", arguments: parser.arguments)
