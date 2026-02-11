import SwiftUI

extension SlackNavBar {
    struct TrailingContent: View {
        var body: some View {
            Button(action: {}) {
                Label("Filter", systemImage: "line.horizontal.3.decrease")
            }

            Button(action: {}) {
                Label("Filter", systemImage: "person.circle")
            }
        }
    }
}
