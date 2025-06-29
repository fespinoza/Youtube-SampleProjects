import UIKit

class BadlyConfiguredViewController: SimpleContentViewController {
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
        super.setupNavigationBar()

        navigationItem.title = titleText

        let scrollEdge = UINavigationBarAppearance()
        scrollEdge.configureWithOpaqueBackground()
        scrollEdge.backgroundColor = .white.withAlphaComponent(0.4)
        scrollEdge.titleTextAttributes = [.foregroundColor: UIColor.systemPink]

        // The configuration is global.
        // This means visiting this particular view controller
        // affects the styling of other view controllers
        navigationController?.navigationBar.scrollEdgeAppearance = scrollEdge
    }
}

#Preview {
    UINavigationController(
        rootViewController: BadlyConfiguredViewController(
            titleText: "Hello World",
            image: UIImage(systemName: "globe")
        )
    )
}
