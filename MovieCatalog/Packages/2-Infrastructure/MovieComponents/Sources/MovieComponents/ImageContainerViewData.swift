import Foundation
import MovieModels

public struct ImageContainerViewData: Identifiable, Hashable, Sendable {
    public let id = UUID()
    public let image: ImageViewData
    public let aspectRatio: CGFloat

    public init(image: ImageViewData, aspectRatio: CGFloat) {
        self.image = image
        self.aspectRatio = aspectRatio
    }
}

public extension ImageContainerViewData {
    init(dto: MovieDetails.ImageCollection.Backdrop) {
        self.init(
            image: .remote(from: dto.imageURL),
            aspectRatio: dto.aspectRatio
        )
    }

    static func galleryItems(for dto: [MovieDetails.ImageCollection.Backdrop]) -> [ImageContainerViewData] {
        dto.map(ImageContainerViewData.init(dto:))
    }

    static func galleryItems(for dto: MovieDetails) -> [ImageContainerViewData] {
        galleryItems(for: dto.images.backdrops)
    }
}

public extension ImageContainerViewData {
    static func previewValue(
        image: ImageViewData = .empty,
        aspectRatio: CGFloat = 1.778
    ) -> Self {
        .init(
            image: image,
            aspectRatio: aspectRatio
        )
    }
}
