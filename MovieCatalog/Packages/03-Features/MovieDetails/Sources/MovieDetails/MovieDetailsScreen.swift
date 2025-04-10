import SwiftUI
import MovieModels
import MovieComponents
import Navigation

public struct MovieDetailsScreen: View {
    let movieID: MovieID
    @State var loadingState: BasicLoadingState<MovieDetailsViewData> = .idle
    @Environment(\.movieDetailsDataSource.movieDetails) private var movieDetails

    public init(movieID: MovieID) {
        self.movieID = movieID
    }

    public var body: some View {
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
        .environment(\.movieDetailsDataSource, .previewClient())
        .environment(Router.previewRouter())
}
