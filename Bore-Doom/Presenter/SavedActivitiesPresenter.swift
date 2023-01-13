import UIKit

// MARK: - SavedActivitiesPresenter
final class SavedActivitiesPresenter {

    // MARK: - Properties and Initializers
    private weak var viewController: SavedActivitiesController?

    init(viewController: SavedActivitiesController? = nil) {
        self.viewController = viewController
    }
}

// MARK: - Helpers
extension SavedActivitiesPresenter {

    func configureCell(forTableView tableView: UITableView, atIndexPath indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "savedActivityCell") as? SavedActivityCell else {
            return UITableViewCell()
        }
        cell.activityNameLabel.text = CoreDataManager.shared.activitiesArray[indexPath.row].name
        cell.activityTypeLabel.text = "Type: \((CoreDataManager.shared.activitiesArray[indexPath.row].type) ?? "None")"
        let participants = CoreDataManager.shared.activitiesArray[indexPath.row].participants
        cell.activityParticipantsLabel.text = "Participants: \(participants)"
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        return cell
    }

    func deleteActivity(atIndexPath indexPath: IndexPath) {
        let activity = CoreDataManager.shared.activitiesArray[indexPath.row]
        CoreDataManager.shared.context.delete(activity)
        do {
            try CoreDataManager.shared.context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }

    func giveWebURL(forActivityAt indexPath: IndexPath) -> URL? {
        let selectedActivity = CoreDataManager.shared.activitiesArray[indexPath.row]
        guard selectedActivity.link != "" else {
            guard let name = selectedActivity.name else { return nil }
            return URL(string: "https://www.google.com/search?q=\(name.replacingOccurrences(of: " ", with: "%20"))")
        }
        guard let link = selectedActivity.link else { return nil}
        return URL(string: link)
    }
}
