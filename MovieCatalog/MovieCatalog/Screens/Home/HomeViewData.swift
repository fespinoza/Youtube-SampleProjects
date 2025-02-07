import SwiftUI

struct HomeViewData: Equatable {
    let featuredMovies: [FeatureMovieViewData]
    let newMovies: [MovieCardViewData]
    let topRatedMovies: [MovieCardViewData]
    let upcomingMovies: [MovieCardViewData]
}

extension HomeViewData {
    static func previewValue(
        featuredMovies: [FeatureMovieViewData] = [
            .theApprentice(),
            .gladiatorTwo(),
            .eternalSunshine(),
        ],
        newMovies: [MovieCardViewData] = [
            .eternalSunshine(),
            .gladiatorTwo(),
            .kindaPregnant(),
            .theApprentice(),
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
