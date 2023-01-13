import  UIKit

// MARK: - SavedActivityCell
final class SavedActivityCell: UITableViewCell {

    // MARK: - Properties and Initializers
    lazy var activityNameLabel: UILabel = {
        makeLabel(withText: "Activity Name", font: "Kailasa Bold", size: 20, andAlignment: .natural)
    }()

    lazy var activityTypeLabel: UILabel = {
        makeLabel(withText: "Activity Type", font: "Kailasa Regular", size: 16, andAlignment: .left)
    }()

    lazy var activityParticipantsLabel: UILabel = {
        makeLabel(withText: "Participants", font: "Kailasa Regular", size: 16, andAlignment: .right)
    }()

    private lazy var activityInfoStackView: UIStackView = {
        makeStackView(withAxis: .horizontal)
    }()

    private lazy var mainStackView: UIStackView = {
        let stackView = makeStackView(withAxis: NSLayoutConstraint.Axis.vertical, andDistribution: .fillEqually)
        stackView.toAutolayout()
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .bdSalad
        addSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helpers
extension SavedActivityCell {

    private func addSubviews() {
        activityInfoStackView.addArrangedSubview(activityTypeLabel)
        activityInfoStackView.addArrangedSubview(activityParticipantsLabel)
        mainStackView.addArrangedSubview(activityNameLabel)
        mainStackView.addArrangedSubview(activityInfoStackView)
        addSubview(mainStackView)
    }

    private func setupConstraints() {
        let constraints = [
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func makeLabel(withText text: String, font: String,
                           size: CGFloat,
                           andAlignment alignment: NSTextAlignment = .center
    ) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .bdBrown
        label.font = UIFont(name: font, size: size)
        label.textAlignment = alignment
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
        stackView.spacing = 0
        return stackView
    }
}
