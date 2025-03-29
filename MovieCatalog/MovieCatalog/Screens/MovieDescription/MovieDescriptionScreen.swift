import SwiftUI

struct MovieDescriptionScreen: View {
    let movieID: MovieID

    init(movieID: MovieID) {
        self.movieID = movieID
        self._state = .init(initialValue: .idle)
    }

    init(movieID: MovieID, title: String, description: String) {
        self.movieID = movieID
        self._state = .init(
            initialValue: .dataLoaded(
                .init(title: title, description: description)
            )
        )
    }

    @State private var state: BasicLoadingState<ViewData>
    @Environment(\.movieDataClient.movieDescription) private var movieDescription

    var body: some View {
        BasicStateView(
            state: $state,
            dataContent: { viewData in
                MovieDescriptionView(
                    title: viewData.title,
                    description: viewData.description
                )
            },
            fetchData: { try await .init(tuple: movieDescription(movieID)) }
        )
    }
}

extension MovieDescriptionScreen {
    struct ViewData: Equatable {
        let title: String
        let description: String

        init(title: String, description: String) {
            self.title = title
            self.description = description
        }

        init(tuple: (title: String, description: String)) {
            self = .init(title: tuple.title, description: tuple.description)
        }
    }
}
