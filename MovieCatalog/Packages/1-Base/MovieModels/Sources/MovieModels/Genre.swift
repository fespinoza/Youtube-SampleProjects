import Foundation
import Tagged

public typealias GenreID = Tagged<Genre, Int>

public struct Genre: Decodable, Identifiable, Hashable, Sendable {
    public let id: GenreID
    public let name: String

    public init(id: GenreID, name: String) {
        self.id = id
        self.name = name
    }
}

public struct GenreContainer: Decodable {
    public let genres: [Genre]
}
