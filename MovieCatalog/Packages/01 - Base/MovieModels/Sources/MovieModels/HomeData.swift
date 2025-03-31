import Foundation

struct HomeData: Decodable {
    let featuredMovies: [MovieSummary]
    let newMovies: [MovieSummary]
    let topRatedMovies: [MovieSummary]
    let upcomingMovies: [MovieSummary]
}
