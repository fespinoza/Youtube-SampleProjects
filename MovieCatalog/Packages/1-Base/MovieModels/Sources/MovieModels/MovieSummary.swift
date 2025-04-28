import Foundation
import Tagged

public struct MovieSummary: Decodable, Identifiable {
    public let backdropPath: String?
    public let id: MovieID
    public let overview: String?
    public let posterPath: String?
    public let title: String
    public let releaseDate: String?
    public let genreIds: [GenreID]
}

public extension MovieSummary {
    var posterURL: URL? {
        guard let posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
    }

    var backdropURL: URL? {
        guard let backdropPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath)")
    }
}
