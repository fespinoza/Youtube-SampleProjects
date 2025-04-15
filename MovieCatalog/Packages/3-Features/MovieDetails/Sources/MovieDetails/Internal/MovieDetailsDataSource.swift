import SwiftUI
import MovieModels
import MovieComponents
import MovieDBNetworking

struct MovieDetailsDataSource: Sendable {
    var movieDetails: @Sendable (MovieID) async throws -> MovieDetailsViewData

    static let live: MovieDetailsDataSource = .init(
        movieDetails: { @MainActor movieID in
            let dto = try await MovieDBClient().movieDetails(for: movieID)
            return MovieDetailsViewData(dto: dto)
        }
    )

    static func previewClient() -> MovieDetailsDataSource {
        .init(movieDetails: { @MainActor _ in .previewValue() })
    }
}

extension EnvironmentValues {
    @Entry var movieDetailsDataSource: MovieDetailsDataSource = .live
}
