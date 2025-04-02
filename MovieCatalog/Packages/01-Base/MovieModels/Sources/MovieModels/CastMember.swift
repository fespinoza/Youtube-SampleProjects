import Foundation

public struct CastMember: Decodable {
    public let id: ActorID
    public let name: String
    public let character: String
    public let profilePath: String?

    public init(id: ActorID, name: String, character: String, profilePath: String?) {
        self.id = id
        self.name = name
        self.character = character
        self.profilePath = profilePath
    }
}

public extension CastMember {
    var profilePictureSmall: URL? {
        guard let profilePath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w185\(profilePath)")
    }

    var profilePictureMedium: URL? {
        guard let profilePath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(profilePath)")
    }
}
