import Foundation
import ArgumentParser

struct ExampleCommand: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "example-command",
        abstract: "Example command."
    )

    mutating func run() throws {
        print("Example command...")
    }
}
