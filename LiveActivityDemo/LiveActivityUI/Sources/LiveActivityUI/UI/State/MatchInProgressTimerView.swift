import LiveActivityContent
import SwiftUI
import WidgetKit

struct MatchInProgressTimerView: View {
    let periodInfo: ScoreActivityAttributes.PeriodInfo

    private let pillColor: Color = .init(red: 73 / 255, green: 148 / 255, blue: 57 / 255)

    var body: some View {
        VStack(spacing: 0) {
            Text(periodInfo.name)
                .font(.caption)

            Text(
                timerInterval: periodInfo.currentTime ... periodInfo.endTime,
                pauseTime: nil,
                countsDown: true,
                showsHours: false
            )
            .monospacedDigit()
            .font(.caption.bold())
            .padding(.horizontal, 6)
            .padding(.vertical, 2)
            .frame(width: 48)
            .background(Capsule().foregroundStyle(pillColor))
        }
        .multilineTextAlignment(.center)
    }
}
