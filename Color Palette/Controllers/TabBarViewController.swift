

import UIKit


class MyTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        // Assuming the menu should appear when the 3rd tab (index 2) is selected
        if selectedIndex == 2 {
            showDropUpMenu()
        }
    }

    func showDropUpMenu() {
        let menu = UIMenu(title: "Choose Option", children: [
            UIAction(title: "Option 1", image: UIImage(systemName: "star"), handler: { _ in
                print("Option 1 selected")
            }),
            UIAction(title: "Option 2", image: UIImage(systemName: "heart"), handler: { _ in
                print("Option 2 selected")
            }),
            UIAction(title: "Cancel", attributes: .destructive, handler: { _ in
                print("Cancelled")
            })
        ])

        // Create a UIButton and set the menu manually
        let menuButton = UIButton(type: .system)
        menuButton.menu = menu
        menuButton.showsMenuAsPrimaryAction = true  // This ensures the menu opens on tap

        // Trigger menu programmatically
        menuButton.sendActions(for: .touchUpInside)
    }
}

