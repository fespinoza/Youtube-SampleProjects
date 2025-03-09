import OSLog

extension Logger {
    static func forCategory(_ category: String) -> os.Logger {
        .init(subsystem: "com.fespinozacast.youtube.MovieCatalog", category: category)
    }
}
