import Foundation

/*
 Questions from nonisolation

 Q: Can there be non-isolated mutable state?
 A: it seems so, ``messages`` is non-isolated and mutable state

 Q: When should I use `nonisolated`?
 A: in library code, where I want callers to decide the Thread the code will be run on



 */

struct Person: Sendable {
    let name: String
    var age: Int

    var description: String {
        "\(name) (\(age.formatted()))"
    }
}

struct Value {
    var rawValue: Int
}

nonisolated class Constants {
    static let containerName: String = "MyDataContainer"

    // Static property 'foo' is not concurrency-safe because it is nonisolated global shared mutable state
//    static var foo: Int = 3
    static let foo: Int = 3
}

nonisolated class DataContainer {
    let title: String
    var messages: [String]

    init(title: String, messages: [String] = []) {
        self.title = title
        self.messages = messages
    }

    func addMessage(_ message: String) {
        messages.append(message)
    }

    func printMessages() {
        print("==== Messages: \(title)")
        messages.forEach { print($0) }
    }

    // Static property 'shared' is not concurrency-safe because non-'Sendable' type 'DataContainer' may have shared mutable state
//    static let shared: DataContainer = .init(title: "Shared")
}


class ContentLogic {
    var inbox: [String] = []

}

@MainActor
class SafeContent {
    var value: Int = 0
}

@MainActor
class LoginContainer {
    var title: String = "Hello, World!"

    nonisolated let content: SafeContent = .init()

    @MainActor var data: DataContainer = .init(title: "Main")

    // 'nonisolated' can not be applied to variable with non-'Sendable' type 'DataContainer'
//    nonisolated let otherData: DataContainer = .init(title: "Other")

    func checkContent() {
        print("content: \(content.value)")

        print("data: \(data.title) ")

        Task { @concurrent in
            let value = await content.value
            print("other content: \(value)")

            // Non-Sendable type 'DataContainer' of property 'data' cannot exit main actor-isolated context
//            let title = await data.title
//            print("other value: \(title)")
        }
    }
}

@Observable
class ContentViewModel {
    var inputText = "" {
        didSet {
            storeAsMessage(inputText)
        }
    }

    // 'nonisolated' can not be applied to variable with non-'Sendable' type 'DataContainer'
    // nonisolated let dataContainer = DataContainer(title: "Content")
    let dataContainer = DataContainer(title: "Content")
    // also the type is marked `nonisolated` but the `dataContainer` variable is isolated to the main actor

    nonisolated let prefix: String = "msg: "
    // 'nonisolated' cannot be applied to mutable stored properties
//    nonisolated var suffix: String = "."

    func storeAsMessage(_ message: String) {
        dataContainer.addMessage(prefix + message)
    }

    func printMessages() {
        dataContainer.messages.removeAll()

        let person = Person(name: "Pedro", age: 20)
        dataContainer.addMessage("Hello \(person.name)")
    }

    @concurrent func printMessagesConcurrently() async {
        var person = Person(name: "Pablo", age: 25)

        // Main actor-isolated property 'dataContainer' cannot be accessed from outside of the actor
//        dataContainer.addMessage("foo")

        // Non-Sendable type 'DataContainer' of property 'dataContainer' cannot exit main actor-isolated context
//        await dataContainer.addMessage("foo")

        Task { @MainActor in
            dataContainer.addMessage("Hello World")
        }

        var value = Value(rawValue: 2)
        Task {
            // Non-Sendable type 'DataContainer' of property 'dataContainer' cannot exit main actor-isolated context
//            await dataContainer.addMessage("Hello \(person.name)")

//            person.age = 26
            value.rawValue = 3
        }

//        value.rawValue = 6
        // Sending value of non-Sendable type '() async -> ()' risks causing data races
        person.age = 28
    }
}
