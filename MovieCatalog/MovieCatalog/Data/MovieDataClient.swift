import SwiftUI
import MovieModels
import MovieDBNetworking
import MovieComponents
import PreviewData

struct MovieDataClient: Sendable{
    var homeData: @Sendable (GenreStore) async throws -> HomeViewData
    var popularMovies: @Sendable () async throws -> [MovieCardViewData]
    var actorDetails: @Sendable (ActorID) async throws -> ActorDetailsViewData
    var movieDescription: @Sendable (MovieID) async throws -> (title: String, description: String)
    var movieGallery: @Sendable (MovieID) async throws -> [ImageContainerViewData]
    var movieList: @Sendable (MovieListType) async throws -> [MovieCardViewData]
    var releaseCalendar: @Sendable (GenreStore) async throws -> [ReleaseMonthViewData]

    static let dbClient: MovieDataClient = .init(
        homeData: { genreStore in
            let dto = try await MovieDBClient().homeData()
            return await .build(from: dto, genreStore: genreStore)
        },
        popularMovies: {
            let dto = try await MovieDBClient().popularMovies()
            return dto.map(MovieCardViewData.basic(from:))
        },
        actorDetails: { actorID in
            let dto = try await MovieDBClient().actorDetails(for: actorID)
            return .init(dto: dto)
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

            case let .genre(genre):
                try await client.moviesBy(genre: genre).map(MovieCardViewData.basic(from:))
            }
        },
        releaseCalendar: { genreStore in
            let dto = try await MovieDBClient().upcomingMovies()
            return await ReleaseMonthViewData.buildCollection(from: dto, genreStore: genreStore)
        }
    )

    static func previewClient() -> MovieDataClient {
        .init(
            homeData: { _ in .previewValue() },
            popularMovies: { [.eternalSunshine(), .gladiatorTwo(), .ironMan()] },
            actorDetails: { _ in .previewValue() },
            movieDescription: { _ in
                return (
                    title: "Iron Man",
                    description: """
                    After being held captive in an Afghan cave, billionaire engineer Tony Stark creates a unique weaponized \
                    suit of armor to fight evil.
                    """
                )
            },
            movieGallery: { _ in
                [
                    .previewValue(image: .image(Image(preview: .Gallery.IronMan.image1))),
                    .previewValue(image: .image(Image(preview: .Gallery.IronMan.image2))),
                    .previewValue(image: .image(Image(preview: .Gallery.IronMan.image3))),
                    .previewValue(image: .image(Image(preview: .Gallery.IronMan.image4))),
                ]
            },
            movieList: { _ in [.eternalSunshine(), .gladiatorTwo(), .ironMan()] },
            releaseCalendar: { _ in [.previewValue()] }
        )
    }
}

extension EnvironmentValues {
    @Entry var movieDataClient: MovieDataClient = .dbClient
}
