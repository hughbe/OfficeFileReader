// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OfficeFileReader",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "OfficeFileReader",
            targets: ["OfficeFileReader"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        //.package(url: "https://github.com/hughbe/DataStream", from: "1.0.0"),
        .package(path: "../DataStream"),
        //.package(url: "https://github.com/hughbe/WindowsDataTypes", from: "1.0.0"),
        .package(path: "../WindowsDataTypes"),
        .package(url: "https://github.com/hughbe/OleAutomationDataTypes", from: "1.0.0"),
        //.package(url: "https://github.com/hughbe/CompoundFileReader", from: "1.0.0"),
        .package(path: "../CompoundFileReader"),
        .package(path: "../OlePropertySet")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "OfficeFileReader",
            dependencies: ["DataStream", "WindowsDataTypes", "CompoundFileReader", "OleAutomationDataTypes", "OlePropertySet"]),
        .testTarget(
            name: "OfficeFileReaderTests",
            dependencies: ["OfficeFileReader"]),
    ]
)