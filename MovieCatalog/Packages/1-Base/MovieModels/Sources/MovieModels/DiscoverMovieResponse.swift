import Foundation

public struct DiscoverMovieResponse: Decodable {
    public let page: Int
    public let results: [MovieSummary]
}
