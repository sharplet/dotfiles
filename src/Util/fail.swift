import Foundation

@inlinable
public func fail(_ arguments: Any...) -> Never {
  var message = ""
  for argument in arguments {
    print(argument, terminator: "", to: &message)
  }
  print(message, to: &standardError)
  exit(1)
}
