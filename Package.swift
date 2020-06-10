// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftyWorkflow",
    platforms:  [.iOS(.v11), .tvOS(.v11)],
    products: [
        .library(
            name: "SwiftyWorkflow",
            targets: ["SwiftyWorkflow"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "SwiftyWorkflow",
            dependencies: [],
            path: "SwiftyWorkflow"
        )
    ]
)
