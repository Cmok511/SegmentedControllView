// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "SegmentedControlView",
    platforms: [
        .iOS(.v15)
    ],
    dependencies: [
        .package(url: "https://github.com/Cmok511/SegmentedControllView.git", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "SegmentedControlView",
            dependencies: ["SegmentedControlView"]
        )
    ]
)
