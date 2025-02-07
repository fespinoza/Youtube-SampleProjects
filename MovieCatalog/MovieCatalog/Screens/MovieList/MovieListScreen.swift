import SwiftUI
import Tagged
import Foundation

struct MovieListScreen: View {
    let listType: MovieListTypeViewData
    @State private var loadingState: BasicLoadingState<[MovieCardViewData]> = .idle

    var body: some View {
        BasicStateView(
            state: $loadingState,
            loadingContent: { ProgressView() },
            dataContent: { movies in
                MovieListView(movies: movies)
            },
            fetchData: listType.fetchMovies
        )
        .navigationTitle(listType.title)
    }
}

#Preview {
    NavigationStack {
        MovieListScreen(listType: .popular)
    }
}
