import SwiftUI

struct MatchPausedView: View {
    private let color: Color = .init(.sRGB, red: 73 / 255, green: 148 / 255, blue: 57 / 255, opacity: 1.0)

    var body: some View {
        Pill(text: "Half Time", color: color)
    }
}
