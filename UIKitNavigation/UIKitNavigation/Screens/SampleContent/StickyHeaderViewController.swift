import UIKit

class StickyHeaderViewController: UIViewController, UIScrollViewDelegate {

    private let image: UIImage
    private let customTitle: String

    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private let headerImageView = UIImageView()
    private let titleLabel = UILabel()

    var contentViewTopAnchor: NSLayoutConstraint!
    var headerHeightConstraint: NSLayoutConstraint!
    let originalHeaderHeight: CGFloat = 220

    init(image: UIImage, title: String) {
        self.image = image
        self.customTitle = title
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        setupNavigationBar()
        setupScrollView()
        setupStickyImage()
        setupContent()
    }

    func setupNavigationBar() {
        navigationItem.title = customTitle
        navigationItem.largeTitleDisplayMode = .never

        let scrollEdge = UINavigationBarAppearance()
        scrollEdge.configureWithTransparentBackground()
        scrollEdge.titleTextAttributes = [.foregroundColor: UIColor.clear]
        navigationItem.scrollEdgeAppearance = scrollEdge

        let standard = UINavigationBarAppearance()
        standard.configureWithDefaultBackground()
        standard.titleTextAttributes = [.foregroundColor: UIColor.purple]
        navigationItem.standardAppearance = standard

        let compactEdgeTop = UINavigationBarAppearance()
        compactEdgeTop.configureWithOpaqueBackground()
        compactEdgeTop.backgroundColor = .yellow
        navigationController?.navigationBar.compactAppearance = compactEdgeTop

        let compactEdge = UINavigationBarAppearance()
        compactEdge.configureWithOpaqueBackground()
        compactEdge.backgroundColor = .red
        navigationItem.compactAppearance = compactEdge
    }

    private func setupScrollView() {
        scrollView.delegate = self
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor), // under nav bar
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false

        contentViewTopAnchor = contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 0)

        NSLayoutConstraint.activate([
            contentViewTopAnchor,
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor) // important for vertical scrolling
        ])
    }

    private func setupStickyImage() {
        headerImageView.image = image
        headerImageView.contentMode = .scaleAspectFill
        headerImageView.clipsToBounds = true
        headerImageView.translatesAutoresizingMaskIntoConstraints = false
        headerImageView.backgroundColor = .red
        contentView.addSubview(headerImageView)

        headerHeightConstraint = headerImageView.heightAnchor.constraint(equalToConstant: originalHeaderHeight)

        NSLayoutConstraint.activate([
            headerImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            headerImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            headerHeightConstraint,
        ])
    }

    private func setupContent() {
        // Title Label inside scrollView
        titleLabel.text = customTitle
        titleLabel.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: 8), // below sticky image
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])

        // Dummy content
        let bodyLabel = UILabel()
        bodyLabel.numberOfLines = 0
        bodyLabel.font = UIFont.systemFont(ofSize: 16)
        bodyLabel.text = String(repeating: "This is scrollable content.\n", count: 50)
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(bodyLabel)

        NSLayoutConstraint.activate([
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            bodyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            bodyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            bodyLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40)
        ])
    }

    // MARK: - ScrollViewDelegate

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetheight = scrollView.contentOffset.y
        //if the value is negative
        if contentOffsetheight < 0 {
            //change the anchors
            contentViewTopAnchor.constant   = contentOffsetheight
            headerHeightConstraint.constant = originalHeaderHeight + (-contentOffsetheight)
        }
    }
}

#Preview {
    UINavigationController(
        rootViewController: StickyHeaderViewController(image: UIImage(resource: .tedLasso), title: "Ted Lasso")
    )
}
