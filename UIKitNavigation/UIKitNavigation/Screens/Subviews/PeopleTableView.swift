import UIKit

// ChatGPT code

class PersonCell: UITableViewCell {

    private let initialsLabel = UILabel()
    private let nameLabel = UILabel()
    private let phoneLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    private func setupViews() {
        initialsLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false

        initialsLabel.backgroundColor = .systemBlue
        initialsLabel.textColor = .white
        initialsLabel.textAlignment = .center
        initialsLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        initialsLabel.clipsToBounds = true
        initialsLabel.layer.cornerRadius = 20

        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        phoneLabel.font = UIFont.systemFont(ofSize: 14)
        phoneLabel.textColor = .secondaryLabel

        let textStack = UIStackView(arrangedSubviews: [nameLabel, phoneLabel])
        textStack.axis = .vertical
        textStack.spacing = 2

        let mainStack = UIStackView(arrangedSubviews: [initialsLabel, textStack])
        mainStack.axis = .horizontal
        mainStack.spacing = 12
        mainStack.alignment = .center
        mainStack.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(mainStack)

        NSLayoutConstraint.activate([
            initialsLabel.widthAnchor.constraint(equalToConstant: 40),
            initialsLabel.heightAnchor.constraint(equalToConstant: 40),

            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }

    func configure(name: String, phone: String) {
        nameLabel.text = name
        phoneLabel.text = phone
        initialsLabel.text = initials(from: name)
    }

    private func initials(from name: String) -> String {
        let parts = name.components(separatedBy: " ")
        let initials = parts.prefix(2).compactMap { $0.first }.map { String($0) }
        return initials.joined().uppercased()
    }
}

import UIKit

class PeopleTableView: UIView, UITableViewDataSource {
    
    private let tableView = UITableView()
    private var people: [(name: String, phone: String)]
    
    // MARK: - Init
    
    init(people: [(name: String, phone: String)]) {
        self.people = people
        super.init(frame: .zero)
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        self.people = []
        super.init(coder: coder)
        setupTableView()
    }
    
    private func setupTableView() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        tableView.dataSource = self
        tableView.register(PersonCell.self, forCellReuseIdentifier: "PersonCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell", for: indexPath) as? PersonCell else {
            return UITableViewCell()
        }
        
        let person = people[indexPath.row]
        cell.configure(name: person.name, phone: person.phone)
        return cell
    }
}


#Preview {
    PeopleTableView(people: [
        ("David Green", "555-3456"),
        ("Eva Blue", "555-7890"),
        ("Frank Orange", "555-4321"),
        ("Grace Pink", "555-8765"),
        ("Henry Brown", "555-6543")
    ])
}
