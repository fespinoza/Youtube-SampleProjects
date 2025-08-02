import UIKit

class TitleIconView: UIView {

    private let imageView = UIImageView()
    private let titleLabel = UILabel()

    init(title: String, systemImageName: String) {
        super.init(frame: .zero)
        setupView(title: title, systemImageName: systemImageName)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = frame.height / 2
    }

    private func setupView(title: String, systemImageName: String) {
        // Configure Image View
        imageView.image = UIImage(systemName: systemImageName)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .label

        // Configure Label
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        titleLabel.textColor = .label

        // Create Stack View
        let stackView = UIStackView(arrangedSubviews: [imageView, titleLabel])
        stackView.axis = .horizontal
        stackView.spacing = 6
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stackView)

        // Pin stackView to the edges of the view
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor)
        ])
        
        layoutMargins = .init(top: 4, left: 16, bottom: 4, right: 16)
        
        backgroundColor = .red.withAlphaComponent(0.4)
    }
}

#Preview {
    TitleIconView(title: "Inbox", systemImageName: "tray.full")
}
