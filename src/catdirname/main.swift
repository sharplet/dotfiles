import Darwin.C

func ascii(_ scalar: Unicode.Scalar) -> Int32 {
  return Int32(UInt8(ascii: scalar))
}

let args = CommandLine.arguments.dropFirst()
let terminator = args.contains("-0") ? ascii("\0") : ascii("\n")

while let path = readLine() {
  let dir = path.withCString { dirname(UnsafeMutablePointer(mutating: $0)) }
  guard dir != nil else { perror("dirname"); exit(1) }
  fputs(dir, stdout)
  putchar(terminator)
}
