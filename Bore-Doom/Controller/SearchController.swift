import UIKit

// MARK: - SearchController
final class SearchController: UIViewController {

    // MARK: - Properties and Initializers
    private var presenter: SearchPresenter?
    lazy var searchView: SearchView = {
        let view = SearchView()
        return view
    }()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        view.backgroundColor = .bdGreenDark
        view.addSubview(searchView)
        setupConstraints()
        (navigationController as? NavigationController)?.buttonsDelegate = self
        presenter = SearchPresenter(viewController: self)
        updateBadge()
    }
}

// MARK: - Helpers
extension SearchController {

    private func setupConstraints() {
        let constraints = [
            searchView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func changeUIVisibility() {
        searchView.activityNameLabel.isHidden.toggle()
        searchView.activityTypeLabel.isHidden.toggle()
        searchView.activityParticipantsLabel.isHidden.toggle()
        if searchView.activityIndicator.isAnimating {
            searchView.activityIndicator.stopAnimating()
        } else {
            searchView.activityIndicator.startAnimating()
        }
    }

    private func updateBadge() {
        if CoreDataManager.shared.activitiesArray.count <= 0 {
            return
        }
        guard let tab = tabBarController?.tabBar.items?[1] else { return }
        tab.badgeValue = "\(CoreDataManager.shared.activitiesArray.count)"
    }

    func showAlert(withTitle title: String, andMessage message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let gotItAction = UIAlertAction(title: "Got it!", style: .default)
        alertController.addAction(gotItAction)
        present(alertController, animated: true)
    }

    func updateUI(data: ActivityData) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.searchView.activityNameLabel.text = data.activity
            self.searchView.activityTypeLabel.text = "Type: \(data.type)"
            self.searchView.activityParticipantsLabel.text = "Participants: \(data.participants)"
            self.changeUIVisibility()
        }
    }
}

// MARK: - NavigationButtonsDelegate
extension SearchController: NavigationButtonsDelegate {

    func infoTapped() {
        showAlert(withTitle: "About Author", andMessage: "It was me! :)")
    }

    func refreshTapped() {
        changeUIVisibility()
        presenter?.giveActivityData()
    }

    func addTapped() {
        presenter?.addToFavorites()
        updateBadge()
    }

    func webTapped() {
        guard let url = presenter?.giveWebURL() else { return }
        UIApplication.shared.open(url)
    }
}
