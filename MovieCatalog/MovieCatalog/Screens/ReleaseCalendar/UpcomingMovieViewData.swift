import SwiftUI

struct UpcomingMovieViewData: Identifiable, Equatable {
    let id: MovieID
    let title: String
    let genres: String
    let image: ImageViewData
    let dayOfTheWeek: String
    let day: String
}

extension UpcomingMovieViewData {
    static func previewValue(
        id: MovieID = .randomPreviewId(),
        title: String = "Gladiator II",
        genres: String = "Action",
        image: ImageViewData = .image(Image(.Movie.Gladiator.small)),
        dayOfTheWeek: String = "Wed",
        day: String = "13"
    ) -> Self {
        .init(
            id: id,
            title: title,
            genres: genres,
            image: image,
            dayOfTheWeek: dayOfTheWeek,
            day: day
        )
    }
}

extension UpcomingMovieViewData {
    init?(dto: MovieSummary, genreStore: GenreStore) {
        guard let date = Utils.parseReleaseDate(from: dto.releaseDate) else {
            return nil
        }

        self.init(
            id: dto.id,
            title: dto.title,
            genres: genreStore.formattedGenres(for: dto.genreIds),
            image: .remote(from: dto.posterURL),
            dayOfTheWeek: date.formatted(.dateTime.weekday(.abbreviated)),
            day: date.formatted(.dateTime.day(.twoDigits))
        )
    }
}
