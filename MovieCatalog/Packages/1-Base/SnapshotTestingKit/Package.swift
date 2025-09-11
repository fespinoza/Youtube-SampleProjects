// swift-tools-version: 6.1
import PackageDescription

let package = Package(
    name: "SnapshotTestingKit",
    platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "SnapshotTestingKit",
            targets: ["SnapshotTestingKit"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing", from: "1.18.6"),
    ],
    targets: [
        .target(
            name: "SnapshotTestingKit",
            dependencies: [
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
            ]
        ),
    ]
)
