//
//  SavedActivitiesViewController.swift
//  Bore-Doom
//
//  Created by Илья Валито on 01.09.2022.
//

import UIKit
import CoreData

class SavedActivitiesViewController: UIViewController {
    
    let context = ActivityManager.context
    var activityArray: [Activity] {
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
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tabBar: UITabBarItem!
    
    override func viewWillAppear(_ animated: Bool) {
        loadActivities()
    }
    
    func loadActivities() {
        tableView.reloadData()
        tabBar.badgeValue = "\(activityArray.count)"
    }
    
    func getBadge() -> String {
        return "\(activityArray.count)"
    }
}

extension SavedActivitiesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activityArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "activityCell") as! ActivityCell
        
        cell.activityNameLabel.text = activityArray[indexPath.row].name
        cell.activityTypeLabel.text = "Type: \((activityArray[indexPath.row].type) ?? "None")"
        cell.participantsLabel.text = "Participants: \(activityArray[indexPath.row].participants)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let activity = activityArray[indexPath.row]
        if editingStyle == .delete {
            context.delete(activity)
        }
        do {
            try context.save()
            loadActivities()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}

extension SavedActivitiesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let url = URL(string: activityArray[indexPath.row].link!) {
            UIApplication.shared.open(url)
            return
        }
        if let url = URL(string:"https://www.google.com/search?q=\(activityArray[indexPath.row].name!.replacingOccurrences(of: " ", with: "%20"))") {
            UIApplication.shared.open(url)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
