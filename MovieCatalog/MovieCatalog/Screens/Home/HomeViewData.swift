import SwiftUI

struct HomeViewData: Equatable {
    let featuredMovies: [FeatureMovieViewData]
    let newMovies: [MovieCardViewData]
    let topRatedMovies: [MovieCardViewData]
    let upcomingMovies: [MovieCardViewData]
}

extension HomeViewData {
    static func build(from dto: HomeData, genreStore: GenreStore) -> Self {
        let featured: [FeatureMovieViewData] = dto.featuredMovies.map { movie in
            .build(from: movie, genreStore: genreStore)
        }

        let newMovies = dto.newMovies.map(MovieCardViewData.basic(from:))
        let topRatedMovies: [MovieCardViewData] = dto.topRatedMovies.enumerated().map { index, movie in
            .ranking(from: movie, ranking: index + 1)
        }
        let upcomingMovies: [MovieCardViewData] = dto.upcomingMovies.map { .upcoming(from: $0) }

        return .init(
            featuredMovies: featured,
            newMovies: newMovies,
            topRatedMovies: topRatedMovies,
            upcomingMovies: upcomingMovies
        )
    }
}

extension HomeViewData {
    static func previewValue(
        featuredMovies: [FeatureMovieViewData] = [
            .ironMan(),
            .gladiatorTwo(),
            .eternalSunshine(),
        ],
        newMovies: [MovieCardViewData] = [
            .eternalSunshine(),
            .gladiatorTwo(),
            .kindaPregnant(),
            .ironMan(),
        ],
        topMovies: [MovieCardViewData] = [
            .previewValue(style: .ranking(ranking: "#1")),
            .previewValue(style: .ranking(ranking: "#2")),
            .previewValue(style: .ranking(ranking: "#3")),
            .previewValue(style: .ranking(ranking: "#4")),
        ],
        upcomingMovies: [MovieCardViewData] = [
            .previewValue(style: .upcoming(releaseDate: "July 4th")),
            .previewValue(style: .upcoming(releaseDate: "July 4th")),
            .previewValue(style: .upcoming(releaseDate: "July 4th")),
            .previewValue(style: .upcoming(releaseDate: "July 4th")),
        ]
    ) -> Self {
        .init(
            featuredMovies: featuredMovies,
            newMovies: newMovies,
            topRatedMovies: topMovies,
            upcomingMovies: upcomingMovies
        )
    }
}
