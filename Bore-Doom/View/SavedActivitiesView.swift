import UIKit

// MARK: - SavedActivitiesView
final class SavedActivitiesView: UIView {

    // MARK: - Properties and Initializers
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.toAutolayout()
        tableView.register(SavedActivityCell.self, forCellReuseIdentifier: "savedActivityCell")
        tableView.backgroundColor = .bdGreenLight
        tableView.separatorColor = .bdGreenDark
        return tableView
    }()

    private lazy var linkTextView: UITextView = {
        let attributedString = NSMutableAttributedString(string: "This app was made, using boredapi.com API")
        attributedString.addAttribute(.link, value: "http://www.boredapi.com", range: NSRange(location: 25, length: 12))
        let textView = UITextView()
        textView.toAutolayout()
        textView.backgroundColor = .clear
        textView.attributedText = attributedString
        textView.textAlignment = .center
        textView.font = UIFont(name: "Kailasa Bold", size: 12)
        textView.textColor = .bdYellow
        textView.isEditable = false
        textView.dataDetectorTypes = .link
        return textView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        toAutolayout()
        addSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helpers
extension SavedActivitiesView {

    private func addSubviews() {
        addSubview(tableView)
        addSubview(linkTextView)
    }

    private func setupConstraints() {
        let constraints = [
            linkTextView.heightAnchor.constraint(equalToConstant: 40),
            linkTextView.leadingAnchor.constraint(equalTo: leadingAnchor),
            linkTextView.trailingAnchor.constraint(equalTo: trailingAnchor),
            linkTextView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: linkTextView.topAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
