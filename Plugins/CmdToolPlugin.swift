import PackagePlugin
import Foundation

@main
struct CmdToolPlugin: CommandPlugin {
    func performCommand(context: PluginContext, arguments: [String]) async throws {
        let log = String(describing: type(of: self))

        let tool = try context.tool(named: "CmdToolExecutable")

        let process = Process()
        process.executableURL = tool.url
        process.arguments = arguments

        let outputPipe = Pipe()
        process.standardOutput = outputPipe
        process.standardError = outputPipe

        print("\(log) performCommand arguments: \(arguments.joined(separator: " "))")

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

        let gracefulExit = process.terminationReason == .exit && process.terminationStatus == 0
        if !gracefulExit {
            let reason = process.terminationReason.rawValue
            let status = process.terminationStatus
            throw "\(log) failed - reason: \(reason) - status: \(status)"
        }

        print("\(log) finished performCommand")
    }
}

extension String: @retroactive Error {}
