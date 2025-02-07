import Foundation

enum MovieListType: Hashable {
    case popular
    case topRated
    case upcoming

    var viewData: MovieListTypeViewData {
        switch self {
        case .topRated: .topRated
        case .popular: .popular
        case .upcoming: .upcoming
        }
    }
}

struct MovieListTypeViewData {
    let title: String
    let fetchMovies: () async throws -> [MovieCardViewData]

    static let popular: Self = .init(title: "New Movies") {
        let dto = try await MovieDBClient().popularMovies()
        return dto.map(MovieCardViewData.basic(from:))
    }

    static let topRated: Self = .init(title: "Top Rated Movies", fetchMovies: {
        let dto = try await MovieDBClient().topRatedMovies()
        return dto.enumerated().map { (index, movie) in
            .ranking(from: movie, ranking: index + 1)
        }
    })

    static let upcoming: Self = .init(title: "Upcoming Movies", fetchMovies: {
        let dto = try await MovieDBClient().upcomingMovies()
        return dto.map(MovieCardViewData.upcoming(from:))
    })
}
