// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "Config",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "Config",
            targets: ["Config"]),
    ],
    targets: [
        .target(name: "Config"),
    ]
)
