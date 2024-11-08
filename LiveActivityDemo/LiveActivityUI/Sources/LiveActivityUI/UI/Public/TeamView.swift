import SwiftUI

public struct TeamView: View {
    let name: String
    let imageName: String

    @Environment(\.activityFamily) private var activityFamily

    public init(name: String, imageName: String) {
        self.name = name
        self.imageName = imageName
    }

    var imageSize: CGFloat { activityFamily == .small ? 40 : 66 }

    public var body: some View {
        VStack(spacing: 4) {
            if activityFamily != .small {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: imageSize, height: imageSize)
            }

            Text(name)
                .font(.caption.bold())
        }
    }
}
