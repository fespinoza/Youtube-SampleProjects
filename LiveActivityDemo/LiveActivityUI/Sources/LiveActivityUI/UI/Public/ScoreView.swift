import SwiftUI

public struct ScoreView: View {
    let blue: Int
    let red: Int

    @Environment(\.activityFamily) private var activityFamily

    public init(blue: Int, red: Int) {
        self.blue = blue
        self.red = red
    }

    var spacing: CGFloat { activityFamily == .small ? 14 : 21 }
    var scoreSize: CGFloat { activityFamily == .small ? 27 : 44 }
    var separatorSize: CGFloat { activityFamily == .small ? 27 : 38 }

    public var body: some View {
        HStack(spacing: spacing) {
            Text(blue.formatted())
                .font(.system(size: scoreSize, weight: .bold).monospacedDigit())

            Text(":")
                .font(.system(size: separatorSize, weight: .bold))
                .foregroundStyle(.secondary)

            Text(red.formatted())
                .font(.system(size: scoreSize, weight: .bold).monospacedDigit())
        }
    }

    public struct MinimalView: View {
        let blue: Int
        let red: Int

        public init(blue: Int, red: Int) {
            self.blue = blue
            self.red = red
        }

        public var body: some View {
            Text("\(blue.formatted()) : \(red.formatted())")
                .monospacedDigit()
        }
    }
}
