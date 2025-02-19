import Testing
import SwiftUI
import SnapshotTestingKit
@testable import MovieCatalog

@MainActor
@Suite("MovieDetils Snapshot Tests")
struct MovieDetailsViewTests {
    @Test("Movie with all data", arguments: SnapshotVariant.defaultVariants())
    func movieDetails(_ variant: SnapshotVariant) async throws {
        let view = NavigationStack { MovieDetailsView(viewData: .previewValue()) }

        expectSnapshot(of: view, on: variant)
    }

    @Test("Movie that doens't have a gallery", arguments: SnapshotVariant.fixedHeightVariants())
    func movieDetailsNoGallery(_ variant: SnapshotVariant) async throws {
        let view = NavigationStack { MovieDetailsView(viewData: .previewValue(galleryItems: [])) }

        expectSnapshot(of: view, on: variant)
    }

    @Test("Movie that doens't have a actors", arguments: SnapshotVariant.fixedHeightVariants())
    func movieDetailsNoActors(_ variant: SnapshotVariant) async throws {
        let view = NavigationStack { MovieDetailsView(viewData: .previewValue(actors: [])) }

        expectSnapshot(of: view, on: variant)
    }

    @Test("Movie that a poster image", arguments: SnapshotVariant.minimalVariants())
    func movieDetailsMissingPoster(_ variant: SnapshotVariant) async throws {
        let view = NavigationStack { MovieDetailsView(viewData: .previewValue(poster: nil)) }

        expectSnapshot(of: view, on: variant)
    }
}
