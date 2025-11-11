import MovieComponents
import MovieModels
import Navigation
import SwiftUI

struct GenreViewData: Identifiable, Equatable {
    let id: GenreID
    let name: String
    let image: ImageViewData
    let destination: PushDestination
}

extension GenreViewData {
    init(dto: Genre) {
        self.init(
            id: dto.id,
            name: dto.name,
            image: .image(Image("genre/\(dto.name.lowercased())", bundle: .module)),
            destination: .movieList(.genre(dto))
        )
    }
}

extension GenreViewData {
    static func previewValue(
        id: GenreID = .randomPreviewId(),
        name: String = "Action",
        image: ImageViewData? = nil
    ) -> Self {
        .init(
            id: id,
            name: name,
            image: image ?? .image(Image("genre/\(name.lowercased())", bundle: .module)),
            destination: .movieList(.genre(.init(id: id, name: name)))
        )
    }

    static let sampleCollection: [Self] = [
        .previewValue(name: "Action"),
        .previewValue(name: "Adventure"),
        .previewValue(name: "Comedy"),
        .previewValue(name: "Horror"),
        .previewValue(name: "Science Fiction"),
        .previewValue(name: "Thriller"),
    ]
}
