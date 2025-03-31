import Foundation

struct CastMember: Decodable {
    let id: ActorID
    let name: String
    let character: String
    let profilePath: String?
}

extension CastMember {
    var profilePictureSmall: URL? {
        guard let profilePath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w185\(profilePath)")
    }

    var profilePictureMedium: URL? {
        guard let profilePath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(profilePath)")
    }
}
