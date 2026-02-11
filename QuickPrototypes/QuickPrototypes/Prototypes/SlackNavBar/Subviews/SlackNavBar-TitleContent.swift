import SwiftUI

extension SlackNavBar {
    struct TitleContent: View {
        let text: String

        var body: some View {
            Text(text)
                .fontWeight(.black)
                .kerning(1.28)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
