// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "UsefulExtensions",
    platforms: [.iOS(.v26)],
    products: [
        .library(
            name: "UsefulExtensions",
            targets: ["UsefulExtensions"]
        ),
    ],
    targets: [
        .target(
            name: "UsefulExtensions"
        ),
    ]
)
