import ActivityKit
import Foundation
import LiveActivityContent
import LiveActivityUI
import SwiftUI
import WidgetKit

struct MatchScoreLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: ScoreActivityAttributes.self) { context in
            MatchView(attrs: context.attributes, state: context.state)
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    TeamView(
                        name: context.attributes.blueTeam.name,
                        imageName: context.attributes.blueTeam.imageName
                    )
                    .padding(.leading)
                }

                DynamicIslandExpandedRegion(.center) {
                    MatchStateView.TopView(attrs: context.attributes, state: context.state)
                }

                DynamicIslandExpandedRegion(.trailing) {
                    TeamView(
                        name: context.attributes.redTeam.name,
                        imageName: context.attributes.redTeam.imageName
                    )
                    .padding(.trailing)
                }

                DynamicIslandExpandedRegion(.bottom) {
                    MatchStateView.BottomView(attrs: context.attributes, state: context.state)
                }

            } compactLeading: {
                TeamScoreView(
                    imageName: context.attributes.blueTeam.imageName,
                    score: context.state.blueTeamScore,
                    isLeading: true
                )

            } compactTrailing: {
                TeamScoreView(
                    imageName: context.attributes.redTeam.imageName,
                    score: context.state.redTeamScore,
                    isLeading: false
                )

            } minimal: {
                ScoreView.MinimalView(
                    blue: context.state.blueTeamScore,
                    red: context.state.redTeamScore
                )
            }
        }
        .supplementalActivityFamilies([.small])
    }
}

#Preview(
    "Dynamic Island Compact",
    as: .content,
    using: ScoreActivityAttributes.previewValue()
) {
    MatchScoreLiveActivity()
} contentStates: {
    ScoreActivityAttributes.ContentState.previewValue(
        matchState: .notYetStarted,
        blueTeamScore: 0,
        redTeamScore: 0
    )
    ScoreActivityAttributes.ContentState.previewValue(
        matchState: .inProgress(periodInfo: .previewValue(timeLeft: 30.minutes)),
        blueTeamScore: 0,
        redTeamScore: 1
    )
    ScoreActivityAttributes.ContentState.previewValue(
        matchState: .inProgress(periodInfo: .previewValue(timeLeft: 5.minutes)),
        blueTeamScore: 1,
        redTeamScore: 1
    )
    ScoreActivityAttributes.ContentState.previewValue(
        matchState: .paused,
        blueTeamScore: 2,
        redTeamScore: 1
    )
    ScoreActivityAttributes.ContentState.previewValue(
        matchState: .inProgress(periodInfo: .previewValue(name: "2nd Half", timeLeft: 20.minutes)),
        blueTeamScore: 2,
        redTeamScore: 1
    )
    ScoreActivityAttributes.ContentState.previewValue(
        matchState: .finished,
        blueTeamScore: 2,
        redTeamScore: 1
    )
}
