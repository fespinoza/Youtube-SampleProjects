import OSLog
import SwiftUI

/** Custom implementation of the `AsyncImage` view from iOS 15
 We took inspiration from that implementation to make a custom one for us.

 This component works together with `ImageViewData` to implement the
 logic to render remote images.

 One big advantage is that we can control the placeholder/loading state and
 also pass a concrete image for testing purposes

 ## Example

 ```
 CustomAsyncImage(.remote(url: url)) { image in
     image
         .resizable()
         .aspectRatio(contentMode: .fit)
         .frame(width: 200, height: 200)
         .background(Color.red)
 }
 ```
 */
public struct CustomAsyncImage<Output: View>: View {
    @State var state: ImageViewData
    let transform: ((Image) -> Output)?

    @Environment(\.placeholderColor) private var placeholderColor
    @Environment(\.imageClient) private var imageClient
    private let logger = os.Logger.forCategory("CustomAsyncImage")

    public var body: some View {
        Group {
            switch state {
            case .empty,
                 .remote:
                placeholder
            case .loading:
                placeholder
                    .overlay(ProgressView())
            case .error:
                Color.red
                    .overlay {
                        VStack(spacing: 12) {
                            Image(systemName: "xmark.circle")
                                .font(.system(size: 50))

                            Text("Couldn't load image")
                        }
                    }
            case let .image(image):
                if let transform {
                    transform(image)
                } else {
                    image
                }
            }
        }
        .transition(.opacity)
        .task { await loadImageIfNeeded() }
    }

    var placeholder: some View {
        Rectangle()
            .foregroundStyle(placeholderColor)
    }

    func loadImageIfNeeded() async {
        guard case let .remote(imageURL) = state else { return }

        withAnimation { state = .loading }

        do {
            let image = try await imageClient.loadImage(with: imageURL)
            withAnimation { state = .image(image) }
        } catch {
            logger.error("\(error)")
            withAnimation { state = .error }
        }
    }
}

#Preview {
    CustomAsyncImage(state: .error) { image in
        image.resizable()
    }
    .frame(width: 300, height: 300)
}
