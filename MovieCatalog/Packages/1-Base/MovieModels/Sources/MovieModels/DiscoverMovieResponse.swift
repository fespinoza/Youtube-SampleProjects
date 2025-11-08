import Foundation

public struct DiscoverMovieResponse: Decodable, Hashable {
    public let page: Int
    public let results: [MovieSummary]
}
