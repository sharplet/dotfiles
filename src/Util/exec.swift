import Foundation

public func exec<Arguments: Sequence>(_ path: String, arguments: Arguments)
  throws -> Never
  where Arguments.Element == String {

  var argv = [strdup(path)]
  for argument in arguments {
    argv.append(strdup(argument))
  }
  defer { argv.forEach { free($0) } }

  if path.hasPrefix("/") {
    execv(path, argv + [nil])
  } else {
    execvp(path, argv + [nil])
  }

  throw NSError(domain: POSIXError.errorDomain, code: Int(errno))
}
