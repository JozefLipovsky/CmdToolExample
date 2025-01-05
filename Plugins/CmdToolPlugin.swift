import PackagePlugin
import Foundation

@main
struct CmdToolPlugin: CommandPlugin {
    func performCommand(context: PluginContext, arguments: [String]) async throws {
        let tool = try context.tool(named: "CmdToolExecutable")

        let process = Process()
        process.executableURL = tool.url
        process.arguments = arguments

        try process.run()
        process.waitUntilExit()
    }
}
