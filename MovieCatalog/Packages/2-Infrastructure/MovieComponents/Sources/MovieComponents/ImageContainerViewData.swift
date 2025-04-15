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

extension ImageContainerViewData {
    public init(dto: MovieDetails.ImageCollection.Backdrop) {
        self.init(
            image: .remote(from: dto.imageURL),
            aspectRatio: dto.aspectRatio
        )
    }

    public static func galleryItems(for dto: [MovieDetails.ImageCollection.Backdrop]) -> [ImageContainerViewData] {
        dto.map(ImageContainerViewData.init(dto:))
    }

    public static func galleryItems(for dto: MovieDetails) -> [ImageContainerViewData] {
        galleryItems(for: dto.images.backdrops)
    }
}

extension ImageContainerViewData {
    public static func previewValue(
        image: ImageViewData = .empty,
        aspectRatio: CGFloat = 1.778
    ) -> Self {
        .init(
            image: image,
            aspectRatio: aspectRatio
        )
    }
}
