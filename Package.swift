// swift-tools-version:4.2
import PackageDescription

let package = Package(
    name: "Groot",
    products: [
        .library(name: "Groot", targets: ["Groot"])
    ],
    targets: [
        .target(name: "Groot"),
        .testTarget(name: "GrootTests", dependencies: ["Groot"])
    ],
    swiftLanguageVersions: [.v4]
)