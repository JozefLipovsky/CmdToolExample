import ArgumentParser
import Foundation

struct UpdateToolsVersion: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "update-tools-version",
        abstract: "Updates Swift.package swift-tools-version"
    )

    mutating func run() throws {
        try execute(arguments: ["package", "tools-version", "--set", "5.9"])
    }
}
