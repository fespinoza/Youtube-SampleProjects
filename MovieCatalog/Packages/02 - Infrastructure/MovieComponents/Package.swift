// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "MovieComponents",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "MovieComponents",
            targets: ["MovieComponents"]),
    ],
    dependencies: [
        .package(path: "../01 - Base/Logging"),
        .package(path: "../01 - Base/MovieModels"),
    ],
    targets: [
        .target(name: "MovieComponents", dependencies: ["Logging", "MovieModels"]),
    ]
)
