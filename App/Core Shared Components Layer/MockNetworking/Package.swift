// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MockNetworking",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "MockNetworking",
            targets: ["MockNetworking"]
        ),
    ],
    dependencies: [
        .package(
            name: "CoreFoundational",
            path: "../CoreFoundational"
        ),
        .package(
            name: "CoreNetworking",
            path: "../CoreNetworking"
        )
    ],
    targets: [
        .target(
            name: "MockNetworking",
            dependencies: [
                .product(
                    name: "CoreFoundational",
                    package: "CoreFoundational"
                ),
                .product(
                    name: "CoreNetworking",
                    package: "CoreNetworking"
                )
            ],
            resources: [
                .process(
                    "Resources"
                )
            ]
        ),
        .testTarget(
            name: "MockNetworkingTests",
            dependencies: ["MockNetworking"]
        ),
    ]
)
