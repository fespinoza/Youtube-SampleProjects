// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "MovieModels",
    products: [
        .library(
            name: "MovieModels",
            targets: ["MovieModels"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-tagged", from: "0.6.0"),
    ],
    targets: [
        .target(
            name: "MovieModels",
            dependencies: [.product(name: "Tagged", package: "swift-tagged")]
        ),
    ]
)
