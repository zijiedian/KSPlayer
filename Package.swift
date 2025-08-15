// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "KSPlayer",
    defaultLocalization: "en",
    platforms: [
        .macOS(.v10_15),
        .macCatalyst(.v13),
        .iOS(.v13),
        .tvOS(.v13),
        .visionOS(.v1)
    ],
    products: [
        // 主播放器库
        .library(
            name: "KSPlayer",
            targets: ["KSPlayer"]
        ),
        // 单独暴露 DisplayCriteria，方便外部直接 import
        .library(
            name: "DisplayCriteria",
            targets: ["DisplayCriteria"]
        )
    ],
    dependencies: [
        // FFmpegKit 作为静态依赖声明，这样 SPM 会自动拉取
        .package(url: "https://github.com/kingslay/FFmpegKit.git", from: "6.1.3")
    ],
    targets: [
        // KSPlayer 主模块
        .target(
            name: "KSPlayer",
            dependencies: [
                .product(name: "FFmpegKit", package: "FFmpegKit"),
                "DisplayCriteria"
            ],
            resources: [
                .process("Metal/Shaders.metal")
            ],
            swiftSettings: [
                // 仅在 Swift 5.9 及以上可用
                .enableExperimentalFeature("StrictConcurrency")
            ]
        ),
        // DisplayCriteria 模块
        .target(
            name: "DisplayCriteria"
        ),
        // 测试模块
        .testTarget(
            name: "KSPlayerTests",
            dependencies: ["KSPlayer"],
            resources: [
                .process("Resources")
            ]
        )
    ]
)
