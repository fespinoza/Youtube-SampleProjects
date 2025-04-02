import Testing
import SwiftUI
@preconcurrency import SnapshotTestingKit
import Navigation
@testable import MovieDetails

@MainActor
@Suite("MovieDetils Snapshot Tests")
struct MovieDetailsViewTests {
    @Test("Movie with all data", arguments: SnapshotVariant.defaultVariants())
    func movieDetails(_ variant: SnapshotVariant) async throws {
        let view = NavigationStack { MovieDetailsView(viewData: .previewValue()) }
            .environment(Router.previewRouter())

        expectSnapshot(of: view, on: variant)
    }

    @Test("Movie that doens't have a gallery", arguments: SnapshotVariant.fixedHeightVariants())
    func movieDetailsNoGallery(_ variant: SnapshotVariant) async throws {
        let view = NavigationStack { MovieDetailsView(viewData: .previewValue(galleryItems: [])) }
            .environment(Router.previewRouter())

        expectSnapshot(of: view, on: variant)
    }

    @Test("Movie that doens't have a actors", arguments: SnapshotVariant.fixedHeightVariants())
    func movieDetailsNoActors(_ variant: SnapshotVariant) async throws {
        let view = NavigationStack { MovieDetailsView(viewData: .previewValue(actors: [])) }
            .environment(Router.previewRouter())

        expectSnapshot(of: view, on: variant)
    }

    @Test("Movie missing a poster image", arguments: SnapshotVariant.minimalVariants())
    func movieDetailsMissingPoster(_ variant: SnapshotVariant) async throws {
        let view = NavigationStack { MovieDetailsView(viewData: .previewValue(poster: nil)) }
            .environment(Router.previewRouter())

        expectSnapshot(of: view, on: variant)
    }

    @Test("Movie with all data - large size")
    func movieDetailsAccessbility() {
        let view = NavigationStack { MovieDetailsView(viewData: .previewValue()) }
            .environment(Router.previewRouter())

        expectSnapshot(
            of: view,
            on: .init(
                device: .fixedSize(.init(width: 402, height: 1600)),
                appearance: .darkMode,
                dynamicTypeSize: .accessibility2
            )
        )
    }
}
