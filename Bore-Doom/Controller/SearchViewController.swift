//
//  ViewController.swift
//  Bore-Doom
//
//  Created by Илья Валито on 01.09.2022.
//

import UIKit

class SearchViewController: UIViewController {
    
    private var activity: ActivityData?
    private let context = ActivityManager.context
    private let vc = SavedActivitiesViewController()
    
    @IBOutlet weak var activityNameLabel: UILabel!
    @IBOutlet weak var activityTypeLabel: UILabel!
    @IBOutlet weak var participantsLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ActivityManager.delegate = self
        ActivityManager.performRequest()
        toggleLabelsVisibility()
        updateBadge()
    }
    
    func updateBadge() {
        if let tabItems = tabBarController?.tabBar.items {
            let tabItem = tabItems[1]
            tabItem.badgeValue = "\(vc.getBadge())"
        }
    }
    
    func showAlert(withTitle title: String, andMessage message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let gotItAction = UIAlertAction(title: "Got it!", style: .default)
        alertController.addAction(gotItAction)
        present(alertController, animated: true)
    }
    
    func toggleLabelsVisibility() {
        activityNameLabel.isHidden.toggle()
        activityTypeLabel.isHidden.toggle()
        participantsLabel.isHidden.toggle()
    }
    
    @IBAction func infoTapped(_ sender: UIBarButtonItem) {
        showAlert(withTitle: "About Author", andMessage: "It was me! :)")
    }
    
    @IBAction func refreshTapped(_ sender: UIBarButtonItem) {
        toggleLabelsVisibility()
        activityIndicator.startAnimating()
        ActivityManager.performRequest()
    }
    
    
    @IBAction func addTapped(_ sender: UIBarButtonItem) {
        if let activity = activity {
            for item in vc.activityArray {
                if item.name == activity.activity {
                    showAlert(withTitle: "Duplicate", andMessage: "This Activity is already in your list!")
                    return
                }
            }
            let activityToAdd = Activity(context: context)
            activityToAdd.name = activity.activity
            activityToAdd.participants = Int64(activity.participants)
            activityToAdd.type = activity.type
            activityToAdd.link = activity.link
        }
        updateBadge()
    }
    
    @IBAction func webTapped(_ sender: UIBarButtonItem) {
        if let activity = activity {
            if let url = URL(string: activity.link!) {
                UIApplication.shared.open(url)
                return
            }
            if let url = URL(string:"https://www.google.com/search?q=\(activity.activity.replacingOccurrences(of: " ", with: "%20"))") {
                UIApplication.shared.open(url)
            }
        }
    }
}

extension SearchViewController: ActivityManagerDelegate {
    func updateUI(data: ActivityData) {
        activity = data
        DispatchQueue.main.async {
            self.activityNameLabel.text = data.activity
            self.activityTypeLabel.text = "Type: \(data.type)"
            self.participantsLabel.text = "Participants: \(data.participants)"
            self.activityIndicator.stopAnimating()
            self.toggleLabelsVisibility()
        }
    }
}

