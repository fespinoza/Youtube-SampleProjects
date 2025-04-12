// swift-tools-version: 5.10

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
