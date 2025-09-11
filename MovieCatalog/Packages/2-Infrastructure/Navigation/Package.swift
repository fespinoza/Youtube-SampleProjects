// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "Navigation",
    platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "Navigation",
            targets: ["Navigation"]
        ),
    ],
    dependencies: [
        .package(path: "../1-Base/Config"),
        .package(path: "../1-Base/MovieModels"),
    ],
    targets: [
        .target(
            name: "Navigation",
            dependencies: ["Config", "MovieModels"]
        ),
        .testTarget(
            name: "NavigationTests",
            dependencies: ["Navigation"]
        ),
    ]
)
