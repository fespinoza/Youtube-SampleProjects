import Foundation
import MovieModels

/// A function that matches a deep link URL to a destination if possible
struct DeepLinkParser {
    let parse: (URL) -> Destination?
}

extension URL {
    /// Split URL components without considering the scheme
    ///
    /// Example:
    ///
    /// for `moviecat://movies/123/gallery` this returns
    ///
    /// ```swift
    /// ["movies", "123", "gallery"]
    /// ```
    var fullComponents: [String] {
        guard let scheme else { return [] }

        return absoluteString
            .replacingOccurrences(of: "\(scheme)://", with: "")
            .split(separator: "/")
            .map { String($0) }
    }
}

extension DeepLinkParser {
    static func equal(to components: [String], destination: Destination) -> Self {
        .init { url in
            guard url.fullComponents == components else { return nil }
            return destination
        }
    }

    static let movieDetails: Self = .init { url in
        guard
            url.fullComponents.first == "movies",
            let movieID = url.fullComponents.last.flatMap(Int.init)
        else { return nil }

        return .push(.movieDetails(id: .init(movieID)))
    }

    static let movieDetailsDescription: Self = .init { url in
        guard
            url.fullComponents.first == "movies",
            url.fullComponents.count == 3,
            let movieID = Int(url.fullComponents[1]),
            url.fullComponents.last == "description"
        else { return nil }

        return .sheet(.movieDescription(id: .init(movieID)))
    }

    static let movieDetailsGallery: Self = .init { url in
        guard
            url.fullComponents.first == "movies",
            url.fullComponents.count == 3,
            let movieID = Int(url.fullComponents[1]),
            url.fullComponents.last == "gallery"
        else { return nil }

        return .fullScreen(.movieGallery(id: .init(movieID)))
    }

    static let actorDetails: Self = .init { url in
        guard
            url.fullComponents.first == "actors",
            let actorID = url.fullComponents.last.flatMap(Int.init)
        else { return nil }

        return .push(.actorDetails(id: .init(actorID)))
    }
}
