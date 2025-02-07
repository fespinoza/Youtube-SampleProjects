import SwiftUI

struct ActorDetailsScreen: View {
    let actorID: ActorID
    @State var loadingState: BasicLoadingState<ActorDetailsViewData> = .idle

    var body: some View {
        BasicStateView(
            state: $loadingState,
            loadingContent: { ProgressView() },
            dataContent: { viewData in
                ActorDetailsView(viewData: viewData)
            },
            fetchData: {
                let dto = try await MovieDBClient().actorDetails(for: actorID)
                return ActorDetailsViewData(dto: dto)
            }
        )
    }
}
