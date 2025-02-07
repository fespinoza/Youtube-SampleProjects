import SwiftUI

struct MovieDetailsScreen: View {
    let movieID: MovieID
    @State var loadingState: BasicLoadingState<MovieDetailsViewData> = .idle

    var body: some View {
        BasicStateView(
            state: $loadingState,
            loadingContent: { ProgressView() },
            dataContent: { viewData in
                MovieDetailsView(viewData: viewData)
            },
            fetchData: {
                let dto = try await MovieDBClient().movieDetails(for: movieID)
                return MovieDetailsViewData(dto: dto)
            }
        )
    }
}

#Preview {
    MovieDetailsScreen(movieID: .randomPreviewId())
}
