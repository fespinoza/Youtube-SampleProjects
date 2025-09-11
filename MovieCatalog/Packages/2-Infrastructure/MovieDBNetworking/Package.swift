// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "MovieDBNetworking",
    platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "MovieDBNetworking",
            targets: ["MovieDBNetworking"]),
    ],
    dependencies: [
        .package(path: "../1-Base/Config"),
        .package(path: "../1-Base/MovieModels"),
    ],
    targets: [
        .target(
            name: "MovieDBNetworking",
            dependencies: ["Config", "MovieModels"]
        ),
    ]
)
