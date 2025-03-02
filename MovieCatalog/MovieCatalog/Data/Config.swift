import Foundation

enum Config {
    static let apiKey: String = {
        guard let apiKey = Bundle.main.infoDictionary?["MOVIE_API_KEY"] as? String else {
            fatalError("Set an API_KEY value in BaseConfig.xcconfig or check the README")
        }
        return apiKey
    }()

    static let decoder: JSONDecoder = {
        var decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

    static let baseURL: URL = .init(string: "https://api.themoviedb.org/3")!

    static let bundleID = "com.fespinozacast.youtube.MovieCatalog"

    static let deepLinkScheme: String = "moviecat"
}
