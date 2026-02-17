import SwiftUI

// Experiment with large titles + safe area bar

extension SlackNavBar {
    struct ZStackApproach_NoTitle: View {
        @State private var barBackgroundColor: Color = .init(red: 0, green: 0.24, blue: 0.28)
        @Environment(\.colorScheme) private var colorScheme

        private var contentBackgroundColor: Color {
            colorScheme == .dark ? Color(red: 0.11, green: 0.11, blue: 0.13) : .white
        }

        /// Tracks the offset Y for the scroll view
        @State private var offsetY: CGFloat = 0

        let customBarBackgroundHeight: CGFloat = 300

        /// Dynamic offset of the navigation bar background, which will change
        /// as scroll view offset changes
        var barOffset: CGFloat {
            -(offsetY + customBarBackgroundHeight)
        }

        var body: some View {
            ZStack {
                VStack(spacing: 0) {
                    // color shown in the navigation bar
                    barBackgroundColor
                        .frame(height: customBarBackgroundHeight)
                        // this is how the content scrolls away, without
                        // being part of the scroll view
                        .offset(y: barOffset)
                        .ignoresSafeArea(.container)

                    // It's important that this color is clear
                    // to avoid weird color effects due to the bar
                    // background scrolling away, then it shows through
                    // the actual view background ⭐
                    Color.clear
                        .frame(maxWidth: .infinity)
                }

                ScrollView(.vertical) {
                    FakeSlackContent()
                        .background(contentBackgroundColor)
                }
                // we track the offset of the scroll view
                .onScrollGeometryChange(
                    for: CGFloat.self,
                    of: { $0.contentOffset.y },
                    action: { _, newValue in
                        offsetY = newValue
                    },
                )
            }
            // view background ⭐
            .background(contentBackgroundColor)
            .overlay { debugValues }
            .toolbar { toolbarContent }
            .navigationTitle("Hello")
        }

        @ToolbarContentBuilder var toolbarContent: some ToolbarContent {
            ToolbarItem(placement: .topBarLeading) { Logo() }

            ToolbarItemGroup(placement: .topBarTrailing) {
                TrailingContent()
            }
        }

        var debugValues: some View {
            Text("\(offsetY)\n\(barOffset)")
                .monospacedDigit()
                .padding()
                .background(Color.red)
                .offset()
        }
    }
}

#Preview {
    NavigationStack {
        SlackNavBar.ZStackApproach_NoTitle()
    }
}
