import SwiftUI
import Tagged
import Foundation

struct MovieListScreen: View {
    let listType: MovieListType
    @State private var loadingState: BasicLoadingState<[MovieCardViewData]> = .idle
    @Environment(\.movieDataClient.movieList) private var movieList

    var body: some View {
        BasicStateView(
            state: $loadingState,
            loadingContent: { ProgressView() },
            dataContent: { movies in
                MovieListView(movies: movies)
            },
            fetchData: { try await movieList(listType) }
        )
        .navigationTitle(listType.rawValue)
    }
}

#Preview {
    NavigationStack {
        MovieListScreen(listType: .popular)
    }
    .environment(\.movieDataClient, .previewClient())
}
