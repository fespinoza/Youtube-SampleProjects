import SwiftUI

@ViewBuilder func view(for destination: PushDestination) -> some View {
    switch destination {
    case .movieDetails(let id):
        MovieDetailsScreen(movieID: id)

    case .actorDetails(let id):
        ActorDetailsScreen(actorID: id)

    case let .movieList(listType):
        MovieListScreen(listType: listType)
    }
}

@ViewBuilder func view(for destination: SheetDestination) -> some View {
    Group {
        switch destination {
        case let .movieDescription(id):
            MovieDescriptionScreen(movieID: id)

        case let .movieDescriptionValue(id, title, description):
            MovieDescriptionScreen(movieID: id, title: title, description: description)
        }
    }
    .navigationBarTitleDisplayMode(.inline)
    .addDismissButton()
    .presentationDetents([.medium, .large])
    .presentationBackground(.regularMaterial)
}

@ViewBuilder func view(for destination: FullScreenDestination) -> some View {
    Group {
        switch destination {
        case let .movieGallery(id):
            MovieImageGalleryScreen(movieID: id)

        case let .movieGalleryValue(id, images, selectedImageIndex):
            MovieImageGalleryScreen(movieID: id, images: images, selectedImage: selectedImageIndex)
        }
    }
    .addDismissButton()
    .presentationBackground(.black)
}
