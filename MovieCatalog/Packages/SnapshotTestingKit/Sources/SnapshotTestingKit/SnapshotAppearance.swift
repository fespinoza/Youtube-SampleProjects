import UIKit

/// Collection of properties to configure the snapshot
public struct SnapshotAppearance {
    public let suffix: String
    public let traits: UITraitCollection

    public var isLightMode: Bool { suffix == "Light" }

    public static let lightMode = SnapshotAppearance(suffix: "Light", traits: .lightMode)
    public static let darkMode = SnapshotAppearance(suffix: "Dark", traits: .darkMode)
}
