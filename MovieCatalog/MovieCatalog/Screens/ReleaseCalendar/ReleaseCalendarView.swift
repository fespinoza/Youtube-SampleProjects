import SwiftUI

struct ReleaseCalendarView: View {
    let months: [ReleaseMonthViewData]

    var body: some View {
        List {
            ForEach(months) { month in
                Section {
                    ForEach(month.movies) { movie in
                        NavigationLink(value: movie.id) {
                            UpcomingMovieView(movie: movie)
                        }
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
