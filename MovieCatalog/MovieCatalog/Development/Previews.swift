import SwiftUI
import Navigation

extension View {
    func previewEnvironment() -> some View {
        environment(GenreStore.preview())
        .environment(\.movieDataClient, .previewClient())
        .environment(Router.previewRouter())
    }
}
