import Foundation

public enum MovieListType: String, Sendable, Hashable {
    case popular = "New Movies"
    case topRated = "Top Rated Movies"
    case upcoming = "Upcoming Movies"
}
