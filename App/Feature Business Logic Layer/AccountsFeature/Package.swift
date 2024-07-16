// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AccountsFeature",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "AccountsFeature",
            targets: ["AccountsFeature"]
        ),
    ],
    dependencies: [
        .package(
            name: "CoreFoundational",
            path: "../Core Layer/CoreFoundational"
        ),
        .package(
            name: "CoreTesting",
            path: "../Core Layer/CoreTesting"
        ),
        .package(
            name: "CoreNetworking",
            path: "../Core Shared Components Layer/CoreNetworking"
        ),
        .package(
            name: "MockNetworking",
            path: "../Core Shared Components Layer/MockNetworking"
        ),
        .package(
            name: "CoreStarlingEngineSharedModels",
            path: "../Core Starling Engine Layer/CoreStarlingEngineSharedModels"
        )
    ],
    targets: [
        .target(
            name: "AccountsFeature",
            dependencies: [
                .product(
                    name: "CoreFoundational",
                    package: "CoreFoundational"
                ),
                .product(
                    name: "CoreNetworking",
                    package: "CoreNetworking"
                ),
                .product(
                    name: "CoreStarlingEngineSharedModels",
                    package: "CoreStarlingEngineSharedModels"
                )
            ]
        ),
        .testTarget(
            name: "AccountsFeatureTests",
            dependencies: [
                "AccountsFeature",
                .product(
                    name: "CoreTesting",
                    package: "CoreTesting"
                ),
                .product(
                    name: "MockNetworking",
                    package: "MockNetworking"
                )
            ]
        ),
    ]
)
