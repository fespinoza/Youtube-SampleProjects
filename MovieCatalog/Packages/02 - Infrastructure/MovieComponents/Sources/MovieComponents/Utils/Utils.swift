import Foundation

public enum Utils {
    public static func parseReleaseDate(from dateString: String?) -> Date? {
        guard let dateString else { return nil }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")

        guard let date = dateFormatter.date(from: dateString) else { return nil }

        return date
    }

    public static func formattedUpcomingReleaseDate(from dateString: String) -> String {
        guard let date = parseReleaseDate(from: dateString) else {
            return "" // TODO: what if nil?
        }

        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let currentYear = Calendar.current.component(.year, from: Date())

        return if currentYear == year {
            date.formatted(.dateTime.day().month())
        } else {
            date.formatted(.dateTime.day().month().year())
        }
    }

    public static func formatRuntime(minutes: Int) -> String {
        let hours = minutes / 60
        let remainingMinutes = minutes % 60

        return if hours > 0 && remainingMinutes > 0 {
            "\(hours)h \(remainingMinutes)m"
        } else if hours > 0 {
            "\(hours)h"
        } else {
            "\(remainingMinutes)m"
        }
    }

    public static func formattedReleaseYear(from string: String?) -> String {
        guard
            let string,
            let date = parseReleaseDate(from: string)
        else {
            return ""
        }

        let year = Calendar.current.component(.year, from: date)
        return year.formatted(.number.grouping(.never))
    }

    public static func formattedReleaseDate(from string: String?) -> String {
        guard
            let string,
            let date = parseReleaseDate(from: string)
        else {
            return ""
        }

        return date.formatted(date: .abbreviated, time: .omitted)
    }

    public static func formattedRequestDate(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
}
