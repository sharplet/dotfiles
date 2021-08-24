// swift-tools-version:5.5

import PackageDescription

let package = Package(
  name: "sharplet-dotfiles",
  platforms: [
    .macOS(.v12),
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-argument-parser.git", from: "0.4.4"),
    .package(url: "https://github.com/sharplet/Regex.git", from: "2.1.0"),
  ],
  targets: [
    .executableTarget(name: "catdirname"),
    .executableTarget(name: "focus", dependencies: [.argumentParser]),
    .executableTarget(name: "git-prlog", dependencies: ["Util"]),
    .executableTarget(name: "git-sync", dependencies: ["Util"]),
    .executableTarget(name: "ls-projects", dependencies: [.regex, "Util"]),
    .target(name: "Util"),
  ]
)

extension Target.Dependency {
  static var argumentParser: Target.Dependency {
    .product(name: "ArgumentParser", package: "swift-argument-parser")
  }

  static var regex: Target.Dependency {
    "Regex"
  }
}
