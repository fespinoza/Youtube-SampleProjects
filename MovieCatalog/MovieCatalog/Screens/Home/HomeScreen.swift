import MovieComponents
import SwiftUI
import Navigation

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
        .toolbar {
            ToolbarItem {
                NavigationButton(push: .pushNotificationsDebug) {
                    Image(systemName: "bell")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        HomeScreen()
    }
    .previewEnvironment()
    .environment(\.movieDataClient.homeData) { _ in
        HomeViewData.previewValue()
    }
}
