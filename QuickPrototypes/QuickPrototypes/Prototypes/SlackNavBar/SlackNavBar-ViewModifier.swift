import SwiftUI

extension SlackNavBar {
    struct DemoAsViewModifier: View {
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
            .toolbar { toolbarContent }
            .slackNavBar(
                title: "Hello",
                navigationBarColor: barBackgroundColor,
                contentBackgroundColor: contentBackgroundColor,
            )
        }

        @ToolbarContentBuilder var toolbarContent: some ToolbarContent {
            ToolbarItem(placement: .topBarLeading) { Logo() }

            ToolbarItemGroup(placement: .topBarTrailing) {
                TrailingContent()
            }
        }
    }

    struct NavBarEffectViewModifier: ViewModifier {
        let navigationTitle: String
        let navigationBarColor: Color
        let contentBackgroundColor: Color

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

        func body(content: Content) -> some View {
            ZStack {
                VStack(spacing: 0) {
                    // color shown in the navigation bar
                    navigationBarColor
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

                content
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
            .toolbar {
                ToolbarItem {
                    TitleContent(text: navigationTitle)
                        .opacity(titleOpacity)
                }
                .sharedBackgroundVisibility(.hidden)

                ToolbarSpacer(.fixed)

                // This is very hacky, but it's to keep the modifier ⭐
                ToolbarItem(placement: .principal) { Text("") }
            }
            // ⭐, for back buttons of other screens
            .navigationTitle(navigationTitle)
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

private extension View {
    func slackNavBar(title: String, navigationBarColor: Color, contentBackgroundColor: Color) -> some View {
        modifier(
            SlackNavBar.NavBarEffectViewModifier(
                navigationTitle: title,
                navigationBarColor: navigationBarColor,
                contentBackgroundColor: contentBackgroundColor,
            ),
        )
    }
}

#Preview {
    NavigationStack {
        SlackNavBar.DemoAsViewModifier()
    }
}
