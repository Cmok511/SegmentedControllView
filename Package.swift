// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "SegmentedControlView",
    platforms: [
        .iOS(.v15)
    ],
    targets: [
        .target(
            name: "SegmentedControlView",
            dependencies: ["SegmentedControlView"]
        )
    ]
)
