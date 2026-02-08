// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "Reachability",
    platforms: [.iOS(.v18), .macOS(.v15)],
    products: [
        .library(name: "Reachability", targets: ["Reachability"]),
        .library(name: "ReachabilityMocks", targets: ["ReachabilityMocks"])
    ],
    targets: [
        .target(name: "Reachability"),
        .target(name: "ReachabilityMocks", dependencies: ["Reachability"]),
        .testTarget(name: "ReachabilityTests", dependencies: ["Reachability"])
    ]
)
