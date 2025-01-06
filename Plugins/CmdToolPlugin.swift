import PackagePlugin
import Foundation

@main
struct CmdToolPlugin: CommandPlugin {
    func performCommand(context: PluginContext, arguments: [String]) async throws {
        let tool = try context.tool(named: "CmdToolExecutable")

        let process = Process()
        process.executableURL = tool.url
        process.arguments = arguments

        print("\(String(describing: type(of: self))) performCommand arguments: \(arguments.joined(separator: " "))")

        try process.run()
        process.waitUntilExit()

        let gracefulExit = process.terminationReason == .exit && process.terminationStatus == 0
        if !gracefulExit {
            let reason = process.terminationReason.rawValue
            let status = process.terminationStatus
            throw "\(String(describing: type(of: self))) failed - reason: \(reason) - status: \(status)"
        }

        print("\(String(describing: type(of: self))) finished performCommand")
    }
}

extension String: @retroactive Error {}
