import Foundation
import Tagged

typealias MovieID = Tagged<MovieSummary, Int>

struct MovieSummary: Decodable, Identifiable {
    let backdropPath: String?
    let id: MovieID
    let overview: String?
    let posterPath: String?
    let title: String
    let releaseDate: String?
    let genreIds: [GenreID]
}

extension MovieSummary {
    var posterURL: URL? {
        guard let posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
    }

    var backdropURL: URL? {
        guard let backdropPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath)")
    }
}
