import SnapshotTesting
import UIKit

public enum SnapshotDeviceType {
    case iPhone
    case iPad(_ orientation: ViewImageConfig.Orientation?)
    case fixedSize(_ size: CGSize)

    public var viewConfig: ViewImageConfig {
        switch self {
        case .iPhone: .iPhone16Pro
        case .iPad(.none): .iPadPro11
        case let .iPad(.some(orientation)): .iPadPro11(orientation)
        case .fixedSize: .iPhone16Pro
        }
    }

    public var size: CGSize? {
        guard case let .fixedSize(size) = self else {
            return nil
        }
        return size
    }

    public var deviceTraits: UITraitCollection {
        switch self {
        case .iPhone: .iPhone16Pro(.portrait)
        case .iPad: .iPadPro11
        case .fixedSize: .iPhone16Pro(.portrait)
        }
    }
}
