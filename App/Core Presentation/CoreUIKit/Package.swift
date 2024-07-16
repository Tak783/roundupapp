// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CoreUIKit",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "CoreUIKit",
            targets: ["CoreUIKit"]),
    ],
    dependencies: [
        .package(
            name: "CoreFoundational",
            path: "../Core Layer/CoreFoundational"
        )
    ],
    targets: [
        .target(
            name: "CoreUIKit",
            dependencies: [
                .product(
                    name: "CoreFoundational",
                    package: "CoreFoundational"
                )
            ]
        ),
        .testTarget(
            name: "CoreUIKitTests",
            dependencies: ["CoreUIKit"]),
    ]
)
