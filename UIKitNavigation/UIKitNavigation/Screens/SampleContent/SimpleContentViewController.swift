import UIKit

class SimpleContentViewController: UIViewController {
    private let titleText: String
    private let image: UIImage?

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

        navigationItem.title = titleText

        setupScrollView()
        setupContent()
    }

    // MARK: - Setup Scroll View and Stack

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
        contentStack.addArrangedSubview(titleLabel)

        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemBlue
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentStack.addArrangedSubview(imageView)
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

        let buttonTitles = ["Action 1", "Action 2", "Cancel"]
        for title in buttonTitles {
            let config = UIButton.Configuration.borderedProminent()

            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
            button.backgroundColor = UIColor.systemGray6
            button.layer.cornerRadius = 8
            button.configuration = config

            button.addAction(
                UIAction { [weak self] _ in
                    guard let self else { return }
                    
                    self.navigationController?.pushViewController(
                        SimpleContentViewController(titleText: title, image: UIImage(systemName: "square")),
                        animated: true
                    )
                },
                for: .touchUpInside
            )

            contentStack.addArrangedSubview(button)
        }
    }
}

#Preview {
    SimpleContentViewController(titleText: "Hello World", image: UIImage(systemName: "globe"))
}
