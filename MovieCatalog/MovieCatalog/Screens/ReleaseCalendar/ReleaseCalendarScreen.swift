import MovieComponents
import SwiftUI

struct ReleaseCalendarScreen: View {
    @State var loadingState: BasicLoadingState<[ReleaseMonthViewData]> = .idle
    @Environment(GenreStore.self) private var genreStore
    @Environment(\.movieDataClient.releaseCalendar) private var releaseCalendar

    var body: some View {
        BasicStateView(
            state: $loadingState,
            dataContent: { viewData in
                ReleaseCalendarView(months: viewData)
            },
            fetchData: { try await releaseCalendar(genreStore) }
        )
    }
}

#Preview {
    NavigationStack {
        ReleaseCalendarScreen()
    }
    .previewEnvironment()
}
