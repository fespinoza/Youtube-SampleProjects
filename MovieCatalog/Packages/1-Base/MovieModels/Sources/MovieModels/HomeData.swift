import Foundation

public struct HomeData: Decodable, Hashable {
    public let featuredMovies: [MovieSummary]
    public let newMovies: [MovieSummary]
    public let topRatedMovies: [MovieSummary]
    public let upcomingMovies: [MovieSummary]

    public init(
        featuredMovies: [MovieSummary],
        newMovies: [MovieSummary],
        topRatedMovies: [MovieSummary],
        upcomingMovies: [MovieSummary]
    ) {
        self.featuredMovies = featuredMovies
        self.newMovies = newMovies
        self.topRatedMovies = topRatedMovies
        self.upcomingMovies = upcomingMovies
    }
}
