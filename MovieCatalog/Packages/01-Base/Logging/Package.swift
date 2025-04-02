// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "Logging",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "Logging",
            targets: ["Logging"]
        ),
    ],
    targets: [
        .target(name: "Logging"),
    ]
)
