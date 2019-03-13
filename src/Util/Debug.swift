import Foundation

extension ProcessInfo {
  @inlinable
  public var isDebug: Bool {
    guard let isDebug = environment["DEBUG"] else { return false }
    return (isDebug as NSString).boolValue
  }
}

@inlinable
public func debugDump<T>(_ value: T) -> T {
  guard ProcessInfo.processInfo.isDebug else { return value }
  return dump(value)
}
