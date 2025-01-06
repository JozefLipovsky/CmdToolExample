import ArgumentParser
import Foundation

struct AddTarget: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "add-target",
        abstract: "Adds a new target in Swift.package"
    )

    mutating func run() throws {
        try execute(arguments: ["package", "add-target", "NewTarget"])
    }
}
