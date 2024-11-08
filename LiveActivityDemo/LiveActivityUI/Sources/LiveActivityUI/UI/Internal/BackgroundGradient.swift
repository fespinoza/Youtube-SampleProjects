import LiveActivityContent
import SwiftUI

struct BackgroundGradient: View {
    var matchState: ScoreActivityAttributes.MatchState

    var body: some View {
        switch matchState {
        case .notYetStarted, .finished:
            Color.black

        default:
            LinearGradient(
                gradient: Gradient(
                    colors: [
                        Color(red: 54 / 255, green: 0, blue: 60 / 255),
                        Color(red: 96 / 255, green: 7 / 255, blue: 99 / 255),
                    ]
                ),
                startPoint: .bottomLeading,
                endPoint: .topTrailing
            )
        }
    }
}
