import SwiftUI

struct ImageContainerViewData: Identifiable, Hashable {
    let id = UUID()
    let image: ImageViewData
    let aspectRatio: CGFloat
}

extension ImageContainerViewData {
    static func previewValue(
        image: ImageViewData = .image(Image(.Gallery.TheApprentice.image2)),
        aspectRatio: CGFloat = 1.778
    ) -> Self {
        .init(
            image: image,
            aspectRatio: aspectRatio
        )
    }
}
