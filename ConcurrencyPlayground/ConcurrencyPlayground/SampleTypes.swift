import Foundation

nonisolated class DataContainer {
    let title: String
    var messages: [String]

    init(title: String, messages: [String] = []) {
        self.title = title
        self.messages = messages
    }

    func printMessages() {
        print("==== Messages: \(title)")
        messages.forEach { print($0) }
    }

    static let shared: DataContainer = .init(title: "Shared")
}

@Observable
class ContentViewModel {
    var inputText = "" {
        didSet {
            storeAsMessage(inputText)
        }
    }

    func storeAsMessage(_ message: String) {

    }
}
