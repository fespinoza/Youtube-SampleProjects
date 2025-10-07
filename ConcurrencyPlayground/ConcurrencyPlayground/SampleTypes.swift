import Foundation

/*
 Questions from nonisolation

 Q: Can there be non-isolated mutable state?
 A: it seems so, ``messages`` is non-isolated and mutable state


 */

struct Person: Sendable {
    let name: String
    var age: Int

    var description: String {
        "\(name) (\(age.formatted()))"
    }
}

nonisolated class Constants {
    static let containerName: String = "MyDataContainer"
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
        Task {
            // Non-Sendable type 'DataContainer' of property 'dataContainer' cannot exit main actor-isolated context
//            await dataContainer.addMessage("Hello \(person.name)")

            person.age = 26
        }
    }
}
