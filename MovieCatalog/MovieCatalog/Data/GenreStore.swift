import SwiftUI
import MovieModels

@Observable
class GenreStore {
    private(set) var genres: [Genre]

    init(genres: [Genre] = [], autoFetch: Bool = true) {
        self.genres = genres

        if autoFetch {
            Task { await customFetchGenres() }
        }
    }

    static func preview() -> GenreStore {
        GenreStore(genres: [], autoFetch: false)
    }

    private func customFetchGenres() async {
        do {
            genres = try await MovieDBClient().genres()
        } catch {
            print(error.localizedDescription)
        }
    }

    func formattedGenres(for genreIDs: [GenreID]) -> String {
        genres
            .filter { genreIDs.contains($0.id) }
            .map(\.name)
            .joined(separator: ", ")
    }

    func firstGenre(for genreIDs: [GenreID]) -> String {
        genres
            .filter { genreIDs.contains($0.id) }
            .first?
            .name ?? "" // This should never be nil
    }
}
