import ArgumentParser
import Foundation

extension ParsableCommand {
    func execute(arguments: [String]) throws {
        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/usr/bin/swift")
        process.arguments = arguments

        print("\(String(describing: type(of: self))) executing arguments: \(arguments.joined(separator: " "))")

        try process.run()
        process.waitUntilExit()

        print("\(String(describing: type(of: self))) finished executing")
    }
}
