// swift-tools-version: 6.1
import PackageDescription

let package = Package(
    name: "MovieSearch",
    platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "MovieSearch",
            targets: ["MovieSearch"]
        ),
    ],
    dependencies: [
        .package(path: "../01-Base/PreviewData"),
        .package(path: "../02-Infrastructure/MovieDBNetworking"),
        .package(path: "../02-Infrastructure/MovieComponents"),
        .package(path: "../02-Infrastructure/Navigation"),
    ],
    targets: [
        .target(
            name: "MovieSearch",
            dependencies: [
                "PreviewData",
                "MovieDBNetworking",
                "MovieComponents",
                "Navigation",
            ]
        ),

    ]
)
