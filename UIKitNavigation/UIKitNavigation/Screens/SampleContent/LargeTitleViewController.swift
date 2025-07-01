import UIKit

class LargeTitleViewController: SimpleContentViewController {
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
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true

        let scrollEdgeAppearance = UINavigationBarAppearance()
        scrollEdgeAppearance.configureWithTransparentBackground()
        scrollEdgeAppearance.titleTextAttributes = [.foregroundColor: UIColor.red]
        scrollEdgeAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.blue]

        navigationItem.scrollEdgeAppearance = scrollEdgeAppearance

        let compactScrollEdge = UINavigationBarAppearance()
        compactScrollEdge.configureWithDefaultBackground()
        compactScrollEdge.titleTextAttributes = [.foregroundColor: UIColor.blue]
        compactScrollEdge.largeTitleTextAttributes = [.foregroundColor: UIColor.red]

        navigationItem.compactScrollEdgeAppearance = compactScrollEdge

        let compact = UINavigationBarAppearance()
        compactScrollEdge.configureWithDefaultBackground()
        compactScrollEdge.titleTextAttributes = [.foregroundColor: UIColor.green]
        compactScrollEdge.largeTitleTextAttributes = [.foregroundColor: UIColor.yellow]
        navigationItem.compactAppearance = compact

        navigationController?.navigationBar.compactAppearance = compact
        navigationController?.navigationBar.compactScrollEdgeAppearance = compactScrollEdge
    }
}

#Preview {
    UINavigationController(
        rootViewController: LargeTitleViewController(
            titleText: "Hello World",
            image: UIImage(systemName: "globe")
        )
    )
}
