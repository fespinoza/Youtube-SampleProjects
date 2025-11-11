import MovieComponents
import MovieModels
import SwiftUI

struct ActorDetailsScreen: View {
    let actorID: ActorID
    @State var loadingState: BasicLoadingState<ActorDetailsViewData> = .idle

    @Environment(\.movieDataClient.actorDetails) var actorDetails

    var body: some View {
        BasicStateView(
            state: $loadingState,
            dataContent: { viewData in
                ActorDetailsView(viewData: viewData)
            },
            fetchData: fetchActorDetails
        )
    }

    func fetchActorDetails() async throws -> ActorDetailsViewData {
        try await actorDetails(actorID)
    }
}
