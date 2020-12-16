// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OfficeFileReader",
    platforms: [
       .macOS(.v10_11), .iOS(.v9),
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "OfficeFileReader",
            targets: ["OfficeFileReader"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/mw99/DataCompression", from: "3.0.0"),
        .package(url: "https://github.com/hughbe/DataStream", from: "2.0.0"),
        .package(url: "https://github.com/hughbe/CompoundFileReader", from: "1.0.0"),
        .package(url: "https://github.com/hughbe/OleAutomationDataTypes", from: "1.0.0"),
        .package(url: "https://github.com/hughbe/OleDataTypes", from: "1.0.0"),
        .package(url: "https://github.com/hughbe/OlePropertySet", from: "1.0.0"),
        .package(url: "https://github.com/hughbe/VBAFileReader", from: "1.0.0"),
        .package(url: "https://github.com/hughbe/WindowsDataTypes", from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "OfficeFileReader",
            dependencies: ["CompoundFileReader", "DataCompression", "DataStream", "OleDataTypes", "OleAutomationDataTypes", "OlePropertySet", "VBAFileReader", "WindowsDataTypes"]),
        .testTarget(
            name: "OfficeFileReaderTests",
            dependencies: ["OfficeFileReader"],
            resources: [.process("Resources")]),
    ]
)
