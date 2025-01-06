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

        print("\(String(describing: type(of: self))) finished performCommand")
    }
}
