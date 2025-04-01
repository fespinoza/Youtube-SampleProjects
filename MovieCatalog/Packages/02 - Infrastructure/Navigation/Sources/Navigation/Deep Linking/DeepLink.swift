import Foundation

public struct DeepLink {
    public let scheme: String

    public init(scheme: String) {
        self.scheme = scheme
    }

    public func destination(from url: URL) -> Destination? {
        guard url.scheme == scheme else { return nil }

        for parser in registeredParsers {
            if let destination = parser.parse(url) {
                return destination
            }
        }

        return nil
    }

    let registeredParsers: [DeepLinkParser] = [
        .equal(to: ["home"], destination: .tab(.home)),
        .equal(to: ["search"], destination: .tab(.search)),
        .equal(to: ["release-calendar"], destination: .tab(.releaseCalendar)),
        .equal(to: ["favorites"], destination: .tab(.favorites)),

        .equal(to: ["list", "upcoming"], destination: .push(.movieList(.upcoming))),
        .equal(to: ["list", "top-rated"], destination: .push(.movieList(.topRated))),
        .equal(to: ["list", "popular"], destination: .push(.movieList(.popular))),

        .movieDetails,
        .movieDetailsDescription,
        .movieDetailsGallery,

        .actorDetails,
    ]
}
