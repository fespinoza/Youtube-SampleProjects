import SwiftUI
import Navigation

public struct ContentSection<Content: View>: View {
    var title: String
    var destination: PushDestination?
    @ViewBuilder var content: () -> Content

    public init(
        title: String,
        destination: PushDestination? = nil,
        content: @escaping () -> Content
    ) {
        self.title = title
        self.destination = destination
        self.content = content
    }

    public var body: some View {
        VStack(spacing: .spacingSM) {
            header

            content()
        }
    }

    var header: some View {
        Group {
            if let destination {
                NavigationButton(push: destination) {
                    HStack {
                        Text(title)
                            .font(.title2.bold())
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.secondary)
                            .font(.body.bold())
                        Spacer()
                    }
                    .tint(.primary)
                }
            } else {
                Text(title)
                    .font(.title2.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(.horizontal, .spacingM)
    }
}

#Preview {
    NavigationStack {
        ContentSection(title: "Hello") {
            Text("World")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, .spacingM)
        }
    }
}
