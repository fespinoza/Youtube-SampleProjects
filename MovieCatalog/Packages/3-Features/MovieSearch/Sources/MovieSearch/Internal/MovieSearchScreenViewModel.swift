import Config
import SwiftUI
import Combine
import MovieComponents
import OSLog

@MainActor
class MovieSearchScreenViewModel: ObservableObject {
    @Published var searchText: String
    @Published var sectionsState: BasicLoadingState<[GenreViewData]>
    @Published var searchResults: BasicLoadingState<[SearchResultViewData]>
    @Published var recentSearches: [String]
    var fetchResults: ((String) async throws -> [SearchResultViewData])?
    private var currentSearchTask: Task<Void, Never>?
    var observations: Set<AnyCancellable> = []
    private let logger: os.Logger = .forCategory("Search")
    private let userDefaults: UserDefaults
    private static let recentSearchesKey = "_recentSearches"

    init(
        searchText: String = "",
        sectionsState: BasicLoadingState<[GenreViewData]> = .idle,
        searchResults: BasicLoadingState<[SearchResultViewData]> = .idle,
        recentSearches: [String]? = nil,
        userDefaults: UserDefaults = .standard
    ) {
        self.searchText = searchText
        self.sectionsState = sectionsState
        self.searchResults = searchResults
        self.userDefaults = userDefaults
        self.recentSearches = recentSearches ?? Self.loadRecentSearches(from: userDefaults)

        setupObservations()
    }

    private func setupObservations() {
        // with delay, search for the text and cancel any
        // ongoing searches
        $searchText
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink(receiveValue: { [weak self] _ in
                guard let self else { return }

                currentSearchTask?.cancel()
                currentSearchTask = Task { await self.refreshSearchResults() }
            })
            .store(in: &observations)

        // immediately remove the cached results on search
        $searchText
            .dropFirst()
            .removeDuplicates()
            .sink { [weak self] _ in
                self?.searchResults = .loading
            }
            .store(in: &observations)

        $recentSearches
            .sink { [weak userDefaults] value in
                userDefaults?.set(value, forKey: Self.recentSearchesKey)
            }
            .store(in: &observations)
    }

    private func refreshSearchResults() async {
        guard let fetchResults else { return }

        if searchText.isEmpty {
            searchResults = .dataLoaded([])
            return
        }

        searchResults = .loading
        do {
            let results = try await fetchResults(searchText)
            searchResults = .dataLoaded(results)
            storeSearch(searchText)

        } catch {
            logger.error("\(error)")
            searchResults = .error(error)
        }
    }

    private func storeSearch(_ text: String) {
        guard !recentSearches.contains(text) else { return }

        if recentSearches.count >= 9 {
            recentSearches.removeLast()
        }

        // TODO: maybe check that the search doesn't have a prefix already there

        recentSearches.insert(text, at: 0)
    }

    private func persistRecentSearches(_ value: [String]) {
        logger.debug("Persisted recent searches \(value.count)")
        userDefaults.set(value, forKey: Self.recentSearchesKey)
    }

    private static func loadRecentSearches(from userDefaults: UserDefaults) -> [String] {
        userDefaults.value(forKey: recentSearchesKey) as? [String] ?? []
    }
}

extension MovieSearchScreenViewModel: SearchContentViewActions {
    func select(recentSearch: String) {
        searchText = recentSearch
    }

    func delete(recentSearch: String) {
        recentSearches.removeAll(where: { $0 == recentSearch })
    }
}
