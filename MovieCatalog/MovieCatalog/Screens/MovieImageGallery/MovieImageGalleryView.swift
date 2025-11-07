import MovieComponents
import SwiftUI

struct MovieImageGalleryView: View {
    let images: [ImageContainerViewData]
    @Binding var selectedImage: Int

    var body: some View {
        Group {
            if images.count == 1 {
                singleImage
            } else {
                multipleImages
            }
        }
        .colorScheme(.dark)
    }

    var singleImage: some View {
        ImageCell(container: images[0])
    }

    var multipleImages: some View {
        TabView(selection: $selectedImage) {
            ForEach(Array(images.enumerated()), id: \.element.id) { index, element in
                ImageCell(container: element)
                    .tag(index)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
    }

    struct ImageCell: View {
        let container: ImageContainerViewData

        @State private var zoom: CGFloat = 1
        @Environment(\.verticalSizeClass) private var verticalSizeClass

        var body: some View {
            GeometryReader { proxy in
                ScrollView([.vertical, .horizontal]) {
                    if verticalSizeClass == .regular {
                        image
                            .frame(width: proxy.size.width * zoom)
                            .clipShape(Rectangle())
                    } else {
                        image
                            .frame(height: proxy.size.height * zoom)
                            .clipShape(Rectangle())
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .onAppear(perform: resetZoom)
        }

        var image: some View {
            CustomAsyncImage(state: container.image) { image in
                image
                    .resizable()
                    .onTapGesture(count: 2, perform: toggleZoom)
            }
            .aspectRatio(container.aspectRatio, contentMode: .fit)
        }

        func resetZoom() {
            zoom = 1.0
        }

        func toggleZoom() {
            zoom = zoom == 1.0 ? 2.0 : 1.0
        }
    }
}

#Preview {
    @Previewable @State var selectedImage = 3

    MovieImageGalleryView(
        images: [
            .previewValue(image: .image(Image(.Gallery.IronMan.image1))),
            .previewValue(image: .loading),
            .previewValue(image: .image(Image(.Gallery.IronMan.image2))),
            .previewValue(image: .image(Image(.Gallery.IronMan.image3))),
            .previewValue(image: .image(Image(.Gallery.IronMan.image4))),
        ],
        selectedImage: $selectedImage
    )
    .background(Color.black)
}
