// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "NativeKit",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v6),
    ],
    products: [
        .library(
            name: "NativeKit",
            targets: ["NativeKit"]
        ),
    ],
    targets: [
        .target(
            name: "NativeKit"
        ),
        .testTarget(
            name: "NativeKit.Test",
            dependencies: ["NativeKit"]
        ),
    ]
)
