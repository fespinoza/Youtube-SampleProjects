import UIKit
import Testing

/// Collection of properties to configure the snapshot
public struct SnapshotAppearance: Sendable {
    public let suffix: String
    public let traits: UITraitCollection

    public var isLightMode: Bool { suffix == "Light" }

    public static let lightMode = SnapshotAppearance(suffix: "Light", traits: .lightMode)
    public static let darkMode = SnapshotAppearance(suffix: "Dark", traits: .darkMode)

    public static let allCases: [SnapshotAppearance] = [.lightMode, .darkMode]
}

extension SnapshotAppearance: CustomTestStringConvertible {
    public var testDescription: String {
        "\(suffix) Mode"
    }
}
