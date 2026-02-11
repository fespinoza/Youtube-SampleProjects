import SwiftUI

extension SlackNavBar {
    struct Logo: View {
        var body: some View {
            Circle()
                .foregroundStyle(Color(uiColor: .black))
                .overlay {
                    Text("S")
                        .foregroundStyle(.white)
                        .fontWeight(.black)
                        .italic()
                }
                .frame(size: 30)
        }
    }
}

