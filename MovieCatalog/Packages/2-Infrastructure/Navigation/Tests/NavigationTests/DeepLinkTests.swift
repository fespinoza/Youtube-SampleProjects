import Foundation
import Testing
@testable import Navigation

@Suite("DeepLink parsing tests")
struct DeepLinkTests {
    @Test(
        "Parsing deep links into destinations",
        arguments: [
            ("moviecat://home", Destination.tab(.home)),
            ("moviecat://search", Destination.tab(.search)),
            ("moviecat://release-calendar", Destination.tab(.releaseCalendar)),
            ("moviecat://favorites", Destination.tab(.favorites)),

            ("moviecat://actors/4567", Destination.push(.actorDetails(id: .init(4567)))),

            ("moviecat://movies/1234/", Destination.push(.movieDetails(id: .init(1234)))),
            ("moviecat://movies/1234", Destination.push(.movieDetails(id: .init(1234)))),

            ("moviecat://movies/1234/description", Destination.sheet(.movieDescription(id: .init(1234)))),
            ("moviecat://movies/1234/description/", Destination.sheet(.movieDescription(id: .init(1234)))),

            ("moviecat://movies/1234/gallery", Destination.fullScreen(.movieGallery(id: .init(1234)))),

            ("moviecat://list/upcoming", Destination.push(.movieList(.upcoming))),
            ("moviecat://list/top-rated", Destination.push(.movieList(.topRated))),
            ("moviecat://list/popular", Destination.push(.movieList(.popular)))
        ]
    )
    func parsingTests(rawURL: String, expectedDestination: Destination) throws {
        let url = try #require(URL(string: rawURL))

        let result = try #require(DeepLink.destination(from: url))

        #expect(result == expectedDestination)
    }
}
