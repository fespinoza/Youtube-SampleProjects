import SwiftUI

struct ContentSection<Content: View, Destination: Hashable>: View {
    var title: String
    var destination: Destination?
    @ViewBuilder var content: () -> Content

    init(
        title: String,
        destination: Destination? = nil,
        content: @escaping () -> Content
    ) {
        self.title = title
        self.destination = destination
        self.content = content
    }

    var body: some View {
        VStack(spacing: .spacingSM) {
            header

            content()
        }
    }

    var header: some View {
        Group {
            if let destination {
                NavigationLink(value: destination) {
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

extension ContentSection where Destination == String {
    init(title: String, @ViewBuilder content: @escaping () -> Content) {
        self.init(
            title: title,
            destination: nil,
            content: content
        )
    }
}

#Preview {
    NavigationStack {
        VStack(spacing: .spacingL) {
            ContentSection(title: "Hello") {
                Text("World")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, .spacingM)
            }

            ContentSection(title: "Hola", destination: "Spanish") {
                Text("Mundo")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, .spacingM)
            }
        }
    }
}
