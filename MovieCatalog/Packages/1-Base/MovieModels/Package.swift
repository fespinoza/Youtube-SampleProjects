// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "MovieModels",
    platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "MovieModels",
            targets: ["MovieModels"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-tagged", from: "0.10.0"),
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
