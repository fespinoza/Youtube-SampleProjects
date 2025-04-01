import Foundation
import Tagged

public typealias MovieID = Tagged<MovieDetails, Int>

public struct MovieDetails: Decodable {
    public let id: MovieID
    public let genres: [Genre]
    public let runtime: Int
    public let releaseDate: String
    public let title: String
    public let credits: Credits
    public let overview: String?
    public let posterPath: String?
    public let backdropPath: String?
    public let images: ImageCollection

    public init(
        id: MovieID,
        genres: [Genre],
        runtime: Int,
        releaseDate: String,
        title: String,
        credits: Credits,
        overview: String?,
        posterPath: String?,
        backdropPath: String?,
        images: ImageCollection
    ) {
        self.id = id
        self.genres = genres
        self.runtime = runtime
        self.releaseDate = releaseDate
        self.title = title
        self.credits = credits
        self.overview = overview
        self.posterPath = posterPath
        self.backdropPath = backdropPath
        self.images = images
    }
}

public extension MovieDetails {
    struct ImageCollection: Decodable {
        public let backdrops: [Backdrop]

        public init(backdrops: [Backdrop]) {
            self.backdrops = backdrops
        }

        public struct Backdrop: Decodable, Sendable, Hashable {
            public let aspectRatio: Double
            public let filePath: String

            public var imageURL: URL? {
                URL(string: "https://image.tmdb.org/t/p/w500\(filePath)")
            }
        }
    }

    struct Credits: Decodable {
        public let cast: [CastMember]

        public init(cast: [CastMember]) {
            self.cast = cast
        }
    }

    var posterURL: URL? {
        guard let posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
    }

    var backdropURL: URL? {
        guard let backdropPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath)")
    }
}
