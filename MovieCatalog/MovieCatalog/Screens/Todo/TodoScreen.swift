import SwiftUI

struct TodoScreen: View {
    let title: String

    var body: some View {
        ContentUnavailableView(
            "\(title) not available yet",
            systemImage: "exclamationmark.triangle",
            description: Text("It's part of my plan, but I haven't get to it yet")
        )
    }
}

#Preview {
    TodoScreen(title: "TODO")
}
