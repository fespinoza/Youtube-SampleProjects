import Foundation
import Testing
import Config
import MovieModels

@Suite("Search Result Tests")
struct SearchResultTests {
    @Test("Decoding a polymorphic result list with actors and movies")
    func polymorphicResults() async throws {
        let jsonData = try #require(jsonText.data(using: .utf8))
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        let container: SearchResultsContainer = try decoder.decode(SearchResultsContainer.self, from: jsonData)

        #expect(container.results.count == 2)
    }

    let jsonText: String = """
    {
        "page": 1,
        "results": [
            {
                "backdrop_path": "/lI2AHx0QQrNnEkUqUG01QHUdLDW.jpg",
                "id": 638507,
                "title": "How to Train Your Dragon: Homecoming",
                "original_title": "How to Train Your Dragon: Homecoming",
                "overview": "It's been ten years since the dragons moved to the Hidden World, and even though Toothless doesn't live in New Berk anymore, Hiccup continues the holiday traditions he once shared with his best friend. But the Vikings of New Berk were beginning to forget about their friendship with dragons. Hiccup, Astrid, and Gobber know just what to do to keep the dragons in the villagers' hearts. And across the sea, the dragons have a plan of their own...",
                "poster_path": "/kXj2Qrfm994yLeuADqbOieU1mUH.jpg",
                "media_type": "movie",
                "adult": false,
                "original_language": "en",
                "genre_ids": [
                    16,
                    14,
                    12,
                    28,
                    10751
                ],
                "popularity": 7.2302,
                "release_date": "2019-12-03",
                "video": false,
                "vote_average": 8.018,
                "vote_count": 1001
            },
            {
                "id": 1253360,
                "name": "Pedro Pascal",
                "original_name": "Pedro Pascal",
                "media_type": "person",
                "adult": false,
                "popularity": 14.8723,
                "gender": 2,
                "known_for_department": "Acting",
                "profile_path": "/9VYK7oxcqhjd5LAH6ZFJ3XzOlID.jpg",
                "known_for": [
                    {
                        "backdrop_path": "/9zcbqSxdsRMZWHYtyCd1nXPr2xq.jpg",
                        "id": 82856,
                        "name": "The Mandalorian",
                        "original_name": "The Mandalorian",
                        "overview": "After the fall of the Galactic Empire, lawlessness has spread throughout the galaxy. A lone gunfighter makes his way through the outer reaches, earning his keep as a bounty hunter.",
                        "poster_path": "/eU1i6eHXlzMOlEq0ku1Rzq7Y4wA.jpg",
                        "media_type": "tv",
                        "adult": false,
                        "original_language": "en",
                        "genre_ids": [
                            10765,
                            10759,
                            18
                        ],
                        "popularity": 25.4404,
                        "first_air_date": "2019-11-12",
                        "vote_average": 8.424,
                        "vote_count": 10298,
                        "origin_country": [
                            "US"
                        ]
                    }
                ]
            }
        ],
        "total_pages": 1,
        "total_results": 2
    }
    """
}
