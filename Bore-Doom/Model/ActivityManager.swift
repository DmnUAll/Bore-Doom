//
//  ActivityManager.swift
//  Bore-Doom
//
//  Created by Илья Валито on 01.09.2022.
//

import UIKit

protocol ActivityManagerDelegate {
    func updateUI(data: ActivityData)
}

struct ActivityManager {
    static var delegate: ActivityManagerDelegate?
    static let activityURL = "http://www.boredapi.com/api/activity"
    static var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    static func performRequest() {
        if let url = URL(string: activityURL) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!.localizedDescription)
                    return
                }
                if let safeData = data {
                    self.parseJSON(quoteData: safeData)
                }
            }
            task.resume()
        }
    }
    
    static func parseJSON(quoteData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ActivityData.self, from: quoteData)
            self.delegate?.updateUI(data: decodedData)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}
