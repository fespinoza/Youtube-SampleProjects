import Foundation
import OSLog

public struct SearchResultsContainer: Decodable, Hashable {
    public let page: Int
    public let totalPages: Int
    public let totalResults: Int
    public let results: [SearchResult]

    public init(
        page: Int,
        totalPages: Int,
        totalResults: Int,
        results: [SearchResult]
    ) {
        self.page = page
        self.totalPages = totalPages
        self.totalResults = totalResults
        self.results = results
    }

    private enum CodingKeys: CodingKey {
        case page
        case totalPages
        case totalResults
        case results
    }

    public init(from decoder: any Decoder) throws {
        let container: KeyedDecodingContainer<CodingKeys> = try decoder.container(keyedBy: CodingKeys.self)

        self.page = try container.decode(Int.self, forKey: .page)
        self.totalPages = try container.decode(Int.self, forKey: .totalPages)
        self.totalResults = try container.decode(Int.self, forKey: .totalResults)

        let logger = os.Logger(subsystem: "com.fespinozacast.youtube.MovieCatalog", category: "Models")

        let failableResults = try container.decode([FailableSearchResult].self, forKey: .results)
        self.results = failableResults.compactMap { failableResult in
            switch failableResult {
            case let .failed(error):
                logger.error("\(error)")
                return nil
            case let .value(value):
                return value
            }
        }
    }

    enum FailableSearchResult: Decodable {
        case value(SearchResult)
        case failed(error: Error)

        init(from decoder: Decoder) throws {
            do {
                let dto = try SearchResult(from: decoder)
                self = .value(dto)
            } catch {
                self = .failed(error: error)
            }
        }
    }
}

public enum SearchResult: Decodable, Hashable {
    case movie(MovieSummary)
    case actor(ActorSummary)

    enum CodingKeys: CodingKey {
        case mediaType
    }

    enum CustomDecodingLogicError: Error {
        case unknownMediaType(_ type: String)
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let mediaType = try container.decode(String.self, forKey: .mediaType)

        if mediaType == "movie" {
            self = try .movie(MovieSummary(from: decoder))
        } else if mediaType == "person" {
            self = try .actor(ActorSummary(from: decoder))
        } else {
            throw CustomDecodingLogicError.unknownMediaType(mediaType)
        }
    }
}

public struct ActorSummary: Decodable, Hashable {
    public let id: ActorID
    public let name: String
    public let profilePath: String?

    init(
        id: ActorID,
        name: String,
        profilePath: String? = nil
    ) {
        self.id = id
        self.name = name
        self.profilePath = profilePath
    }
}

public extension ActorSummary {
    var profileURL: URL? {
        guard let profilePath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(profilePath)")
    }
}
