import Foundation
import UniformTypeIdentifiers

struct Folder: Identifiable, Hashable {
    var id: URL { url }
    var name: String
    var url: URL
    var contents: [ImageFile]
}

struct ImageFile: Identifiable, Hashable {
    var id: URL { url }
    var name: String
    var url: URL
}

extension ImageFile {
    static func testValue(name: String = "Sample Image", url: URL = .randomValue()) -> Self {
        .init(name: name, url: url)
    }
}

extension Folder {
    static func testValue(
        name: String = "Test Folder",
        url: URL = .randomValue(),
        contents: [ImageFile] = [
            .testValue(name: "Image #1"),
            .testValue(name: "Image #2"),
            .testValue(name: "Image #3"),
        ]
    ) -> Self {
        .init(name: name, url: url, contents: contents)
    }
}

extension URL {
    static func randomValue() -> URL {
        // https://unsplash.com/photos/a-large-building-with-a-glass-front-and-stairs-leading-up-to-it-nP5MJquAZiY
        URL(string: "https://images.unsplash.com/photo-1640019480604-dea20b153604?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTQ3fHxvc2xvfGVufDB8fDB8fHww&random=\((0...30_000_000).randomElement() ?? -1)")!
    }
}

extension Folder {
    static func build(from url: URL, storeBookmarkData: Bool = true) throws -> Folder {
        if !url.startAccessingSecurityScopedResource() {
            logger.error("""
                startAccessingSecurityScopedResource returned false. \
                This directory might not need it, or this URL might not be a security scoped URL, \
                or maybe something's wrong?
            """)
        }

        if storeBookmarkData {
            try saveBookmarkData(for: url)
        }

        let rawContents = (
            try FileManager.default.contentsOfDirectory(
                at: url,
                includingPropertiesForKeys: nil,
                options: [.skipsHiddenFiles, .skipsSubdirectoryDescendants]
            )
        )

        let contents: [ImageFile] = rawContents
            .filter { (fileType(for: $0)?.isSubtype(of: .image)) ?? false }
            .compactMap { ImageFile(name: $0.lastPathComponent, url: $0) }

        return Folder(
            name: url.lastPathComponent,
            url: url,
            contents: contents
        )
    }

    private static func fileType(for url: URL) -> UTType? {
        do {
            return try url.resourceValues(forKeys: [.contentTypeKey]).contentType
        } catch {
            return nil
        }
    }

    private static func saveBookmarkData(for url: URL) throws {
        let bookmarkData = try url.bookmarkData(
            options: .withSecurityScope,
            includingResourceValuesForKeys: nil,
            relativeTo: nil
        )

        UserDefaults.standard.set(bookmarkData, forKey: bookmarkDataKey(for: url))
    }

    private static func bookmarkDataKey(for url: URL) -> String {
        "bookmark_\(url)"
    }

    static func readData(for url: URL) throws -> Folder {
        guard let bookmarkData = UserDefaults.standard.data(forKey: bookmarkDataKey(for: url)) else {
            throw FolderError.noBookmarkData(url: url)
        }

        var isStale = false
        let bookmarkURL = try URL(
            resolvingBookmarkData: bookmarkData,
            options: .withSecurityScope,
            relativeTo: nil,
            bookmarkDataIsStale: &isStale
        )

        if isStale {
            throw FolderError.bookmarkStale(url: url, bookmark: bookmarkURL)
        } else {
            return try Folder.build(from: bookmarkURL, storeBookmarkData: false)
        }
    }
}

enum FolderError: Error {
    case noBookmarkData(url: URL)
    case bookmarkStale(url: URL, bookmark: URL)
}
