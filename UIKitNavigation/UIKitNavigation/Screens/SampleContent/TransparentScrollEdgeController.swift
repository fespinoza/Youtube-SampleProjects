import UIKit

class TransparentScrollEdgeViewController: SimpleContentViewController {
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

        // if someome turns on `prefersLargeTitles`, we don't want this
        // screen to be affected at all, then we enforce that with this value
        navigationItem.largeTitleDisplayMode = .never

        let scrollEdgeAppearance = UINavigationBarAppearance()
        scrollEdgeAppearance.configureWithTransparentBackground()
        scrollEdgeAppearance.titleTextAttributes = [.foregroundColor: UIColor.clear]
        navigationItem.scrollEdgeAppearance = scrollEdgeAppearance
    }
}

#Preview {
    UINavigationController(
        rootViewController: TransparentScrollEdgeViewController(
            titleText: "Hello World",
            image: UIImage(systemName: "globe")
        )
    )
}
