import MovieComponents
import MovieModels
import Navigation
import SwiftUI

struct MovieSearchView: View {
    let genres: [GenreViewData]
    @Binding var searchText: String
    let recentSearches: [String]
    let results: BasicLoadingState<[SearchResultViewData]>
    var actions: SearchContentViewActions?
    @Environment(\.isSearching) private var isSearching

    var body: some View {
        if isSearching {
            SearchContentView(
                searchText: $searchText,
                recentSearches: recentSearches,
                results: results,
                actions: actions
            )
        } else {
            SearchCategoriesView(genres: genres)
        }
    }
}
