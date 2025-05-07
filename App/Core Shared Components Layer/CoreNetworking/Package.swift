// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CoreNetworking",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "CoreNetworking",
            targets: [
                "CoreNetworking"
            ]
        ),
    ],
    dependencies: [
        .package(
            name: "CoreFoundational",
            path: "../CoreFoundational"
        ),
        .package(
            name: "CoreTesting",
            path: "../CoreTesting"
        )
    ],
    targets: [
        .target(
            name: "CoreNetworking",
            dependencies: [
                .product(
                    name: "CoreFoundational",
                    package: "CoreFoundational"
                ),
                .product(
                    name: "CoreTesting",
                    package: "CoreTesting"
                )
            ]
        ),
        .testTarget(
            name: "CoreNetworkingTests",
            dependencies: ["CoreNetworking"]
        ),
    ]
)
