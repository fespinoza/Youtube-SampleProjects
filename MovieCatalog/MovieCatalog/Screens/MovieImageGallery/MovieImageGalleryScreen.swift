import SwiftUI
import MovieModels

struct MovieImageGalleryScreen: View {
    let movieID: MovieID

    @State private var state: BasicLoadingState<[ImageContainerViewData]>
    @State private var selectedImage: Int
    @Environment(\.movieDataClient.movieGallery) private var movieGallery

    init(movieID: MovieID) {
        self.movieID = movieID
        self._state = .init(initialValue: .idle)
        self._selectedImage = .init(initialValue: 0)
    }

    init(movieID: MovieID, images: [MovieDetails.ImageCollection.Backdrop], selectedImage: Int) {
        self.movieID = movieID
        self._state = .init(initialValue: .dataLoaded(ImageContainerViewData.galleryItems(for: images)))
        self._selectedImage = .init(initialValue: selectedImage)
    }

    var body: some View {
        BasicStateView(
            state: $state,
            dataContent: { galleryItems in
                MovieImageGalleryView(images: galleryItems, selectedImage: $selectedImage)
            },
            fetchData: { try await movieGallery(movieID) }
        )
    }
}
