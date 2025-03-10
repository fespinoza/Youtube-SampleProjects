import SwiftUI

struct ProfilePictureView: View {
    let image: ImageViewData
    let size: CGFloat = 80

    var body: some View {
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
    ProfilePictureView(image: .image(Image(.Actor.BradPitt.small)))
}
