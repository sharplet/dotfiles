import Foundation

@frozen
public struct StandardIOStream: TextOutputStream {
  @usableFromInline
  var file: UnsafeMutablePointer<FILE>

  @inlinable
  public mutating func write(_ string: String) {
    fputs(string, file)
  }
}

public var standardError = StandardIOStream(file: stderr)
public var standardOutput = StandardIOStream(file: stdout)
