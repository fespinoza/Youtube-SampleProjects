// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "MovieModels",
    platforms: [.iOS(.v17)],
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
            dependencies: [
                .product(name: "Tagged", package: "swift-tagged"),
            ]
        ),
    ]
)
