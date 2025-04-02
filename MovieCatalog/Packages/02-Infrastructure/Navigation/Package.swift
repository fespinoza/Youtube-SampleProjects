// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "Navigation",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "Navigation",
            targets: ["Navigation"]
        ),
    ],
    dependencies: [
        .package(path: "../01-Base/MovieModels"),
        .package(path: "../01-Base/Logging"),
        .package(path: "../01-Base/Config"),
    ],
    targets: [
        .target(
            name: "Navigation",
            dependencies: ["Logging", "MovieModels", "Config"]
        ),
        .testTarget(
            name: "NavigationTests",
            dependencies: ["Navigation"]
        ),
    ]
)
