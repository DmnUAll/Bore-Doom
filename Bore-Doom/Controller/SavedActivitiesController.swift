import UIKit

// MARK: - SavedActivitiesController
final class SavedActivitiesController: UIViewController {

    // MARK: - Properties and Initializers
    private var presenter: SavedActivitiesPresenter?
    lazy var savedActivitiesView: SavedActivitiesView = {
        let view = SavedActivitiesView()
        return view
    }()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        view.backgroundColor = .bdGreenDark
        view.addSubview(savedActivitiesView)
        setupConstraints()
        presenter = SavedActivitiesPresenter(viewController: self)
        savedActivitiesView.tableView.dataSource = self
        savedActivitiesView.tableView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }
}

// MARK: - Helpers
extension SavedActivitiesController {

    private func setupConstraints() {
        let constraints = [
            savedActivitiesView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            savedActivitiesView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            savedActivitiesView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            savedActivitiesView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func updateUI() {
        savedActivitiesView.tableView.reloadData()
        guard let tab = tabBarController?.tabBar.items?[1] else { return }
        if CoreDataManager.shared.activitiesArray.count <= 0 {
            tab.badgeValue = nil
            return
        }
        tab.badgeValue = "\(CoreDataManager.shared.activitiesArray.count)"
    }
}

// MARK: - UITableViewDataSource
extension SavedActivitiesController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataManager.shared.activitiesArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = presenter?.configureCell(forTableView: tableView,
                                                  atIndexPath: indexPath) else { return UITableViewCell() }
        return cell
    }

    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath
    ) {
        presenter?.deleteActivity(atIndexPath: indexPath)
        updateUI()
    }
}

// MARK: - UITableViewDelegate
extension SavedActivitiesController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = presenter?.giveWebURL(forActivityAt: indexPath) else { return }
        UIApplication.shared.open(url)
    }
}
