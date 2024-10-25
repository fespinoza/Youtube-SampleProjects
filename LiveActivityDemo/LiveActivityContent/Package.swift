// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "LiveActivityContent",
    platforms: [.iOS(.v18), .macOS(.v15)],
    products: [
        .library(
            name: "LiveActivityContent",
            targets: ["LiveActivityContent"]
        ),
    ],
    targets: [
        .target(name: "LiveActivityContent"),
        .testTarget(
            name: "LiveActivityContentTests",
            dependencies: ["LiveActivityContent"]
        ),
    ]
)
