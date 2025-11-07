// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "MovieDetails",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "MovieDetails",
            targets: ["MovieDetails"]
        ),
    ],
    dependencies: [
        .package(path: "../01-Base/PreviewData"),
        .package(path: "../01-Base/SnapshotTestingKit"),
        .package(path: "../02-Infrastructure/MovieDBNetworking"),
        .package(path: "../02-Infrastructure/MovieComponents"),
        .package(path: "../02-Infrastructure/Navigation"),
    ],
    targets: [
        .target(
            name: "MovieDetails",
            dependencies: ["MovieDBNetworking", "MovieComponents", "Navigation", "PreviewData"]
        ),
        .testTarget(
            name: "MovieDetailsTests",
            dependencies: ["MovieDetails", "SnapshotTestingKit"],
            resources: [
                .copy("__Snapshots__")
            ]
        ),
    ]
)
