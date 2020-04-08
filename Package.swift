// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "EndpointsRequests",
    products: [
        .library(
            name: "EndpointsRequests",
            targets: ["EndpointsRequests"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "EndpointsRequests",
            dependencies: []),
        .testTarget(
            name: "EndpointsRequestsTests",
            dependencies: ["EndpointsRequests"]),
    ]
)
