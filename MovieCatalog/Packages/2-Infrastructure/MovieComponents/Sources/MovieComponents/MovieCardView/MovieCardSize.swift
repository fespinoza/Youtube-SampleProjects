import SwiftUI

public extension EnvironmentValues {
    @Entry var movieCardSize: MovieCardSize = .medium
}

public struct MovieCardSize {
    public let width: CGFloat
    public let height: CGFloat

    public static let medium: MovieCardSize = .init(width: 120, height: 180)
    public static let large: MovieCardSize = .init(width: 180, height: 270)
}

public extension View {
    func movieCardSize(_ size: MovieCardSize) -> some View {
        environment(\.movieCardSize, size)
    }
}
