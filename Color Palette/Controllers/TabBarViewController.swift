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
    override func viewDidLoad() {
        super.viewDidLoad()
        configureThirdTabItem()
        self.delegate = self // Set the delegate to intercept tab selection
    }
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
            if viewController is AddButtonViewController {
                showBottomSheet()
                return false // Prevent switching tabs
            }
            return true
        }

        private func showBottomSheet() {
            print("showBottomSheet called")
            let vc = AddButtonViewController()
            vc.modalPresentationStyle = .pageSheet
            

            if let sheet = vc.sheetPresentationController {
                let height = UIScreen.main.bounds.height / 2.1 // One-third of the screen
                sheet.detents = [.custom { _ in height }]
                sheet.prefersGrabberVisible = false // Show grabber handle
                
            }

            present(vc, animated: true)
        }
    // Intercept tab selection

}

