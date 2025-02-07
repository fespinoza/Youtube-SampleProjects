import Foundation
import Tagged

typealias ActorID = Tagged<CastMember, Int>

struct ActorDetails: Decodable {
    let id: ActorID
    let name: String
    let profilePath: String?
    let biography: String
    let movieCredits: MovieCredits
}

extension ActorDetails {
    struct MovieCredits: Decodable {
        let cast: [MovieSummary]
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
