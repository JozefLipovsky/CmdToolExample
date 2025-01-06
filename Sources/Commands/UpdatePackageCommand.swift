import ArgumentParser
import Foundation

struct UpdateToolsVersion: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "update-tools-version",
        abstract: "Updates Swift.package swift-tools-version"
    )

    mutating func run() throws {
        try udpdateToolsVersion()
    }
}

private extension UpdateToolsVersion {
    func udpdateToolsVersion() throws {
        try execute(arguments: ["package", "tools-version", "--set", "5.9"])
    }

    func execute(arguments: [String]) throws {
        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/usr/bin/swift")
        process.arguments = arguments

        print("\(String(describing: UpdateToolsVersion.self)) executing arguments: \(arguments.joined(separator: " "))")

        try process.run()
        process.waitUntilExit()

        print("\(String(describing: UpdateToolsVersion.self)) finished executing")
    }
}
