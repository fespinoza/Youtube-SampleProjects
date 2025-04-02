import Foundation

public struct DiscoverMovieResponse: Decodable {
    public let page: Int
    public let results: [MovieSummary]

    public init(page: Int, results: [MovieSummary]) {
        self.page = page
        self.results = results
    }
}
