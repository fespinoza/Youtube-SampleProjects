import SwiftUI

public extension EnvironmentValues {
    @Entry var imageClient: ImageClient = DefaultImageClient()
}

/// Requirements for an `ImageClient` to be used in `CustomAsyncImage`.
///
/// The main idea is that this UI library is mostly state-less, also the actual
/// logic of fetching images, which can include caching and more advanced
/// mechanisms is out of the scope of this library.
public protocol ImageClient {
    /// Performs a network request to load the image given the URL
    /// - Parameter url: the URL of the image to load
    /// - Returns: the SwiftUI Image for the given URL
    func loadImage(with url: URL) async throws -> Image
}
