import MovieComponents
import MovieModels
import Navigation
import SwiftUI

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
    NavigationStack {
        MovieDetailsScreen(movieID: .randomPreviewId())
    }
    .environment(\.movieDetailsDataSource, .previewClient())
    .environment(Router.previewRouter())
}
