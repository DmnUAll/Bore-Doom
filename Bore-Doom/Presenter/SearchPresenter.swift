import UIKit

// MARK: - SearchPresenter
final class SearchPresenter {

    // MARK: - Properties and Initializers
    private weak var viewController: SearchController?
    private var networkManager = NetworkManager()
    private var currentActivity: ActivityData?

    init(viewController: SearchController? = nil) {
        self.viewController = viewController
        networkManager.delegate = self
        giveActivityData()
    }
}

// MARK: - Helpers
extension SearchPresenter {

    func giveActivityData() {
        networkManager.performRequest()
    }

    func addToFavorites() {
        guard let currentActivity = currentActivity else { return }
        for item in CoreDataManager.shared.activitiesArray where item.name == currentActivity.activity {
            viewController?.showAlert(withTitle: "Duplicate", andMessage: "This Activity is already in your list!")
            return
        }
        let activityToAdd = Activity(context: CoreDataManager.shared.context)
        activityToAdd.name = currentActivity.activity
        activityToAdd.participants = Int64(currentActivity.participants)
        activityToAdd.type = currentActivity.type
        activityToAdd.link = currentActivity.link
    }

    func giveWebURL() -> URL? {
        guard let currentActivity = currentActivity else { return nil }
        guard currentActivity.link != "" else {
            let activityName = currentActivity.activity.replacingOccurrences(of: " ", with: "%20")
            return URL(string: "https://www.google.com/search?q=\(activityName)")
        }
        return URL(string: currentActivity.link)
    }
}

// MARK: - NetworkManagerDelegate
extension SearchPresenter: NetworkManagerDelegate {

    func updateActivityData(to data: ActivityData) {
        currentActivity = data
        viewController?.updateUI(data: data)
    }
}
