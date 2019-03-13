extension KeyPath where Value == Bool {
  public static prefix func ! (keyPath: KeyPath) -> KeyPath {
    return keyPath.appending(path: \.negated)
  }

  public static func ~= (pattern: KeyPath, value: Root) -> Bool {
    return value[keyPath: pattern]
  }
}

public func not<Root>(_ keyPath: KeyPath<Root, Bool>) -> KeyPath<Root, Bool> {
  return !keyPath
}

private extension Bool {
  var negated: Bool {
    return !self
  }
}
