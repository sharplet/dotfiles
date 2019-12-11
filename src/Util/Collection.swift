extension Collection {
  @inlinable
  public var nonEmpty: Self? {
    isEmpty ? nil : self
  }
}

// MARK: Equatable elements

extension BidirectionalCollection where Element: Equatable {
  @inlinable
  public func hasSuffix<Suffix: BidirectionalCollection>(_ suffix: Suffix) -> Bool where Suffix.Element == Element {
    reversed().hasPrefix(suffix.reversed())
  }
}

extension Collection where Element: Equatable {
  @inlinable
  public func hasPrefix<Prefix: Collection>(_ `prefix`: Prefix) -> Bool where Prefix.Element == Element {
    zip(self, `prefix`).allSatisfy(==)
  }
}
