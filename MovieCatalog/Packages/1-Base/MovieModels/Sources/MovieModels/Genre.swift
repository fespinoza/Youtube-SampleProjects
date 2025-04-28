import Foundation
import Tagged

public typealias GenreID = Tagged<Genre, Int>

public struct Genre: Decodable, Identifiable {
    public let id: GenreID
    public let name: String
}

public struct GenreContainer: Decodable {
    public let genres: [Genre]
}
