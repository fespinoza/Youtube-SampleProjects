import SwiftUI

struct BasicStateView<ViewData: Equatable, LoadingContent: View, DataContent: View>: View {
    @Binding var state: BasicLoadingState<ViewData>
    @ViewBuilder var loadingContent: () -> LoadingContent
    @ViewBuilder var dataContent: (ViewData) -> DataContent
    var fetchData: () async throws -> ViewData

    var body: some View {
        Group {
            switch state {
            case .idle,
                  .loading:
                loadingContent()
                    .disabled(true)

            case let .dataLoaded(viewData):
                dataContent(viewData)

            case let .error(error):
                ContentUnavailableView(
                    "Error",
                    systemImage: "xmark",
                    description: Text(error.localizedDescription)
                )
                .foregroundStyle(.primary, .red)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .task { await initialLoad() }
    }

    func initialLoad() async {
        guard .idle == state else { return }
        await performFetchData()
    }

    private func performFetchData(showLoading: Bool = true) async {
        if showLoading { withAnimation { state = .loading } }

        do {
            let viewData = try await fetchData()
            withAnimation { state = .dataLoaded(viewData) }
        } catch {
            withAnimation { state = .error(error) }
        }
    }
}

private struct Demo: View {
    @State var state: BasicLoadingState<String> = .idle
    @State var secondsDelay: Int = 2

    var body: some View {
        VStack {
            BasicStateView(
                state: $state,
                loadingContent: {
                    ProgressView()
                },
                dataContent: { text in
                    Text(text)
                        .font(.title)
                        .bold()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.gray)
                },
                fetchData: {
                    try await Task.sleep(for: .seconds(secondsDelay))
                    return "Sample Text"
                }
            )

            VStack {
                Text(state.typeName)

                HStack {
                    Button("Idle", action: { set(.idle) })
                    Button("Loading", action: { set(.loading) })
                    Button("Data", action: { set(.dataLoaded("Sample Text")) })
                    Button("Error", action: { set(.error(CancellationError())) })
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }

    func set(_ newState: BasicLoadingState<String>) {
        withAnimation { state = newState }
    }
}

#Preview {
    Demo()
}
