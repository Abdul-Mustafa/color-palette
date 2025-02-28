


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
            if isSecondTabHidden && index != 3  {
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
            if #available(iOS 16.0, *) {
                sheet.detents = [.custom { _ in height }]
            } else {
                // Fallback on earlier versions
            }
            sheet.prefersGrabberVisible = false
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
        }
        
        
        present(vc, animated: true)
    }
    
}

