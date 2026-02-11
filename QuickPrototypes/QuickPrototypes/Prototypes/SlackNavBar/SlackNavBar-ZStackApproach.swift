import SwiftUI

extension SlackNavBar {
    struct ZStackApproach: View {
        @State private var barBackgroundColor: Color = .init(red: 0, green: 0.24, blue: 0.28)
        @Environment(\.colorScheme) private var colorScheme

        private var contentBackgroundColor: Color {
            colorScheme == .dark ? Color(red: 0.11, green: 0.11, blue: 0.13) : .white
        }

        var body: some View {
            ScrollView(.vertical) {
                FakeSlackContent()
                    .background(contentBackgroundColor)
            }
            .background(barBackgroundColor)
            .toolbarTitleDisplayMode(.inline)
            .toolbar { toolbarContent }
        }

        @ToolbarContentBuilder var toolbarContent: some ToolbarContent {
            ToolbarItem(placement: .topBarLeading) { Logo() }

            ToolbarItem {
                TitleContent(text: "Hello")
            }
            .sharedBackgroundVisibility(.hidden)

            ToolbarSpacer(.fixed)

            ToolbarItemGroup(placement: .topBarTrailing) {
                TrailingContent()
            }
        }
    }
}

#Preview {
    NavigationStack {
        SlackNavBar.ZStackApproach()
    }
}
