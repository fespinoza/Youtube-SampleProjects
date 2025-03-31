// swift-tools-version: 5.10
import PackageDescription

let package = Package(
    name: "SnapshotTestingKit",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "SnapshotTestingKit",
            targets: ["SnapshotTestingKit"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing", from: "1.18.0"),
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
