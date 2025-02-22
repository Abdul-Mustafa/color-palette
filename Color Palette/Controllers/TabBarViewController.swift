//import UIKit
//
//extension UITabBarController {
//    func configureThirdTabItem() {
//        if let items = tabBar.items, items.count > 2 {
//            let thirdTabItem = items[2]
//            thirdTabItem.image = UIImage(named: "Vector 1")?.withRenderingMode(.alwaysOriginal)
//            thirdTabItem.selectedImage = UIImage(named: "home_icon_filled")?.withRenderingMode(.alwaysOriginal)
//            thirdTabItem.imageInsets = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
//        }
//    }
//}
//
//class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        configureThirdTabItem()
//        self.delegate = self // Set the delegate to intercept tab selection
//    }
//    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
//            if viewController is AddButtonViewController {
//                showBottomSheet()
//                return false // Prevent switching tabs
//            }
//            return true
//        }
//
//        private func showBottomSheet() {
//            print("showBottomSheet called")
//            let vc = AddButtonViewController()
//            vc.modalPresentationStyle = .pageSheet
//            
//
//            if let sheet = vc.sheetPresentationController {
//                let height = UIScreen.main.bounds.height / 2.1 // One-third of the screen
//                sheet.detents = [.custom { _ in height }]
//                sheet.prefersGrabberVisible = false // Show grabber handle
//                
//            }
//
//            present(vc, animated: true)
//        }
//    // Intercept tab selection
//
//}
//

//import UIKit
//
//extension UITabBarController {
//    func configureThirdTabItem() {
//        if let items = tabBar.items, items.count > 2 {
//            let thirdTabItem = items[2]
//            thirdTabItem.image = UIImage(named: "Vector 1")?.withRenderingMode(.alwaysOriginal)
//            thirdTabItem.selectedImage = UIImage(named: "home_icon_filled")?.withRenderingMode(.alwaysOriginal)
//            thirdTabItem.imageInsets = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
//        }
//    }
//}
//
//class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
//    private var isSecondTabHidden = false
//    private var originalTabBarItems: [UITabBarItem]?
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        configureThirdTabItem()
//        self.delegate = self
//        // Store original items for restoration
//        originalTabBarItems = tabBar.items
//    }
//    
//    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
//        guard let index = tabBarController.viewControllers?.firstIndex(of: viewController),
//              let viewControllers = tabBarController.viewControllers else {
//            return true
//        }
//        
//        if index == 4 {
//            // Hide the second tab and redistribute space
//            hideSecondTab(in: tabBarController)
//        } else {
//            // Restore original layout if coming from hidden state
//            if isSecondTabHidden {
//                restoreOriginalLayout(in: tabBarController)
//            }
//            
//            if viewController is AddButtonViewController {
//                showBottomSheet()
//                return false
//            }
//        }
//        
//        return true
//    }
//    
//    private func hideSecondTab(in tabBarController: UITabBarController) {
//        guard let viewControllers = tabBarController.viewControllers,
//              viewControllers.count > 2 else { return }
//        
//        // Create new array without the third item (index 2)
//        var newViewControllers = viewControllers
//        newViewControllers.remove(at: 2)
//        
//        // Update the tab bar
//        tabBarController.setViewControllers(newViewControllers, animated: true)
//        
//        // Redistribute items equally
//        if let items = tabBar.items {
//            let totalWidth = tabBar.frame.width
//            let itemWidth = totalWidth / CGFloat(items.count)
//            
//            items.enumerated().forEach { index, item in
//                // Calculate new position
//                let newX = itemWidth * CGFloat(index)
//                item.imageInsets = UIEdgeInsets(top: 12, left: newX, bottom: 12, right: -newX)
//            }
//        }
//        
//        isSecondTabHidden = true
//    }
//    
//    private func restoreOriginalLayout(in tabBarController: UITabBarController) {
//        guard let originalItems = originalTabBarItems else { return }
//        
//        // Restore original view controllers
//        let originalViewControllers = originalItems.map { _ in UIViewController() }
//        tabBarController.setViewControllers(originalViewControllers, animated: true)
//        
//        // Reset item positions
//        originalItems.forEach { item in
//            item.imageInsets = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
//        }
//        
//        // Reconfigure the third tab
//        configureThirdTabItem()
//        
//        isSecondTabHidden = false
//    }
//    
//    private func showBottomSheet() {
//        print("showBottomSheet called")
//        let vc = AddButtonViewController()
//        vc.modalPresentationStyle = .pageSheet
//        
//        if let sheet = vc.sheetPresentationController {
//            let height = UIScreen.main.bounds.height / 2.1
//            sheet.detents = [.custom { _ in height }]
//            sheet.prefersGrabberVisible = false
//        }
//        
//        present(vc, animated: true)
//    }
//}
import UIKit

extension UITabBarController {
    func configureThirdTabItem() {
        if let items = tabBar.items, items.count > 2 {
            let thirdTabItem = items[2]
            thirdTabItem.image = UIImage(named: "Vector 1")?.withRenderingMode(.alwaysOriginal)
            thirdTabItem.selectedImage = UIImage(named: "home_icon_filled")?.withRenderingMode(.alwaysOriginal)
            thirdTabItem.imageInsets = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
        }
    }
}

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
    private var isSecondTabHidden = false
    private var originalViewControllers: [UIViewController]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureThirdTabItem()
        self.delegate = self
        // Store original view controllers for restoration
        originalViewControllers = viewControllers
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let index = tabBarController.viewControllers?.firstIndex(of: viewController) else {
            return true
        }
        
        if index == 4 {
            // Hide the second tab and redistribute space
            hideSecondTab()
        } else {
            // Restore original layout if coming from hidden state
            if isSecondTabHidden {
                restoreOriginalLayout()
            }
            
            if viewController is AddButtonViewController {
                showBottomSheet()
                return false
            }
        }
        
        return true
    }
    
    private func hideSecondTab() {
        guard let viewControllers = self.viewControllers,
              viewControllers.count > 2 else { return }
        
        // Create new array without the third item (index 2)
        var newViewControllers = viewControllers
        newViewControllers.remove(at: 2)
        
        // Update the tab bar
        self.setViewControllers(newViewControllers, animated: false)
        
        // Redistribute items equally
        if let items = tabBar.items {
            let totalWidth = tabBar.frame.width
            let itemWidth = totalWidth / CGFloat(items.count)
            
            items.enumerated().forEach { index, item in
                // Calculate new position
                let newX = itemWidth * CGFloat(index)
                item.imageInsets = UIEdgeInsets(top: 12, left: newX, bottom: 12, right: -newX)
            }
        }
        
        isSecondTabHidden = true
    }
    
    private func restoreOriginalLayout() {
        guard let originalVCs = originalViewControllers else { return }
        
        // Restore original view controllers
        self.setViewControllers(originalVCs, animated: false)
        
        // Reset item positions
        if let items = tabBar.items {
            items.forEach { item in
                item.imageInsets = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
            }
        }
        
        // Reconfigure the third tab
        configureThirdTabItem()
        
        isSecondTabHidden = false
    }
    
    private func showBottomSheet() {
        print("showBottomSheet called")
        let vc = AddButtonViewController()
        vc.modalPresentationStyle = .pageSheet
        
        if let sheet = vc.sheetPresentationController {
            let height = UIScreen.main.bounds.height / 2.1
            sheet.detents = [.custom { _ in height }]
            sheet.prefersGrabberVisible = false
        }
        
        present(vc, animated: true)
    }
}
