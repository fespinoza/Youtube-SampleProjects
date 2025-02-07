import Foundation
import Tagged

typealias MovieID = Tagged<MovieDetails, Int>

struct MovieDetails: Decodable {
    let id: MovieID
    let genres: [Genre]
    let runtime: Int
    let releaseDate: String
    let title: String
    let credits: Credits
    let overview: String?
    let posterPath: String?
    let images: ImageCollection
}

extension MovieDetails {
    struct ImageCollection: Decodable {
        let backdrops: [Backdrop]

        struct Backdrop: Decodable {
            let aspectRatio: Double
            let filePath: String

            var imageURL: URL? {
                URL(string: "https://image.tmdb.org/t/p/w500\(filePath)")
            }
        }
    }

    struct Credits: Decodable {
        let cast: [CastMember]
    }

    var imageURL: URL? {
        guard let posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
    }
}
