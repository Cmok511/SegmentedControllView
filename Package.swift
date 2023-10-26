// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "SegmentedControlView",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "SegmentedControlView",
            targets: ["SegmentedControlView"]
        )
    ],
    targets: [
        .target(
            name: "SegmentedControlView",
            path: "SegmentedControllView.swift"
        )
    ]
)

