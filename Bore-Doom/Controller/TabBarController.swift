import UIKit

// MARK: - TabBarController
final class TabBarController: UITabBarController {

    // MARK: - Properties and Initializers
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBarController()
    }
}

// MARK: - Helpers
extension TabBarController {

    private func configureTabBarController() {
        //        tabBar.backgroundImage = UIImage()
        tabBar.backgroundColor = .bdGreenDark
        tabBar.tintColor = .bdYellow
        tabBar.barTintColor = .bdYellow
        self.viewControllers = [
            configureTab(withRootController: SearchController(),
                         title: "Search Activity",
                         andImage: UIImage(systemName: "magnifyingglass")),
            configureTab(withViewController: SavedActivitiesController(),
                         title: "Saved Activities",
                         andImage: UIImage(systemName: "doc.plaintext"))
        ]
    }

    private func configureTab(withViewController viewController: UIViewController,
                              title: String,
                              andImage image: UIImage?
    ) -> UIViewController {
        let tab = viewController
        let tabBarItem = UITabBarItem(title: title, image: image, selectedImage: image)
        tab.tabBarItem = tabBarItem
        return tab
    }

    private func configureTab(withRootController rootVC: UIViewController,
                              title: String,
                              andImage image: UIImage?
    ) -> NavigationController {
        let tab = NavigationController(rootViewController: rootVC)
        let tabBarItem = UITabBarItem(title: title, image: image, selectedImage: image)
        tab.tabBarItem = tabBarItem
        return tab
    }
}
