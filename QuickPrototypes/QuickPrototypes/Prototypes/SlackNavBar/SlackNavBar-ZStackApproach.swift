import SwiftUI

extension SlackNavBar {
    struct ZStackApproach: View {
        @State private var barBackgroundColor: Color = .init(red: 0, green: 0.24, blue: 0.28)
        @Environment(\.colorScheme) private var colorScheme

        private var contentBackgroundColor: Color {
            colorScheme == .dark ? Color(red: 0.11, green: 0.11, blue: 0.13) : .white
        }

        /// Tracks the offset Y for the scroll view
        @State private var offsetY: CGFloat = 0

        /// Tracks the initial offset value, which is relative to the top of the screen
        @State private var initialOffsetY: CGFloat = 0

        let customBarBackgroundHeight: CGFloat = 300

        /// Dynamic offset of the navigation bar background, which will change
        /// as scroll view offset changes
        var barOffset: CGFloat {
            -(offsetY + customBarBackgroundHeight)
        }

        /// Dynamic opacity of the title for the desired effect
        var titleOpacity: Double {
            min(1.0, max(0.0, 1.0 - (offsetY - initialOffsetY) / 9.0))
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
                        // for this effect, the initial offset will never be 0
                        // then I use it as a placeholder value to avoid an optional
                        // on appear, this closure will be called and we record that
                        // initial value that won't be 0
                        if initialOffsetY == 0 {
                            initialOffsetY = newValue
                        }
                    },
                )
            }
            // view background ⭐
            .background(contentBackgroundColor)
            .overlay { debugValues }
            // to ensure the effect works when the view changes orientations
            .onGeometryChange(
                for: CGFloat.self,
                of: { $0.size.width },
                action: { oldValue, newValue in
                    if oldValue != newValue {
                        initialOffsetY = 0
                    }
                },
            )
            .toolbarTitleDisplayMode(.inline)
            .toolbar { toolbarContent }
        }

        @ToolbarContentBuilder var toolbarContent: some ToolbarContent {
            ToolbarItem(placement: .topBarLeading) { Logo() }

            ToolbarItem {
                TitleContent(text: "Hello")
                    .opacity(titleOpacity)
            }
            .sharedBackgroundVisibility(.hidden)

            ToolbarSpacer(.fixed)

            ToolbarItemGroup(placement: .topBarTrailing) {
                TrailingContent()
            }
        }

        var debugValues: some View {
            Text("\(offsetY)\n\(barOffset)\n\(initialOffsetY)")
                .monospacedDigit()
                .padding()
                .background(Color.red)
                .offset()
        }
    }
}

#Preview {
    NavigationStack {
        SlackNavBar.ZStackApproach()
    }
}
