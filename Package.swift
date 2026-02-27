// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ClawBackPackage",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "ClawBackCore",
            targets: ["ClawBackCore"]
        ),
        .executable(
            name: "ClawBack",
            targets: ["ClawBack"]
        )
    ],
    dependencies: [],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        .target(
            name: "ClawBackCore",
            dependencies: []
        ),
        .executableTarget(
            name: "ClawBack",
            dependencies: ["ClawBackCore"]
        ),
        .testTarget(
            name: "ClawBackCoreTests",
            dependencies: ["ClawBackCore"]
        )
    ]
)