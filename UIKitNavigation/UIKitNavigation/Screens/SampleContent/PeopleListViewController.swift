import UIKit

// ChatGPT generated code

class PeopleListViewController: UIViewController {
    
    // Example data sets
    private let friends: [(name: String, phone: String)] = [
        ("Alice Johnson", "555-1234"),
        ("Bob Smith", "555-5678"),
        ("Carol White", "555-9012")
    ]
    
    private let family: [(name: String, phone: String)] = [
        ("David Green", "555-3456"),
        ("Eva Blue", "555-7890"),
        ("Frank Orange", "555-4321"),
        ("Grace Pink", "555-8765"),
        ("Henry Brown", "555-6543")
    ]

    private lazy var firstListView = PeopleTableView(people: friends)
    private lazy var secondListView = PeopleTableView(people: family)

    private lazy var segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Friends", "Family"])
        control.selectedSegmentIndex = 0
        control.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        return control
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNavigationBar()
        setupListViews()
    }

    private func setupNavigationBar() {
        navigationItem.titleView = segmentedControl
    }

    private func setupListViews() {
        [firstListView, secondListView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)

            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                $0.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                $0.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                $0.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }

        // Show first by default
        secondListView.isHidden = true
        
        firstListView.backgroundColor = .red.withAlphaComponent(0.2)
        secondListView.backgroundColor = .red.withAlphaComponent(0.2)
    }

    @objc private func segmentChanged(_ sender: UISegmentedControl) {
        let showFirst = sender.selectedSegmentIndex == 0
        firstListView.isHidden = !showFirst
        secondListView.isHidden = showFirst
    }
}

#Preview {
    UINavigationController(rootViewController: PeopleListViewController())
}
