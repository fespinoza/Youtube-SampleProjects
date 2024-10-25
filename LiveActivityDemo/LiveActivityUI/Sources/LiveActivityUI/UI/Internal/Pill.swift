import SwiftUI

struct Pill: View {
    let text: String
    let color: Color

    var body: some View {
        Text(text)
            .foregroundStyle(color)
            .font(.caption)
            .padding(4)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(color, lineWidth: 1)
            )
    }
}
