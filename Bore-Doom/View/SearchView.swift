import UIKit

// MARK: - SearchView
final class SearchView: UIView {

    // MARK: - Properties and Initializers
    lazy var activityNameLabel: UILabel = {
        makeLabel(withText: "Activity Name", font: "Kailasa Bold", size: 24, numberOfLines: 0)
    }()

    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .bdYellow
        return activityIndicator
    }()

    lazy var activityTypeLabel: UILabel = {
        makeLabel(withText: "Activity Type", font: "Kailasa Regular", size: 22)
    }()

    lazy var activityParticipantsLabel: UILabel = {
        makeLabel(withText: "Participants", font: "Kailasa Regular", size: 22)
    }()

    private lazy var activityInfoStackView: UIStackView = {
        makeStackView(withAxis: .horizontal, andDistribution: .fillEqually)
    }()

    private lazy var mainStackView: UIStackView = {
        let stackView = makeStackView(withAxis: .vertical, alignment: .center)
        stackView.toAutolayout()
        return stackView
    }()

    private lazy var linkTextView: UITextView = {
        let attributedString = NSMutableAttributedString(string: "This app was made, using boredapi.com API")
        attributedString.addAttribute(.link, value: "http://www.boredapi.com", range: NSRange(location: 25, length: 12))
        let textView = UITextView()
        textView.toAutolayout()
        textView.backgroundColor = .bdGreenDark
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
        backgroundColor = .bdGreenLight
        toAutolayout()
        addSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helpers
private extension SearchView {

    private func addSubviews() {
        activityInfoStackView.addArrangedSubview(activityTypeLabel)
        activityInfoStackView.addArrangedSubview(activityParticipantsLabel)
        mainStackView.addArrangedSubview(activityNameLabel)
        mainStackView.addArrangedSubview(activityIndicator)
        mainStackView.addArrangedSubview(activityInfoStackView)
        addSubview(mainStackView)
        addSubview(linkTextView)
    }

    private func setupConstraints() {
        let constraints = [
            linkTextView.heightAnchor.constraint(equalToConstant: 40),
            linkTextView.leadingAnchor.constraint(equalTo: leadingAnchor),
            linkTextView.trailingAnchor.constraint(equalTo: trailingAnchor),
            linkTextView.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
            mainStackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func makeLabel(withText text: String, font: String, size: CGFloat, numberOfLines: Int = 1) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont(name: font, size: size)
        label.textColor = .bdBrown
        label.textAlignment = .center
        label.numberOfLines = numberOfLines
        label.isHidden = true
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }

    private func makeStackView(withAxis axis: NSLayoutConstraint.Axis,
                               alignment: UIStackView.Alignment = .fill,
                               andDistribution distribution: UIStackView.Distribution = .fill
    ) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = axis
        stackView.alignment = alignment
        stackView.distribution = distribution
        stackView.spacing = 18
        return stackView
    }
}
