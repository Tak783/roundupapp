// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CorePresentation",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "CorePresentation",
            targets: ["CorePresentation"]),
    ],
    dependencies: [
        .package(
            name: "CoreFoundational",
            path: "../Core Layer/CoreFoundational"
        ),
        .package(
            name: "CoreFeatureLayerPresentationHelpers",
            path: "../Core Feature Layer Presentation Helpers/CoreFeatureLayerPresentationHelpers"
        ),
        .package(
            url: "https://github.com/jdg/MBProgressHUD",
            .upToNextMajor(from: "1.2.0")
        )
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "CorePresentation",
            dependencies: [
                .product(
                    name: "CoreFoundational",
                    package: "CoreFoundational"
                ),
                .product(
                    name: "CoreFeatureLayerPresentationHelpers",
                    package: "CoreFeatureLayerPresentationHelpers"
                ),
                .product(
                    name: "MBProgressHUD",
                    package: "MBProgressHUD"
                )
            ]
        ),
        .testTarget(
            name: "CorePresentationTests",
            dependencies: [
                "CorePresentation"
            ]
        ),
    ]
)
