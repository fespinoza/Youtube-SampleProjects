import OSLog
import Logging
import SwiftUI

/// Internal only type as a simple/default implementation of the `ImageClient` protocol.
class DefaultImageClient: ImageClient {
    let logger: os.Logger = .forCategory("DefaultImageClient")

    func loadImage(with url: URL) async throws -> Image {
        let (imageData, _) = try await URLSession.shared.data(from: url)
        guard let uiImage = UIImage(data: imageData) else { throw ImageError.decodeError }
        return Image(uiImage: uiImage)
    }

    enum ImageError: LocalizedError {
        case decodeError

        var errorDescription: String? {
            switch self {
            case .decodeError: "We got the image data but couldn't convert it to a proper image"
            }
        }
    }
}
