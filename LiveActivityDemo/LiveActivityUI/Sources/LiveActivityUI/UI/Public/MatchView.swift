import LiveActivityContent
import SwiftUI

public struct MatchView: View {
    var attrs: ScoreActivityAttributes
    var state: ScoreActivityAttributes.ContentState

    @Environment(\.activityFamily) var activityFamily

    public init(attrs: ScoreActivityAttributes, state: ScoreActivityAttributes.ContentState) {
        self.attrs = attrs
        self.state = state
    }

    public var body: some View {
        Group {
            switch activityFamily {
            case .small:
                small

            case .medium:
                medium

            @unknown default:
                medium
            }
        }.onAppear {
            print("----------------- MYWIDGET ------------------")
            dump(attrs)
            dump(state)
        }
    }

    var small: some View {
        VStack(alignment: .center) {
            HStack(spacing: 7) {
                TeamView(name: attrs.blueTeam.name, imageName: attrs.blueTeam.imageName)

                ScoreView(blue: state.blueTeamScore, red: state.redTeamScore)

                TeamView(name: attrs.redTeam.name, imageName: attrs.redTeam.imageName)
            }

            MatchStateView.SmallView(attrs: attrs, state: state)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .foregroundStyle(.white) // semantic?
        .background(BackgroundGradient(matchState: state.matchState))
    }

    var medium: some View {
        HStack(spacing: 18) {
            TeamView(name: attrs.blueTeam.name, imageName: attrs.blueTeam.imageName)

            MatchStateView(attrs: attrs, state: state)

            TeamView(name: attrs.redTeam.name, imageName: attrs.redTeam.imageName)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .foregroundStyle(.white) // semantic?
        .background(BackgroundGradient(matchState: state.matchState))
    }
}
