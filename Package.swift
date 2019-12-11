// swift-tools-version:5.1

import PackageDescription

let package = Package(
  name: "sharplet-dotfiles",
  platforms: [
    .macOS(.v10_15),
  ],
  dependencies: [
    .package(url: "https://github.com/sharplet/Regex.git", from: "2.1.0"),
  ],
  targets: [
    .target(name: "catdirname"),
    .target(name: "git-prlog", dependencies: ["Util"]),
    .target(name: "ls-projects", dependencies: ["Regex", "Util"]),
    .target(name: "Util"),
  ]
)
