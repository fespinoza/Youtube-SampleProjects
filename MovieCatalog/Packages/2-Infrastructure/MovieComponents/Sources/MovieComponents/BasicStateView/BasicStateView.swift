import SwiftUI

public struct BasicStateView<ViewData: Equatable, LoadingContent: View, DataContent: View>: View {
    @Binding var state: BasicLoadingState<ViewData>
    @ViewBuilder var loadingContent: () -> LoadingContent
    @ViewBuilder var dataContent: (ViewData) -> DataContent
    var fetchData: () async throws -> ViewData

    public init(
        state: Binding<BasicLoadingState<ViewData>>,
        loadingContent: @escaping () -> LoadingContent,
        dataContent: @escaping (ViewData) -> DataContent,
        fetchData: @escaping () async throws -> ViewData
    ) {
        _state = state
        self.loadingContent = loadingContent
        self.dataContent = dataContent
        self.fetchData = fetchData
    }

    public var body: some View {
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
                    label: {
                        Label("Error", systemImage: "xmark")
                            .foregroundStyle(.primary, .red)
                    }) {
                        Text(error.localizedDescription)
                    } actions: {
                        Button("Retry", action: retry)
                            .buttonStyle(.borderedProminent)
                    }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .task { await initialLoad() }
        .refreshable { await performFetchData(showLoading: false) }
    }

    func initialLoad() async {
        guard state == .idle else { return }
        await performFetchData()
    }

    func retry() {
        Task { await performFetchData() }
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

public extension BasicStateView where LoadingContent == LoadingStateView {
    init(
        state: Binding<BasicLoadingState<ViewData>>,
        dataContent: @escaping (ViewData) -> DataContent,
        fetchData: @escaping () async throws -> ViewData
    ) {
        _state = state
        self.loadingContent = { LoadingStateView() }
        self.dataContent = dataContent
        self.fetchData = fetchData
    }
}

private struct Demo: View {
    @State var state: BasicLoadingState<String> = .idle
    @State var secondsDelay: Int = 3

    var body: some View {
        VStack {
            BasicStateView(
                state: $state,
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
