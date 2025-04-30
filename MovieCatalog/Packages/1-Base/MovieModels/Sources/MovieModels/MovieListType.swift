import Foundation

public enum MovieListType: Sendable, Hashable {
    case popular
    case topRated
    case upcoming
    case genre(_ genre: Genre)

    public var title: String {
        switch self {
        case .popular: "New Movies"
        case .topRated: "Top Rated Movies"
        case .upcoming: "Upcoming Movies"
        case let .genre(genre): "\(genre.name) Movies"
        }
    }
}
