// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "MovieComponents",
    platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "MovieComponents",
            targets: ["MovieComponents"]),
    ],
    dependencies: [
        .package(path: "../01-Base/MovieModels"),
        .package(path: "../01-Base/PreviewData"),
        .package(path: "../02-Infrastructure/Navigation"),
    ],
    targets: [
        .target(name: "MovieComponents", dependencies: ["MovieModels", "Navigation", "PreviewData"]),
    ]
)
