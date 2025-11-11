import MovieComponents
import Navigation
import SwiftUI

@MainActor protocol SearchContentViewActions: AnyObject {
    func select(recentSearch: String)
    func delete(recentSearch: String)
}

struct SearchContentView: View {
    @Binding var searchText: String
    let recentSearches: [String]
    let results: BasicLoadingState<[SearchResultViewData]>
    var actions: SearchContentViewActions?

    var body: some View {
        if searchText.isEmpty {
            if recentSearches.isEmpty {
                ContentUnavailableView(
                    label: {
                        Label("Content Search", systemImage: "magnifyingglass")
                    },
                    description: {
                        Text(
                            "Search for movies by title or actors by name",
                            bundle: .module,
                            comment: "Empty content description"
                        )
                    }
                )
            } else {
                List {
                    ForEach(recentSearches, id: \.self) { recentSearch in
                        Button(action: { actions?.select(recentSearch: recentSearch) }) {
                            Label {
                                Text(recentSearch)
                                    .foregroundStyle(Color.primary)
                            } icon: {
                                Image(systemName: "magnifyingglass")
                                    .foregroundStyle(Color.secondary)
                            }
                            .font(.callout)
                        }
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                actions?.delete(recentSearch: recentSearch)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                }
            }
        } else {
            searchResultsState
        }
    }

    @ViewBuilder var searchResultsState: some View {
        switch results {
        case .idle:
            Color.clear

        case .loading:
            ProgressView()

        case let .dataLoaded(content) where content.isEmpty:
            ContentUnavailableView(
                label: {
                    Label("No matches", systemImage: "questionmark.circle")
                },
                description: {
                    Text(
                        "No results found for '\(searchText)', try to search for something else",
                        bundle: .module,
                        comment: "No results found description"
                    )
                }
            )

        case let .dataLoaded(content):
            List { // TODO: pagination of search results
                ForEach(content) { result in
                    SearchResultCell(viewData: result)
                }
            }

        case let .error(error):
            ContentUnavailableView(
                label: {
                    Label("Error", systemImage: "xmark")
                        .foregroundStyle(.primary, .red)
                },
                description: {
                    Text(error.localizedDescription)
                }
            )
        }
    }
}

private struct Demo: View {
    @State var searchText: String = "Hello"
    @State var recentSearches: [String] = []
    @State var results: BasicLoadingState<[SearchResultViewData]> = .dataLoaded(
        [
            .movie(.previewValue()),
            .movie(.previewValue()),
            .actor(.previewValue()),
        ]
    )

    var body: some View {
        NavigationStack {
            SearchContentView(
                searchText: $searchText,
                recentSearches: recentSearches,
                results: results
            )
            .navigationTitle("Search")
        }
        .searchable(text: $searchText)
        .environment(Router.previewRouter())
    }
}

#Preview("Search results") {
    Demo()
}

#Preview("Loading") {
    Demo(results: .loading)
}

#Preview("Empty") {
    Demo(results: .dataLoaded([]))
}

#Preview("Error") {
    Demo(results: .error(CancellationError()))
}

#Preview("Nothing search yet, No recent searches") {
    Demo(searchText: "", results: .idle)
}

#Preview("Nothing search yet, Recent searches") {
    Demo(searchText: "", recentSearches: ["Hello", "World", "Foo Bar"], results: .idle)
}
