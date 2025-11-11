import MovieComponents
import SwiftUI

struct HomeScreen: View {
    @State var loadingState: BasicLoadingState<HomeViewData> = .idle

    @Environment(GenreStore.self) private var genreStore
    @Environment(\.movieDataClient.homeData) private var homeData

    var body: some View {
        BasicStateView(
            state: $loadingState,
            dataContent: { viewData in
                HomeView(viewData: viewData)
            },
            fetchData: { try await homeData(genreStore) }
        )
        .navigationTitle("Movies")
    }
}

#Preview {
    NavigationStack {
        HomeScreen()
    }
    .environment(GenreStore.preview())
    .environment(\.movieDataClient.homeData) { _ in
        HomeViewData.previewValue()
    }
}
