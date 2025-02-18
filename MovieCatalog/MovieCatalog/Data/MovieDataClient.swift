import SwiftUI

struct MovieDataClient {
    var homeData: (GenreStore) async throws -> HomeViewData
    var popularMovies: () async throws -> [MovieCardViewData]
    var actorDetails: (ActorID) async throws -> ActorDetailsViewData
    var movieList: (MovieListType) async throws -> [MovieCardViewData]
    var releaseCalendar: (GenreStore) async throws -> [ReleaseMonthViewData]

    static let dbClient: MovieDataClient = .init(
        homeData: { genreStore in
            let dto = try await MovieDBClient().homeData()
            return .build(from: dto, genreStore: genreStore)
        },
        popularMovies: {
            let dto = try await MovieDBClient().popularMovies()
            return dto.map(MovieCardViewData.basic(from:))
        },
        actorDetails: { actorID in
            let dto = try await MovieDBClient().actorDetails(for: actorID)
            return .init(dto: dto)
        },
        movieList: { listType in
            let client = MovieDBClient()

            return switch listType {
            case .popular:
                try await client.popularMovies().map(MovieCardViewData.basic(from:))

            case .topRated:
                try await client.topRatedMovies().enumerated().map { index, movie in
                    .ranking(from: movie, ranking: index + 1)
                }

            case .upcoming:
                try await client.upcomingMovies().map(MovieCardViewData.upcoming(from:))
            }
        },
        releaseCalendar: { genreStore in
            let dto = try await MovieDBClient().upcomingMovies()
            return ReleaseMonthViewData.buildCollection(from: dto, genreStore: genreStore)
        }
    )

    static func previewClient() -> MovieDataClient {
        .init(
            homeData: { _ in .previewValue() },
            popularMovies: { [.eternalSunshine(), .gladiatorTwo(), .theApprentice()] },
            actorDetails: { _ in .previewValue() },
            movieList: { _ in [.eternalSunshine(), .gladiatorTwo(), .theApprentice()] },
            releaseCalendar: { _ in [.previewValue()] }
        )
    }
}

extension EnvironmentValues {
    @Entry var movieDataClient: MovieDataClient = .dbClient
}
