import Foundation

func fail(_ message: String, status: Int32 = EXIT_FAILURE) -> Never {
  fputs(message + "\n", stderr)
  exit(status)
}

extension Notification.Name {
  static let ScreenIsLocked = Notification.Name("com.apple.screenIsLocked")
}

guard case let arguments = Array(CommandLine.arguments.dropFirst()),
  !arguments.isEmpty,
  case let command = arguments.joined(separator: " ")
  else { fail("error: no command specified") }

print("Starting...")

DispatchQueue.main.async {
  print("Registered '\(command)' to run on \(Notification.Name.ScreenIsLocked.rawValue)")
}

let dateFormatter = ISO8601DateFormatter()
dateFormatter.formatOptions = [
  .withFullDate,
  .withTime,
  .withSpaceBetweenDateAndTime,
  .withColonSeparatorInTime,
]
dateFormatter.timeZone = .autoupdatingCurrent

let notificationCenter = DistributedNotificationCenter.default()

notificationCenter.addObserver(forName: .ScreenIsLocked, object: nil, queue: .main) { notification in
  let date = Date()
  print("[\(dateFormatter.string(from: date))] \(notification.name.rawValue): \(command)")

  let process = Process.launchedProcess(launchPath: "/bin/sh", arguments: ["-c", command])
  process.waitUntilExit()

  guard process.terminationStatus == 0 else {
    fputs("warning: command exited with status \(process.terminationStatus)\n", stderr)
    return
  }
}

dispatchMain()
