import SwiftUI

struct MatchStartTimeView: View {
    let startTime: Date

    var body: some View {
        VStack {
            Text("Starts")
            Text(startTime.formatted(date: .omitted, time: .shortened))
        }
        .bold()
    }
}
