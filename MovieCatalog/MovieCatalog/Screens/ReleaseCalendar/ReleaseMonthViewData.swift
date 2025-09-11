import Foundation
import MovieModels

struct ReleaseMonthViewData: Identifiable, Equatable {
    let id = UUID()
    let year: String
    let month: String
    let movies: [UpcomingMovieViewData]

    var sectionTitle: String { "\(year) \(month)" }
}

extension ReleaseMonthViewData {
    static func previewValue(
        year: String = "2025",
        month: String = "February",
        movies: [UpcomingMovieViewData] = [.previewValue(), .previewValue(day: "28")]
    ) -> Self {
        .init(
            year: year,
            month: month,
            movies: movies
        )
    }
}

extension ReleaseMonthViewData {
    @MainActor static func buildCollection(from dto: [MovieSummary], genreStore: GenreStore) -> [Self] {
        var groups: [YearMonth: [MovieSummary]] = [:]
        for summary in dto {
            guard let releaseDate = summary.releaseDate.flatMap({ Utils.parseReleaseDate(from: $0) }) else {
                continue
            }

            let dateComponents = Calendar.current.dateComponents([.year, .month], from: releaseDate)
            guard
                let month = dateComponents.month,
                let year = dateComponents.year
            else {
                continue
            }

            let key = YearMonth(year: year, month: month)

            if groups[key] == nil {
                groups[key] = []
            }

            groups[key]?.append(summary)
        }

        let flatGroups = groups
            .sorted(by: { leftPair, rightPair in
                leftPair.key < rightPair.key
            })
            .map { (key: YearMonth, value: [MovieSummary]) in
                let date = DateComponents(calendar: .current, year: key.year, month: key.month).date ?? Date()

                return ReleaseMonthViewData(
                    year: date.formatted(.dateTime.year()),
                    month: date.formatted(.dateTime.month()),
                    movies: value.compactMap { UpcomingMovieViewData(dto: $0, genreStore: genreStore) }
                )
            }

        // TODO: sort movies within the dates

        return flatGroups
    }

    private struct YearMonth: Hashable, Comparable {
        static func < (lhs: ReleaseMonthViewData.YearMonth, rhs: ReleaseMonthViewData.YearMonth) -> Bool {
            (lhs.year, lhs.month) < (rhs.year, rhs.month)
        }

        let year: Int
        let month: Int
    }

    private struct Group {
        let year: Int
        let month: Int
        let movies: [MovieSummary]
    }
}
