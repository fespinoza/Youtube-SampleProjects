// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "PreviewData",
    platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "PreviewData",
            targets: ["PreviewData"]
        ),
    ],
    targets: [
        .target(name: "PreviewData"),
    ]
)
