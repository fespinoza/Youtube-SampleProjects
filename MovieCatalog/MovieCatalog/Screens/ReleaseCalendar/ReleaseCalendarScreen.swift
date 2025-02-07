import SwiftUI

struct ReleaseCalendarScreen: View {
    @State var loadingState: BasicLoadingState<[ReleaseMonthViewData]> = .idle
    @Environment(GenreStore.self) private var genreStore

    var body: some View {
        BasicStateView(
            state: $loadingState,
            loadingContent: { ProgressView() },
            dataContent: { viewData in
                ReleaseCalendarView(months: viewData)
            },
            fetchData: {
                let dto = try await MovieDBClient().upcomingMovies()
                return ReleaseMonthViewData.buildCollection(from: dto, genreStore: genreStore)
            }
        )
    }
}

#Preview {
    ReleaseCalendarScreen()
        .environment(GenreStore.preview())
}
