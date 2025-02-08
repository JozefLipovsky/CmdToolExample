import ArgumentParser
import Foundation

extension ParsableCommand {
    func execute(arguments: [String]) throws {
        let log = String(describing: type(of: self))

        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/usr/bin/swift")
        process.arguments = arguments

        let outputPipe = Pipe()
        process.standardOutput = outputPipe
        process.standardError = outputPipe

        print("\(log) executing arguments: \(arguments.joined(separator: " "))")

        outputPipe.fileHandleForReading.readabilityHandler = { [log] pipeHandle in
            guard let data = try? pipeHandle.readToEnd() else {
                return
            }

            print("\(log) outputPipe fileHandleForReading:\n\(String(data: data, encoding: .utf8)!)")
        }

        try process.run()

        process.terminationHandler = { _ in
            do {
                try outputPipe.fileHandleForReading.close()
            } catch {
                print("\(log) process terminationHandler - \(error.localizedDescription)")
            }
        }

        process.waitUntilExit()
        print("\(log) finished executing")
    }
}
