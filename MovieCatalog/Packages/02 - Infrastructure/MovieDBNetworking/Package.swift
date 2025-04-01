// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "MovieDBNetworking",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "MovieDBNetworking",
            targets: ["MovieDBNetworking"]),
    ],
    dependencies: [
        .package(path: "../01 - Base/Config"),
        .package(path: "../01 - Base/MovieModels"),
    ],
    targets: [
        .target(
            name: "MovieDBNetworking",
            dependencies: ["Config", "MovieModels"]
        ),
    ]
)
