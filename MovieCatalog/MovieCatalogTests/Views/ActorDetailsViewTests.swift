@testable import MovieCatalog
import Navigation
import SnapshotTestingKit
import SwiftUI
import Testing

@MainActor
@Suite("ActorDetails Snapshot Tests")
struct ActorDetaislViewTests {
    @Test("Sample Actor details", arguments: SnapshotVariant.defaultVariants())
    func actorDetails(_ variant: SnapshotVariant) async throws {
        let view = NavigationStack { ActorDetailsView(viewData: .previewValue()) }
            .environment(Router.previewRouter())

        expectSnapshot(of: view, on: variant)
    }
}
