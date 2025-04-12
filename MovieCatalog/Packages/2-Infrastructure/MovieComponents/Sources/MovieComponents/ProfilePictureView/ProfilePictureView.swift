import SwiftUI
import PreviewData

public struct ProfilePictureView: View {
    let image: ImageViewData
    let size: CGFloat = 80

    public init(image: ImageViewData) {
        self.image = image
    }

    public var body: some View {
        CustomAsyncImage(state: image) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
        }
        .frame(width: size, height: size)
        .clipShape(.rect(cornerRadius: .cornerRadiusS))
        .clipped()
    }
}

#Preview {
    ProfilePictureView(image: .image(Image(preview: .Actor.BradPitt.small)))
}
