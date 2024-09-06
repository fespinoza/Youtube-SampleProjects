import SwiftUI
import OSLog

let logger = os.Logger(subsystem: "imageGallery", category: "main")

@main
struct ImageGalleryApp: App {
    @State var viewModel: MainViewModel = .init()
    @State var importFolder: Bool = false
    @AppStorage("folderUrls") var folderUrls: [URL] = []

    var body: some Scene {
        WindowGroup {
            MainView(viewModel: viewModel)
                .onAppear(perform: readFolders)
                .onChange(of: viewModel.folders) { _, newValue in
                    logger.debug("persist folders")
                    folderUrls = newValue.map(\.url)
                }
        }
        .commands {
            CommandGroup(after: .newItem) {
                Button("Import folder", action: { importFolder.toggle() })
                    .keyboardShortcut("i", modifiers: [.command])
                    .fileImporter(
                        isPresented: $importFolder,
                        allowedContentTypes: [.folder],
                        allowsMultipleSelection: false) { result in
                            switch result {
                            case .success(let success):
                                guard let url = success.first else { return }
                                let newFolder: Folder
                                do {
                                    newFolder = try Folder.build(from: url)
                                } catch {
                                    logger.error("\(error.localizedDescription)")
                                    newFolder = Folder(name: url.lastPathComponent, url: url, contents: [])
                                }
                                viewModel.folders.append(newFolder)
                                viewModel.selectedFolder = newFolder

                            case .failure(let failure):
                                logger.error("oh no \(failure)")
                            }
                        }
            }
        }
    }

    func readFolders() {
        let folders = folderUrls.compactMap { url in
            do {
                return try Folder.readData(for: url)
            } catch {
                logger.error("\(error.localizedDescription)")
                return Folder(name: url.lastPathComponent, url: url, contents: [])
            }
        }

        viewModel.folders = folders
        viewModel.selectedFolder = folders.first
    }
}
