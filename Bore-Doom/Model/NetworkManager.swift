import UIKit

// MARK: - NetworkManagerDelegate protocol
protocol NetworkManagerDelegate: AnyObject {
    func updateActivityData(to data: ActivityData)
}

// MARK: - NetworkManager
struct NetworkManager {
    var delegate: NetworkManagerDelegate?
    let activityURL = "http://www.boredapi.com/api/activity"

    func performRequest() {
        if let url = URL(string: activityURL) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, _, error in
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

    func parseJSON(quoteData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ActivityData.self, from: quoteData)
            self.delegate?.updateActivityData(to: decodedData)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}
