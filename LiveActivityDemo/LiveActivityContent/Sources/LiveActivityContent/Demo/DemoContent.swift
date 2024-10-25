import Foundation

public struct DemoContent {
    public typealias Content = ScoreActivityAttributes.ContentState

    public init() {}

    public func notYetStarted() -> Content {
        .init(matchState: .notYetStarted, blueTeamScore: 0, redTeamScore: 0)
    }

    public func matchStart() -> Content {
        .init(
            matchState: .inProgress(
                periodInfo: .init(
                    name: "1st half",
                    currentTime: Date(),
                    timeLeft: 45.minutes
                )
            ),
            blueTeamScore: 0,
            redTeamScore: 0
        )
    }

    public func firstGoal() -> Content {
        .init(
            matchState: .inProgress(
                periodInfo: .init(
                    name: "1st half",
                    currentTime: Date(),
                    timeLeft: 25.minutes
                )
            ),
            blueTeamScore: 1,
            redTeamScore: 0
        )
    }

    public func halfTime() -> Content {
        .init(
            matchState: .paused,
            blueTeamScore: 1,
            redTeamScore: 0
        )
    }

    public func secondGoal() -> Content {
        .init(
            matchState: .inProgress(
                periodInfo: .init(
                    name: "2nd half",
                    currentTime: Date(),
                    timeLeft: 30.minutes
                )
            ),
            blueTeamScore: 1,
            redTeamScore: 1
        )
    }

    public func thirdGoal() -> Content {
        .init(
            matchState: .inProgress(
                periodInfo: .init(
                    name: "2nd half",
                    currentTime: Date(),
                    timeLeft: 5.minutes
                )
            ),
            blueTeamScore: 2,
            redTeamScore: 1
        )
    }

    public func matchEnded() -> Content {
        .init(
            matchState: .finished,
            blueTeamScore: 2,
            redTeamScore: 1
        )
    }
}
