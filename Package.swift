// swift-tools-version:4.0

import PackageDescription

let package = Package(
  name: "sharplet-dotfiles",
  targets: [
    .target(name: "catdirname"),
    .target(name: "git-prlog", dependencies: ["Util"]),
    .target(name: "Util"),
  ]
)
