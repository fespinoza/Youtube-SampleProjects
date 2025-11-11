import Foundation
import MovieComponents
import MovieModels
import SwiftUI
import Tagged

struct MovieListScreen: View {
    let listType: MovieListType
    @State private var loadingState: BasicLoadingState<[MovieCardViewData]> = .idle
    @Environment(\.movieDataClient.movieList) private var movieList

    var body: some View {
        BasicStateView(
            state: $loadingState,
            dataContent: { movies in
                MovieListView(movies: movies)
            },
            fetchData: { try await movieList(listType) }
        )
        .navigationTitle(listType.title)
    }
}

#Preview {
    NavigationStack {
        MovieListScreen(listType: .popular)
    }
    .environment(\.movieDataClient, .previewClient())
}
