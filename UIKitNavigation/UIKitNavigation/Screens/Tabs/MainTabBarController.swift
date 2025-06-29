import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Create view controllers
        let firstVC = SimpleContentViewController(titleText: "First", image: UIImage(systemName: "globe"))
        firstVC.view.backgroundColor = .systemRed
        firstVC.tabBarItem = UITabBarItem(title: "First", image: UIImage(systemName: "1.circle"), tag: 0)

        let secondVC = SimpleContentViewController(titleText: "Second", image: nil)
        secondVC.view.backgroundColor = .systemGreen
        secondVC.tabBarItem = UITabBarItem(title: "Second", image: UIImage(systemName: "2.circle"), tag: 1)

        let thirdVC = SimpleContentViewController(titleText: "Third", image: UIImage(systemName: "person"))
        thirdVC.view.backgroundColor = .systemYellow
        thirdVC.tabBarItem = UITabBarItem(title: "Third", image: UIImage(systemName: "3.circle"), tag: 2)

        // Assign to tab bar
        viewControllers = [
            UINavigationController(rootViewController: firstVC),
            UINavigationController(rootViewController: secondVC),
            UINavigationController(rootViewController: thirdVC),
        ]
    }
}
