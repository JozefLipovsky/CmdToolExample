// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CmdTool",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .plugin(
            name: "CmdToolPlugin",
            targets: [
                "CmdToolPlugin"
            ]
        ),
        .executable(
            name: "CmdToolExecutable",
            targets: [
                "CmdToolExecutable"
            ]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/apple/swift-argument-parser.git",
            from: "1.2.0"
        )
    ],
    targets: [
        .plugin(
            name: "CmdToolPlugin",
            capability: .command(
                intent: .custom(
                    verb: "cmd-tool",
                    description: "A CMD tool example."
                ),
                permissions: [
                    .writeToPackageDirectory(reason: "Update SMP project config.")
                ]
            ),
            dependencies: [
                "CmdToolExecutable"
            ]
        ),

        .executableTarget(
            name: "CmdToolExecutable",
            dependencies: [
                "Commands"
            ]
        ),

        .target(
            name: "Commands",
            dependencies: [
                .product(
                    name: "ArgumentParser",
                    package: "swift-argument-parser"
                ),
            ]
        ),
    ]
)
