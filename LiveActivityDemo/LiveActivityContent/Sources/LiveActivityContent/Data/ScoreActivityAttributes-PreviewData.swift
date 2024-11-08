import Foundation

public extension ScoreActivityAttributes {
    static func previewValue(
        blueTeam: Team = .previewValue(
            name: "Man United",
            imageName: "manchester"
        ),
        redTeam: Team = .previewValue(
            name: "Arsenal",
            imageName: "arsenal"
        ),
        matchStartTime: Date = Date()
    ) -> Self {
        .init(
            blueTeam: blueTeam,
            redTeam: redTeam,
            matchStartTime: matchStartTime
        )
    }
}

public extension ScoreActivityAttributes.Team {
    static func previewValue(
        name: String = "Man United",
        imageName: String = "manchester"
    ) -> Self {
        .init(
            name: name,
            imageName: imageName
        )
    }
}

public extension ScoreActivityAttributes.PeriodInfo {
    static func previewValue(
        name: String = "1st Half",
        currentTime: Date = Date(),
        timeLeft: TimeInterval = 45.minutes
    ) -> Self {
        .init(
            name: name,
            currentTime: currentTime,
            timeLeft: timeLeft
        )
    }
}

public extension ScoreActivityAttributes.ContentState {
    static func previewValue(
        matchState: ScoreActivityAttributes.MatchState = .inProgress(periodInfo: .previewValue(timeLeft: 32.minutes)),
        blueTeamScore: Int = 2,
        redTeamScore: Int = 1
    ) -> Self {
        .init(
            matchState: matchState,
            blueTeamScore: blueTeamScore,
            redTeamScore: redTeamScore
        )
    }
}
