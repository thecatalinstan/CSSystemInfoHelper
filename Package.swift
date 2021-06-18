// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CSSystemInfoHelper",
    platforms: [
        .macOS(.v10_10),
        .iOS(.v9),
        .tvOS(.v9),
        .watchOS(.v2)],
    products: [
        .library(
            name: "CSSystemInfoHelper",
            targets: ["CSSystemInfoHelper"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "CSSystemInfoHelper",
            dependencies: [],
            path: "CSSystemInfoHelper",
            exclude: ["Info.plist"],
            sources: ["Sources"],
            publicHeadersPath: "Headers"),
        .testTarget(
            name: "CSSystemInfoHelperTests",
            dependencies: ["CSSystemInfoHelper"],
            path: "CSSystemInfoHelperTests",
            exclude: ["Info.plist"],
            cSettings: [
                .headerSearchPath("../CSSystemInfoHelper/Headers"),
                .headerSearchPath("../CSSystemInfoHelper/Sources")])
    ]
)
