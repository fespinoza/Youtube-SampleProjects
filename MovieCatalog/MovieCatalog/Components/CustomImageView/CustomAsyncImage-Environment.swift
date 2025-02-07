import SwiftUI

struct PlaceholderColorKey: EnvironmentKey {
    static var defaultValue: Color = .gray
}

public extension EnvironmentValues {
    var placeholderColor: Color {
        get { self[PlaceholderColorKey.self] }
        set { self[PlaceholderColorKey.self] = newValue }
    }
}
