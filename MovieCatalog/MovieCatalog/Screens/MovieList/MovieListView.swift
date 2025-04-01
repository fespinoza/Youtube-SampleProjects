import SwiftUI
import Navigation
import MovieComponents

struct MovieListView: View {
    let movies: [MovieCardViewData]

    var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(
                columns: [
                    .init(.fixed(MovieCardSize.large.width), spacing: 8, alignment: .top),
                    .init(.fixed(MovieCardSize.large.width), spacing: 8, alignment: .top),
                ],
                alignment: HorizontalAlignment.center,
                spacing: 24
            ) {
                ForEach(movies) { movie in
                    NavigationButton(push: .movieDetails(id: movie.id)) {
                        MovieCardView(viewData: movie)
                    }
                }
            }
        }
        .movieCardSize(.large)
    }
}

#Preview {
    MovieListView(
        movies: [
            .eternalSunshine(),
            .gladiatorTwo(),
            .kindaPregnant(),
            .ironMan(),
        ]
    )
}
