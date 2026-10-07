// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "WakTrainerFeatureTimer",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "WakTrainerFeatureTimer",
            targets: ["WakTrainerFeatureTimer"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/iosdevbyul/WakTrainerCoreModels",
            branch: "main"
        )
    ],
    targets: [
        .target(
            name: "WakTrainerFeatureTimer",
            dependencies: [
                .product(
                    name: "WakTrainerCoreModels",
                    package: "WakTrainerCoreModels"
                )
            ]
        ),
        .testTarget(
            name: "WakTrainerFeatureTimerTests",
            dependencies: [
                "WakTrainerFeatureTimer"
            ]
        )
    ]
)
