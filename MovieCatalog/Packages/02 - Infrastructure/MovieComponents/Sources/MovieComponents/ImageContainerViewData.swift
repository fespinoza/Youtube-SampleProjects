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
    public static func galleryItems(for dto: MovieDetails) -> [ImageContainerViewData] {
        dto
            .images
            .backdrops
            .dropFirst()
            .prefix(10)
            .map { backdrop in
                    .init(
                        image: .remote(from: backdrop.imageURL),
                        aspectRatio: backdrop.aspectRatio
                    )
            }
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
