// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "NativeKit",
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
