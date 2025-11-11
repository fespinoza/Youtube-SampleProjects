import MovieComponents
import SwiftUI

struct UpcomingMovieView: View {
    let movie: UpcomingMovieViewData

    var body: some View {
        HStack(spacing: .spacingML) {
            VStack {
                Text(movie.dayOfTheWeek)
                    .font(.caption)
                Text(movie.day)
                    .font(.title)
                    .fontDesign(.monospaced)
            }
            .fontWeight(.bold)

            VStack(alignment: .leading) {
                Text(movie.title)
                    .fontWeight(.bold)
                Text(movie.genres)
                    .font(.caption)
                    .foregroundStyle(Color.secondary)
            }

            Spacer()

            CustomAsyncImage(state: movie.image) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .offset(x: 0, y: 25)
            }
            .frame(width: 110, height: 110)
            .clipped()
        }
    }
}
