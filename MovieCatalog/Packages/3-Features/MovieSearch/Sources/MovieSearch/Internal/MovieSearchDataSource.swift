import MovieDBNetworking
import SwiftUI

struct MovieSearchDataSource {
    let genres: @Sendable () async throws -> [GenreViewData]
    let search: @Sendable (String) async throws -> [SearchResultViewData]

    static let live: MovieSearchDataSource = .init(
        genres: {
            try await MovieDBClient().genres().map(GenreViewData.init(dto:))
        },
        search: { text in
            try await MovieDBClient().searchMoviesOrActors(text: text).map(SearchResultViewData.init(dto:))
        }
    )

    static func preview(delay: TimeInterval = 2) -> MovieSearchDataSource {
        .init(
            genres: {
                try await Task.sleep(for: .seconds(delay))
                return GenreViewData.sampleCollection
            },
            search: { _ in
                try await Task.sleep(for: .seconds(delay))
                return [
                    .movie(.previewValue()),
                    .movie(.previewValue()),
                    .movie(.previewValue()),
                    .movie(.previewValue()),
                    .movie(.previewValue())
                ]
            }
        )
    }
}

extension EnvironmentValues {
    @Entry var searchDataSource: MovieSearchDataSource = .live
}
