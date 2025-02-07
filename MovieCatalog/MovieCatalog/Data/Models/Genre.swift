import Tagged
import Foundation

typealias GenreID = Tagged<Genre, Int>

struct Genre: Decodable, Identifiable {
    let id: GenreID
    let name: String
}

struct GenreContainer: Decodable {
    let genres: [Genre]
}
