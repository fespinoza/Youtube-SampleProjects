import SwiftUI
import MovieModels

struct ReleaseCalendarView: View {
    let months: [ReleaseMonthViewData]

    var body: some View {
        List {
            ForEach(months) { month in
                Section {
                    ForEach(month.movies) { movie in
                        NavigationButton(push: .movieDetails(id: movie.id)) {
                            UpcomingMovieView(movie: movie)
                        }
                        .tint(.primary)
                    }
                } header: {
                    Text(month.sectionTitle)
                }
            }
        }
        .listStyle(.grouped)
        .navigationTitle("Release Calendar")
    }
}

#Preview {
    NavigationStack {
        ReleaseCalendarView(
            months: [
                .previewValue(),
                .previewValue(month: "March"),
                .previewValue(month: "April"),
                .previewValue(month: "May"),
                .previewValue(month: "June"),
                .previewValue(month: "July"),
                .previewValue(month: "August"),
            ]
        )
    }
}
