import SwiftUI

public struct TeamScoreView: View {
    let imageName: String
    let score: Int
    let isLeading: Bool

    public init(imageName: String, score: Int, isLeading: Bool) {
        self.imageName = imageName
        self.score = score
        self.isLeading = isLeading
    }

    public var body: some View {
        HStack(spacing: 4) {
            if isLeading {
                image

                text
            } else {
                text

                image
            }
        }
    }

    var image: some View {
        Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 28, height: 28)
    }

    var text: some View {
        Text(score.formatted())
            .monospacedDigit()
    }
}
