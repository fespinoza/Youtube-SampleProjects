import SwiftUI

struct MovieDescriptionScreen: View {
    let title: String
    let description: String

    var body: some View {
        ScrollView(.vertical) {
            Text(description)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.spacingM)
        }
        .navigationTitle(title)
    }
}

#Preview {
    NavigationStack {
        MovieDescriptionScreen(
            title: "Iron Man",
            description: """
            After being held captive in an Afghan cave, billionaire engineer Tony Stark creates a unique weaponized \
            suit of armor to fight evil.
            """
        )
    }
}
