import SwiftUI
import MovieModels
import MovieComponents
import MovieDBNetworking

struct MovieDataClient {
    var homeData: (GenreStore) async throws -> HomeViewData
    var popularMovies: () async throws -> [MovieCardViewData]
    var actorDetails: (ActorID) async throws -> ActorDetailsViewData
    var movieDetails: (MovieID) async throws -> MovieDetailsViewData
    var movieDescription: (MovieID) async throws -> (title: String, description: String)
    var movieGallery: (MovieID) async throws -> [ImageContainerViewData]
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
        movieDetails: { movieID in
            let dto = try await MovieDBClient().movieDetails(for: movieID)
            return MovieDetailsViewData(dto: dto)
        },
        movieDescription: { movieID in
            let dto = try await MovieDBClient().movieDetails(for: movieID)
            return (
                title: dto.title,
                description: dto.overview ?? ""
            )
        },
        movieGallery: { movieID in
            let dto = try await MovieDBClient().movieDetails(for: movieID)
           return ImageContainerViewData.galleryItems(for: dto)
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
            popularMovies: { [.eternalSunshine(), .gladiatorTwo(), .ironMan()] },
            actorDetails: { _ in .previewValue() },
            movieDetails: { _ in .previewValue() },
            movieDescription: { _ in
                let movie = MovieDetailsViewData.previewValue()
                return (title: movie.title, description: movie.description)
            },
            movieGallery: { _ in
                MovieDetailsViewData.previewValue().galleryItems
            },
            movieList: { _ in [.eternalSunshine(), .gladiatorTwo(), .ironMan()] },
            releaseCalendar: { _ in [.previewValue()] }
        )
    }
}

extension EnvironmentValues {
    @Entry var movieDataClient: MovieDataClient = .dbClient
}
