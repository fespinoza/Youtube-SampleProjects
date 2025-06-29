import UIKit

enum Example: String, CaseIterable {
    case largeTitle
    case simple
    case stickyHeader
    case badlyConfigured
    case transparentScrollEdge
    case customTitleView
    case segmentedControlTitleView
}

class SimpleContentViewController: UIViewController {
    let titleText: String
    let image: UIImage?

    // MARK: - UI Elements

    private let scrollView = UIScrollView()
    private let contentStack = UIStackView()

    // MARK: - Init

    init(titleText: String, image: UIImage?) {
        self.titleText = titleText
        self.image = image
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        setupNavigationBar()
        setupScrollView()
        setupContent()
    }

    // MARK: - Setup Scroll View and Stack

    func setupNavigationBar() {
        navigationItem.title = titleText
    }

    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        contentStack.axis = .vertical
        contentStack.spacing = 20
        contentStack.alignment = .center
        contentStack.translatesAutoresizingMaskIntoConstraints = false

        scrollView.addSubview(contentStack)

        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            contentStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            contentStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            contentStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
            contentStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40)
        ])
    }

    // MARK: - Setup Content

    private func setupContent() {
        let titleLabel = UILabel()
        titleLabel.text = "Content"
        titleLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0

        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemBlue
        imageView.translatesAutoresizingMaskIntoConstraints = false

        contentStack.addArrangedSubview(imageView)
        contentStack.addArrangedSubview(titleLabel)

        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 150),
            imageView.widthAnchor.constraint(equalToConstant: 150)
        ])

        let paragraphLabel = UILabel()
        paragraphLabel.text = """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque at dui a est vestibulum congue. \
        Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. \
        Sed ac justo eu nulla fermentum tempor. Vestibulum ante ipsum primis in faucibus orci luctus \
        et ultrices posuere cubilia curae.
        
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque at dui a est vestibulum congue. \
        Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. \
        Sed ac justo eu nulla fermentum tempor. Vestibulum ante ipsum primis in faucibus orci luctus \
        et ultrices posuere cubilia curae.
        
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque at dui a est vestibulum congue. \
        Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. \
        Sed ac justo eu nulla fermentum tempor. Vestibulum ante ipsum primis in faucibus orci luctus \
        et ultrices posuere cubilia curae.
        
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque at dui a est vestibulum congue. \
        Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. \
        Sed ac justo eu nulla fermentum tempor. Vestibulum ante ipsum primis in faucibus orci luctus \
        et ultrices posuere cubilia curae.
        
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque at dui a est vestibulum congue. \
        Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. \
        Sed ac justo eu nulla fermentum tempor. Vestibulum ante ipsum primis in faucibus orci luctus \
        et ultrices posuere cubilia curae.
        
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque at dui a est vestibulum congue. \
        Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. \
        Sed ac justo eu nulla fermentum tempor. Vestibulum ante ipsum primis in faucibus orci luctus \
        et ultrices posuere cubilia curae.
        """
        paragraphLabel.numberOfLines = 0
        paragraphLabel.font = UIFont.systemFont(ofSize: 16)
        paragraphLabel.textAlignment = .left
        contentStack.addArrangedSubview(paragraphLabel)

        for title in Example.allCases {
            let button = makeButton(with: title.rawValue)
            button.setImage(UIImage(systemName: "chevron.right"), for: .normal)

            button.addAction(
                UIAction { [weak self] _ in
                    guard let self else { return }

                    let controller: UIViewController = switch title {
                    case .simple:
                        SimpleContentViewController(titleText: title.rawValue, image: UIImage(systemName: "square"))

                    case .largeTitle:
                        LargeTitleViewController(titleText: title.rawValue, image: UIImage(systemName: "square"))

                    case .stickyHeader:
                        StickyHeaderViewController(image: UIImage(resource: .tedLasso), title: "Ted Lasso")

                    case .badlyConfigured:
                        BadlyConfiguredViewController(titleText: title.rawValue, image: UIImage(systemName: "square"))

                    case .transparentScrollEdge:
                        TransparentScrollEdgeViewController(
                            titleText: title.rawValue,
                            image: UIImage(systemName: "square")
                        )

                    case .customTitleView:
                        CustomTitleViewController(titleText: title.rawValue, image: UIImage(systemName: "square"))
                        
                    case .segmentedControlTitleView:
                        PeopleListViewController()
                    }

                    self.navigationController?.pushViewController(controller, animated: true)
                },
                for: .touchUpInside
            )

            contentStack.addArrangedSubview(button)
        }

        let sheet = makeButton(with: "Sheet Content")
        sheet.addAction(
            UIAction { [weak self] _ in
                guard let self else { return }
                
                let sheetContent = SimpleContentViewController(
                    titleText: "Sheet Content",
                    image: UIImage(systemName: "circle")
                )
                sheetContent.navigationItem.rightBarButtonItem = UIBarButtonItem(
                    title: "Close",
                    primaryAction: UIAction { [weak sheetContent] _ in
                        sheetContent?.dismiss(animated: true)
                    }
                )
                self.present(
                    UINavigationController(rootViewController: sheetContent),
                    animated: true
                )
            },
            for: .touchUpInside
        )
        contentStack.addArrangedSubview(sheet)

        let fullScreen = makeButton(with: "Full Screen")
        fullScreen.addAction(
            UIAction { [weak self] _ in
                guard let self else { return }

                let fullScreenContent = SimpleContentViewController(
                    titleText: "Full Screen Content",
                    image: UIImage(systemName: "triangle")
                )
                fullScreenContent.navigationItem.rightBarButtonItem = UIBarButtonItem(
                    title: "Close",
                    primaryAction: UIAction { [weak fullScreenContent] _ in
                        fullScreenContent?.dismiss(animated: true)
                    }
                )
                let fullScreenNav = UINavigationController(rootViewController: fullScreenContent)
                fullScreenNav.modalPresentationStyle = .fullScreen

                self.present(fullScreenNav, animated: true)
            },
            for: .touchUpInside
        )
        contentStack.addArrangedSubview(fullScreen)
    }

    private func makeButton(with title: String) -> UIButton {
        var config = UIButton.Configuration.borderedProminent()
        config.imagePadding = 8
        config.imagePlacement = .trailing

        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.backgroundColor = UIColor.systemGray6
        button.layer.cornerRadius = 8
        button.configuration = config

        return button
    }
}

#Preview {
    UINavigationController(
        rootViewController: SimpleContentViewController(
            titleText: "Hello World",
            image: UIImage(systemName: "globe")
        )
    )
}

func largeTitleNavController() -> UINavigationController {
    let navController = UINavigationController(
        rootViewController: SimpleContentViewController(
            titleText: "Hello World",
            image: UIImage(systemName: "globe")
        )
    )
    
    navController.navigationBar.prefersLargeTitles = true
    
    return navController
}
