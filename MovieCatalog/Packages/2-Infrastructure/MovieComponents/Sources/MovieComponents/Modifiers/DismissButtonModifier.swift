import SwiftUI

public struct DismissButtonModifier: ViewModifier {
    @Environment(\.dismiss) var dismiss

    public func body(content: Content) -> some View {
        content.toolbar {
            Button(action: { dismiss() }) {
                Text("Close", bundle: .module, comment: "Close button")
            }
        }
    }
}

public extension View {
    func addDismissButton() -> some View {
        modifier(DismissButtonModifier())
    }
}
