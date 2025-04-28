import SwiftUI

struct TestContainerView<Content: View>: View {
    let variant: SnapshotVariant
    @ViewBuilder var content: () -> Content

    var body: some View {
        Group {
            if let navigationBar = variant.navigationBar {
                NavigationStack {
                    content()
                        .navigationBarTitle(navigationBar.title, displayMode: navigationBar.titleDisplayMode)
                }
            } else {
                content()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .environment(\.dynamicTypeSize, variant.dynamicTypeSize)
        .environment(\.colorScheme, variant.colorScheme)
        .environment(\.locale, variant.locale)
    }
}
