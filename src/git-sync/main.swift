import Util

func isPlainArgument(_ argument: String) -> Bool {
  !argument.hasPrefix("-") && !argument.contains(":")
}

func usage() -> Never {
  fail("Usage: git sync <remote> <branch> [options]")
}

guard var command = Array(CommandLine.arguments.dropFirst()).nonEmpty,
  let remoteIndex = command.firstIndex(where: isPlainArgument),
  case let remaining = command.index(after: remoteIndex),
  remaining < command.endIndex
  else { usage() }

if let branchIndex = command[remaining...].firstIndex(where: isPlainArgument) {
  let branchName = command[branchIndex]
  command[branchIndex] = "\(branchName):\(branchName)"
}

command.insert(contentsOf: ["git", "fetch"], at: 0)

if Environment.isDebug {
  print(command)
}

try exec("/usr/bin/env", arguments: command)
