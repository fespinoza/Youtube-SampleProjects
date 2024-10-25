// The Swift Programming Language
// https://docs.swift.org/swift-book
//
// Swift Argument Parser
// https://swiftpackageindex.com/apple/swift-argument-parser/documentation

import ArgumentParser

@main
struct JSONPayload: ParsableCommand {
    @Argument(help: "Which step of the live activity cycle to generate as JSON")
    var step: Int

    @Flag(help: "Prints date in a human-readable style")
    var debug: Bool = false

    mutating func run() throws {
        let jsonString = switch step {
        case 1: try beforeMatch(debug: debug)
        case 2: try matchStart(debug: debug)
        case 3: try firstGoal(debug: debug)
        case 4: try halfTime(debug: debug)
        case 5: try secondGoal(debug: debug)
        case 6: try thirdGoal(debug: debug)
        case 7: try matchEnd(debug: debug)
        default:
            fatalError("No step '\(step)' defined")
        }

        print(jsonString)
    }
}
