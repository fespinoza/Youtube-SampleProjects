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
}

public extension MovieDetails {
    struct ImageCollection: Decodable {
        public let backdrops: [Backdrop]

        public struct Backdrop: Decodable, Hashable {
            public let aspectRatio: Double
            public let filePath: String

            public var imageURL: URL? {
                URL(string: "https://image.tmdb.org/t/p/w500\(filePath)")
            }
        }
    }

    struct Credits: Decodable {
        public let cast: [CastMember]
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
