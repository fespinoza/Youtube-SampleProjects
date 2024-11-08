// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "JSONPayload",
    platforms: [.macOS(.v15)],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.2.0"),
        .package(path: "../LiveActivityContent"),
    ],
    targets: [
        .executableTarget(
            name: "JSONPayload",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "LiveActivityContent", package: "LiveActivityContent"),
            ]
        ),
    ]
)
