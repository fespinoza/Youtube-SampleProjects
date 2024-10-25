// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "LiveActivityUI",
    platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "LiveActivityUI",
            targets: ["LiveActivityUI"]
        ),
    ],
    dependencies: [
        .package(path: "../LiveActivityContent"),
    ],
    targets: [
        .target(name: "LiveActivityUI", dependencies: ["LiveActivityContent"]),
    ]
)
