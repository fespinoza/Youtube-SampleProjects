import SnapshotTesting
import UIKit

extension CGSize {
    /// Creates a size instance with the width of an iPhone 16 Pro
    /// and the height at least of that iPhone
    ///
    /// - Parameter height: height value for a taller iPhone 16 Pro
    public static func iPhone16Pro(height: CGFloat) -> Self {
        .init(width: 402, height: max(height, 874))
    }
}

extension ViewImageConfig {
    public static let iPhone16Pro = ViewImageConfig.iPhone16Pro(.portrait)

    /// Custom definition of the parameters of iPhone 16 Pro
    ///
    /// Values taken from: https://useyourloaf.com/blog/iphone-16-screen-sizes/
    ///
    /// - Parameter orientation: device orientation
    /// - Returns: config for snapshot test for the iPhone 15 Pro
    public static func iPhone16Pro(_ orientation: Orientation) -> ViewImageConfig {
        let safeArea: UIEdgeInsets
        let size: CGSize

        switch orientation {
        case .landscape:
            safeArea = .init(top: 0, left: 62, bottom: 21, right: 62)
            size = .init(width: 874, height: 402)
        case .portrait:
            safeArea = .init(top: 62, left: 0, bottom: 34, right: 0)
            size = .init(width: 402, height: 874)
        }

        return .init(safeArea: safeArea, size: size, traits: .iPhone13(orientation))
    }
}

extension UITraitCollection {
    public static func iPhone16Pro(_ orientation: ViewImageConfig.Orientation) -> UITraitCollection {
        .iPhone13(orientation)
    }
}
