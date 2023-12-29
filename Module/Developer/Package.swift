// swift-tools-version: 5.7.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Developer",
  platforms: [.iOS(.v14), .macOS(.v13)],
  products: [
    // Products define the executables and libraries a package produces, and make them visible to other packages.
    .library(
      name: "Developer",
      targets: ["Developer"])
  ],
  dependencies: [
    // Dependencies declare other packages that this package depends on.
    .package(url: "https://github.com/realm/realm-swift.git", branch: "master"),
    .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.2.0")),
    .package(url: "https://github.com/fardan-dev/MyGames-Core.git", branch: "master")
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages this package depends on.
    .target(
      name: "Developer",
      dependencies: [
        .product(name: "RealmSwift", package: "realm-swift"),
        .product(name: "Core", package: "MyGames-Core"),
        "Alamofire"
      ]),
    .testTarget(
      name: "DeveloperTests",
      dependencies: ["Developer"])
  ]
)
