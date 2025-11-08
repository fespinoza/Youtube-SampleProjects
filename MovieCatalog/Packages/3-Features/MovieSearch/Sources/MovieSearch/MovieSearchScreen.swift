import MovieComponents
import Navigation
import SwiftUI

public struct MovieSearchScreen: View {
    @StateObject var viewModel: MovieSearchScreenViewModel = .init()
    @Environment(\.searchDataSource) var searchDataSource

    public init() {
        self.init(viewModel: .init())
    }

    init(viewModel: MovieSearchScreenViewModel? = nil) {
        self._viewModel = .init(wrappedValue: viewModel ?? .init())
    }

    // TODO: sort search results?

    public var body: some View {
        BasicStateView(
            state: $viewModel.sectionsState,
            dataContent: { genres in
                MovieSearchView(
                    genres: genres,
                    searchText: $viewModel.searchText,
                    recentSearches: viewModel.recentSearches,
                    results: viewModel.searchResults,
                    actions: viewModel
                )
            },
            fetchData: { try await searchDataSource.genres() }
        )
        .onAppear {
            viewModel.fetchResults = searchDataSource.search
        }
        .navigationTitle("Search")
        .searchable(
            text: $viewModel.searchText,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: Text(
                "Search for Movies and Actors",
                bundle: .module,
                comment: "Search prompt"
            )
        )
    }
}

#Preview {
    NavigationStack {
        MovieSearchScreen()
    }
    .environment(\.searchDataSource, .preview(delay: 2))
    .environment(Router.previewRouter())
}
