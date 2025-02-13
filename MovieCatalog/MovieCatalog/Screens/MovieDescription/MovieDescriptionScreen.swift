import SwiftUI

struct MovieDescriptionScreen: View {
    let title: String
    let description: String

    @Environment(\.dismiss) var dismiss

    var body: some View {
        ScrollView(.vertical) {
            Text(description)
                .padding(.spacingM)
        }
        .navigationTitle(title)
    }
}

#Preview {
    NavigationStack {
        MovieDescriptionScreen(
            title: "The Apprentice",
            description: """
            A young Donald Trump, eager to make his name as a hungry scion of a wealthy family in \
            1970s New York, comes under the spell of Roy Cohn, the cutthroat attorney who would help \
            create the Donald Trump we know today. Cohn sees in Trump the perfect protégé—someone \
            with raw ambition, a hunger for success, and a willingness to do whatever it takes to win.
            """
        )
    }
}
