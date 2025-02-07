import SwiftUI

struct HomeScreen: View {
    @State var loadingState: BasicLoadingState<HomeViewData> = .idle
    @Environment(GenreStore.self) private var genreStore

    var body: some View {
        BasicStateView(
            state: $loadingState,
            loadingContent: { ProgressView() },
            dataContent: { viewData in
                HomeView(viewData: viewData)
            },
            fetchData: {
                try await MovieDBClient().fetchHomeData(genreStore: genreStore)
            }
        )
        .navigationTitle("Movies")
    }
}

#Preview {
    HomeScreen()
        .environment(GenreStore.preview())
}
