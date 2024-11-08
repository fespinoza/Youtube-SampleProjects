import LiveActivityContent
import SwiftUI

public struct MatchStateView: View {
    var attrs: ScoreActivityAttributes
    var state: ScoreActivityAttributes.ContentState

    var topOffset: CGFloat { state.matchState == .notYetStarted ? 0 : -16 }

    public init(attrs: ScoreActivityAttributes, state: ScoreActivityAttributes.ContentState) {
        self.attrs = attrs
        self.state = state
    }

    public var body: some View {
        ZStack {
            TopView(attrs: attrs, state: state)
                .offset(y: topOffset)

            BottomView(attrs: attrs, state: state)
                .frame(maxHeight: .infinity, alignment: .bottom)
                .offset(y: 8)
        }
    }

    public struct TopView: View {
        var attrs: ScoreActivityAttributes
        var state: ScoreActivityAttributes.ContentState

        public init(attrs: ScoreActivityAttributes, state: ScoreActivityAttributes.ContentState) {
            self.attrs = attrs
            self.state = state
        }

        public var body: some View {
            switch state.matchState {
            case .notYetStarted:
                MatchStartTimeView(startTime: attrs.matchStartTime)

            case .inProgress, .paused, .finished:
                ScoreView(blue: state.blueTeamScore, red: state.redTeamScore)
            }
        }
    }

    public struct BottomView: View {
        var attrs: ScoreActivityAttributes
        var state: ScoreActivityAttributes.ContentState

        public init(attrs: ScoreActivityAttributes, state: ScoreActivityAttributes.ContentState) {
            self.attrs = attrs
            self.state = state
        }

        public var body: some View {
            switch state.matchState {
            case .notYetStarted:
                EmptyView()

            case let .inProgress(periodInfo):
                MatchInProgressTimerView(periodInfo: periodInfo)

            case .paused:
                MatchPausedView()

            case .finished:
                MatchEndedView()
            }
        }
    }

    public struct SmallView: View {
        var attrs: ScoreActivityAttributes
        var state: ScoreActivityAttributes.ContentState

        public init(attrs: ScoreActivityAttributes, state: ScoreActivityAttributes.ContentState) {
            self.attrs = attrs
            self.state = state
        }

        public var body: some View {
            Group {
                switch state.matchState {
                case .notYetStarted:
                    Text("Starts ") +
                        Text(attrs.matchStartTime.formatted(date: .omitted, time: .shortened))

                case let .inProgress(periodInfo):
                    Text("\(periodInfo.name) - ") +
                        Text(
                            timerInterval: periodInfo.currentTime ... (periodInfo.currentTime.addingTimeInterval(periodInfo.timeLeft)),
                            pauseTime: nil,
                            countsDown: true,
                            showsHours: false
                        )

                case .paused:
                    Text("Half Time")

                case .finished:
                    Text("Match Ended")
                }
            }
            .font(.caption2.monospacedDigit())
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity)
        }
    }
}
