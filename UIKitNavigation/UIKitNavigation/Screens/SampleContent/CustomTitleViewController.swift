import UIKit

class CustomTitleViewController: SimpleContentViewController {
    override init(titleText: String, image: UIImage?) {
        super.init(titleText: titleText, image: image)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }

    // MARK: - Setup Scroll View and Stack

    override func setupNavigationBar() {
        navigationItem.title = titleText

        let titleView = TitleIconView(title: titleText, systemImageName: "tray.full")
        navigationItem.titleView = titleView
    }
}

#Preview {
    UINavigationController(
        rootViewController: CustomTitleViewController(
            titleText: "Hello World",
            image: UIImage(systemName: "globe")
        )
    )
}
