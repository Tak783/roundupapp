// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SavingsGoalsFeature",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "SavingsGoalsFeature",
            targets: [
                "SavingsGoalsFeature"
            ]
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
            name: "SavingsGoalsFeature",
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
            name: "SavingsGoalsFeatureTests",
            dependencies: [
                "SavingsGoalsFeature",
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
