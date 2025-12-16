// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "PushNotificationsDebug",
    platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "PushNotificationsDebug",
            targets: ["PushNotificationsDebug"]
        ),
    ],
    targets: [
        .target(
            name: "PushNotificationsDebug"
        ),
    ]
)
