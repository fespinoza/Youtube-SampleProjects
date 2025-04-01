import SwiftUI
import MovieModels
import MovieComponents

struct MovieDetailsScreen: View {
    let movieID: MovieID
    @State var loadingState: BasicLoadingState<MovieDetailsViewData> = .idle
    @Environment(\.movieDataClient.movieDetails) private var movieDetails

    var body: some View {
        BasicStateView(
            state: $loadingState,
            dataContent: { viewData in
                MovieDetailsView(viewData: viewData)
            },
            fetchData: { try await movieDetails(movieID) }
        )
    }
}

#Preview {
    MovieDetailsScreen(movieID: .randomPreviewId())
        .environment(\.movieDataClient, .previewClient())
}
