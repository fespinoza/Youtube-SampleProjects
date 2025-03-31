import Foundation
import Tagged

public typealias ActorID = Tagged<CastMember, Int>

public struct ActorDetails: Decodable {
    public let id: ActorID
    public let name: String
    public let profilePath: String?
    public let biography: String
    public let movieCredits: MovieCredits

    public init(id: ActorID, name: String, profilePath: String?, biography: String, movieCredits: MovieCredits) {
        self.id = id
        self.name = name
        self.profilePath = profilePath
        self.biography = biography
        self.movieCredits = movieCredits
    }
}

public extension ActorDetails {
    struct MovieCredits: Decodable {
        public let cast: [MovieSummary]

        public init(cast: [MovieSummary]) {
            self.cast = cast
        }
    }

    var profilePictureSmall: URL? {
        guard let profilePath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w185\(profilePath)")
    }

    var profilePictureMedium: URL? {
        guard let profilePath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(profilePath)")
    }
}
