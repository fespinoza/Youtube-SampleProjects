import SwiftUI

struct DismissButtonModifier: ViewModifier {
    @Environment(\.dismiss) var dismiss

    func body(content: Content) -> some View {
        content.toolbar {
            Button(action: { dismiss() }) {
                Text("Close")
            }
        }
    }
}

extension View {
    public func addDismissButton() -> some View {
        modifier(DismissButtonModifier())
    }
}
