import Foundation
import SwiftUI
import Tagged
import MovieModels

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
        .navigationTitle(listType.rawValue)
    }
}

#Preview {
    NavigationStack {
        MovieListScreen(listType: .popular)
    }
    .environment(\.movieDataClient, .previewClient())
}
