import SwiftUI

struct MovieCardSizeKey: EnvironmentKey {
    static let defaultValue: MovieCardSize = .medium
}

extension EnvironmentValues {
    var movieCardSize: MovieCardSize {
        get { self[MovieCardSizeKey.self] }
        set { self[MovieCardSizeKey.self] = newValue }
    }
}

struct MovieCardSize {
    let width: CGFloat
    let height: CGFloat

    static let medium: MovieCardSize = .init(width: 120, height: 180)
    static let large: MovieCardSize = .init(width: 180, height: 270)
}

extension View {
    func movieCardSize(_ size: MovieCardSize) -> some View {
        environment(\.movieCardSize, size)
    }
}
