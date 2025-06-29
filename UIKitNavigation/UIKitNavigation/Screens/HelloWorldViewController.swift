import UIKit

class HelloWorldViewController: UIViewController {

    private let helloLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello, World!"
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.textAlignment = .center
        return label
    }()

    private let worldImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(systemName: "globe")
        imageView.image = image
        imageView.tintColor = .systemBlue
        imageView.contentMode = .scaleAspectFit
        imageView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return imageView
    }()

    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [worldImageView, helloLabel])
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLayout()
    }

    private func setupLayout() {
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            worldImageView.heightAnchor.constraint(equalToConstant: 100),
            worldImageView.widthAnchor.constraint(equalToConstant: 100),
        ])
    }
}
