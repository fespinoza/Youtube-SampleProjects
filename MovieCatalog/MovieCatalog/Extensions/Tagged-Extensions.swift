import Foundation
import Tagged

public extension Tagged where RawValue == String {
    /// Creates a UUID string for a tagged type
    /// This is a common pattern when it comes to development
    static func randomPreviewId() -> Tagged<Tag, RawValue> {
        .init(rawValue: UUID().uuidString)
    }
}

public extension Tagged where RawValue == Int {
    /// Creates a UUID string for a tagged type
    /// This is a common pattern when it comes to development
    static func randomPreviewId() -> Tagged<Tag, RawValue> {
        .init(rawValue: Int.random(in: 1 ... 100_000_000))
    }
}
