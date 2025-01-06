import ArgumentParser

public struct Commands: ParsableCommand {
    public static let configuration = CommandConfiguration(
        commandName: "cmd-tool",
        abstract: "A Swift command-line tool example.",
        shouldDisplay: true,
        subcommands: [
            UpdateToolsVersion.self
        ]
    )

    public init() {}
}

