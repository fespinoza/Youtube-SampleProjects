import Foundation
import SwiftUI
import WidgetKit

#if canImport(ActivityKit)
    import ActivityKit

    extension ScoreActivityAttributes: ActivityAttributes {}
#endif

public struct ScoreActivityAttributes: Codable {
    public let blueTeam: Team
    public let redTeam: Team
    public let matchStartTime: Date

    public init(blueTeam: Team, redTeam: Team, matchStartTime: Date) {
        self.blueTeam = blueTeam
        self.redTeam = redTeam
        self.matchStartTime = matchStartTime
    }

    public struct ContentState: Codable, Hashable {
        public let matchState: MatchState
        public let blueTeamScore: Int
        public let redTeamScore: Int

        public init(matchState: MatchState, blueTeamScore: Int, redTeamScore: Int) {
            self.matchState = matchState
            self.blueTeamScore = blueTeamScore
            self.redTeamScore = redTeamScore
        }
    }

    public enum MatchState: Codable, Hashable {
        case notYetStarted
        case inProgress(periodInfo: PeriodInfo)
        case paused
        case finished
    }

    public struct PeriodInfo: Codable, Hashable {
        public let name: String
        public let currentTime: Date
        public let timeLeft: TimeInterval

        public var endTime: Date { currentTime.addingTimeInterval(timeLeft) }

        public init(name: String, currentTime: Date, timeLeft: TimeInterval) {
            self.name = name
            self.currentTime = currentTime
            self.timeLeft = timeLeft
        }
    }

    public struct Team: Codable, Hashable {
        public let name: String

        // WARNING: for this example, I'm using an `imageName` that will
        // be the name of an asset in the AssetCatalog of the LiveActivities target
        // for simplicity. Another approach would be needed for a production app
        public let imageName: String

        public init(name: String, imageName: String) {
            self.name = name
            self.imageName = imageName
        }
    }
}
