import SwiftUI

struct MovieCardViewData: Identifiable, Equatable {
    let id: MovieID
    let title: String
    let image: ImageViewData
    let style: Style

    init(
        id: MovieID,
        title: String,
        image: ImageViewData,
        style: Style = .basic
    ) {
        self.id = id
        self.title = title
        self.image = image
        self.style = style
    }

    enum Style: Equatable {
        case basic
        case upcoming(releaseDate: String)
        case ranking(ranking: String)
    }
}

extension MovieCardViewData {
    static func basic(from summary: MovieSummary) -> Self {
        .init(
            id: summary.id,
            title: summary.title,
            image: .remote(from: summary.posterURL),
            style: .basic
        )
    }

    static func upcoming(from summary: MovieSummary) -> Self {
        .init(
            id: summary.id,
            title: summary.title,
            image: .remote(from: summary.posterURL),
            style: (summary.releaseDate.flatMap { .upcoming(releaseDate: Utils.formattedUpcomingReleaseDate(from: $0)) }) ?? .basic
        )
    }

    static func ranking(from summary: MovieSummary, ranking: Int) -> Self {
        .init(
            id: summary.id,
            title: summary.title,
            image: .remote(from: summary.posterURL),
            style: .ranking(ranking: "#\(ranking)")
        )
    }
}

extension MovieCardViewData {
    static func previewValue(
        id: MovieID = .randomPreviewId(),
        title: String = "Gladiator II",
        image: ImageViewData = .image(Image(.Movie.Gladiator.small)),
        style: MovieCardViewData.Style = .basic
    ) -> Self {
        .init(
            id: id,
            title: title,
            image: image,
            style: style
        )
    }

    static func gladiatorTwo() -> Self {
        .previewValue(
            title: "Gladiator II",
            image: .image(Image(.Movie.Gladiator.small))
        )
    }

    static func kindaPregnant() -> Self {
        .previewValue(
            title: "Kinda Pregnent",
            image: .image(Image(.Movie.KindaPregnant.small))
        )
    }

    static func eternalSunshine() -> Self {
        .previewValue(
            title: "Eternal Sunshine of the Spotless Mind",
            image: .image(Image(.Movie.EternalSunshine.small))
        )
    }

    static func theApprentice() -> Self {
        .previewValue(
            id: .init(1182047),
            title: "The Apprentice",
            image: .image(Image(.Movie.TheApprentice.small))
        )
    }
}
