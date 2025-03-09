import Foundation

struct DiscoverMovieResponse: Decodable {
    let page: Int
    let results: [MovieSummary]
}
