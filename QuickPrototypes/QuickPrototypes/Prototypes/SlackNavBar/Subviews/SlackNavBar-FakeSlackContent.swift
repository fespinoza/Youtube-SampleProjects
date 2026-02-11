import SwiftUI

extension SlackNavBar {
    struct FakeSlackContent: View {
        var body: some View {
            VStack(alignment: .leading, spacing: 24) {
                section(
                    title: "External Connections",
                    items: [
                        .lock("external-provider"),
                        .lock("project-poc"),
                    ],
                )

                Divider()

                section(
                    title: "Starred",
                    items: [
                        .channel("development-team"),
                        .channel("app-team"),
                        .channel("ios-team"),
                        .lock("internal-app-team"),
                    ],
                )

                Divider()

                section(
                    title: "Channels",
                    items: [
                        .channel("discover"),
                        .channel("app-store-reviews"),
                        .channel("books"),
                        .channel("coffee-machine"),
                    ],
                )

                Divider()

                section(
                    title: "Others",
                    items: [
                        .channel("all groups"),
                        .channel("runs"),
                        .channel("gaming"),
                        .channel("sports"),
                        .channel("new-recruits"),
                        .channel("alerts"),
                        .channel("new-releases"),
                        .channel("research"),
                    ],
                )

                Divider()

                section(
                    title: "Team Members",
                    items: [
                        .person("Ali"),
                        .person("Snadre Mogens"),
                        .person("Sicily"),
                        .person("Zara"),
                        .person("Robert"),
                        .person("Paul"),
                        .person("Guy"),
                    ],
                )
            }
            .padding()
        }

        func section(title: String, items: [RowItem]) -> some View {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text(title)
                        .font(.footnote.bold())
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundStyle(.secondary)
                }

                ForEach(items) { item in
                    HStack(spacing: 12) {
                        Image(systemName: item.icon)
                            .foregroundStyle(.secondary)

                        Text(item.title)

                        Spacer()
                    }
                    .padding(.vertical, 4)
                }
            }
        }

        enum RowItem: Identifiable {
            case channel(String)
            case lock(String)
            case person(String)

            var id: String {
                title
            }

            var title: String {
                switch self {
                case let .channel(name), let .lock(name), let .person(name):
                    name
                }
            }

            var icon: String {
                switch self {
                case .channel:
                    "number"
                case .lock:
                    "lock"
                case .person:
                    "person.circle"
                }
            }
        }
    }
}
