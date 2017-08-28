#!/usr/bin/env swift

import Darwin.C

let args = CommandLine.arguments.dropFirst()
let terminator = Int32(args.contains("-0") ? UInt8(ascii: "\0") : UInt8(ascii: "\n"))

while let path = readLine() {
  let dir = path.withCString { dirname(UnsafeMutablePointer(mutating: $0)) }
  guard dir != nil else { perror("dirname"); exit(1) }
  fputs(dir, stdout)
  putchar(terminator)
}
