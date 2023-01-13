import UIKit
import CoreData

// MARK: - CoreDataManager
struct CoreDataManager {

    static var shared = CoreDataManager()
    // swiftlint:disable force_cast
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    // swiftlint:enable force_cast
    var activitiesArray: [Activity] {
        let request: NSFetchRequest<Activity> = Activity.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        do {
            let result = try context.fetch(request)
            return result
        } catch {
            print(error)
        }
        return []
    }
}
