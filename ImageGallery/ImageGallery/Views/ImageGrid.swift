import SwiftUI

struct ImageGrid: View {
    let folder: Folder

    private let itemSpacing: CGFloat = 16
    private let itemSize: CGFloat = 300
    private let contentPadding: CGFloat = 16

    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: itemSize), spacing: itemSpacing)]) {
            ForEach(folder.contents) { imageFile in
                VStack {
                    AsyncImage(url: imageFile.url) { image in
                        image
                            .resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: itemSize, height: itemSize)

                    Text(imageFile.name)
                }
            }
        }
        .padding(contentPadding)
    }
}

#Preview {
    ImageGrid(folder: .testValue())
        .frame(width: 800, height: 600)
}
