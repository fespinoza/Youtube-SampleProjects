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

    public init(
        backdropPath: String?,
        id: MovieID,
        overview: String?,
        posterPath: String?,
        title: String,
        releaseDate: String?,
        genreIds: [GenreID]
    ) {
        self.backdropPath = backdropPath
        self.id = id
        self.overview = overview
        self.posterPath = posterPath
        self.title = title
        self.releaseDate = releaseDate
        self.genreIds = genreIds
    }
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

    var assertReleaseDate: Date {
        Utils.parseReleaseDate(from: releaseDate) ?? Date()
    }
}

private enum Utils {
    static let releaseDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter
    }()

    static func parseReleaseDate(from dateString: String?) -> Date? {
        guard
            let dateString,
            let date = releaseDateFormatter.date(from: dateString)
        else { return nil }

        return date
    }
}
