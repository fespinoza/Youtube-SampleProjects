import Foundation
import MovieModels

struct MovieDBClient {
    func homeData() async throws -> HomeData {
        async let popular = popularMovies()
        async let topRated = topRatedMovies()
        async let upcoming = upcomingMovies()

        var resolvedPopular = try await popular

        let featured = Array(resolvedPopular.prefix(5))
        resolvedPopular.removeFirst(5)

        return try await .init(
            featuredMovies: featured,
            newMovies: popular,
            topRatedMovies: topRated,
            upcomingMovies: upcoming
        )
    }

    func popularMovies() async throws -> [MovieSummary] {
        let url = try url(
            for: "/discover/movie",
            params: [
                .init(name: "sort_by", value: "popularity.desc"),
            ]
        )
        let container: DiscoverMovieResponse = try await fetch(url)
        return container.results
    }

    func topRatedMovies() async throws -> [MovieSummary] {
        let url = try url(
            for: "/discover/movie",
            params: [
                .init(name: "sort_by", value: "vote_average.desc"),
                .init(name: "without_genres", value: "99,10755"),
                .init(name: "vote_count.gte", value: "200"),
            ]
        )
        let container: DiscoverMovieResponse = try await fetch(url)
        return container.results
    }

    func upcomingMovies() async throws -> [MovieSummary] {
        let url = try url(
            for: "/discover/movie",
            params: [
                .init(name: "sort_by", value: "popularity.desc"),
                .init(name: "with_release_type", value: "3"),
                .init(name: "primary_release_date.gte", value: Utils.formattedRequestDate(from: Date())),
                .init(name: "with_original_language", value: "en"),
            ]
        )
        let container: DiscoverMovieResponse = try await fetch(url)
        return container.results
    }

    func movieDetails(for movieID: MovieID) async throws -> MovieDetails {
        let url = try url(
            for: "/movie/\(movieID)",
            params: [
                .init(name: "include_image_language", value: "en"),
                .init(name: "append_to_response", value: "images,credits"),
            ]
        )
        return try await fetch(url)
    }

    func genres() async throws -> [Genre] {
        let url = try url(for: "/genre/movie/list")
        let container: GenreContainer = try await fetch(url)
        return container.genres
    }

    func actorDetails(for actorID: ActorID) async throws -> ActorDetails {
        let url = try url(
            for: "/person/\(actorID)",
            params: [
                .init(name: "append_to_response", value: "movie_credits"),
            ]
        )
        return try await fetch(url)
    }

    enum EndpointError: Error {
        case failedToCreateURL(path: String)
    }

    private func url(for path: String, params: [URLQueryItem] = []) throws -> URL {
        guard var components = URLComponents(
            url: Config.baseURL.appending(path: path),
            resolvingAgainstBaseURL: true
        ) else {
            throw EndpointError.failedToCreateURL(path: path)
        }

        components.queryItems = [
            .init(name: "api_key", value: Config.apiKey),
            .init(name: "language", value: "en-US"),
        ] + params

        guard let url = components.url else {
            throw EndpointError.failedToCreateURL(path: path)
        }

        return url
    }

    private func fetch<T: Decodable>(_ url: URL) async throws -> T {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = ["accept": "application/json"]

        let (data, _) = try await URLSession.shared.data(for: request)
        return try Config.decoder.decode(T.self, from: data)
    }
}
