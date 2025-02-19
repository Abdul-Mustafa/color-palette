

import UIKit

class TabBarViewController: UITabBarController {
    
    private let roundButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 30
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        
        // Configure the plus icon
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .black, scale: .large)
        let plusImage = UIImage(systemName: "plus", withConfiguration: config)?.withRenderingMode(.alwaysTemplate)
        button.setImage(plusImage, for: .normal)
        button.tintColor = .white // Set the icon color
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add the floating button to the main view
        self.view.addSubview(roundButton)
        
        // Attach an action
        roundButton.addTarget(self, action: #selector(roundButtonTapped), for: .touchUpInside)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Ensure the constraints are updated after layout
        if let tabBarSuperview = self.tabBar.superview {
            NSLayoutConstraint.deactivate(roundButton.constraints) // Remove any old constraints
            
            NSLayoutConstraint.activate([
                roundButton.centerXAnchor.constraint(equalTo: tabBarSuperview.centerXAnchor), // Ensure same ancestor
                roundButton.bottomAnchor.constraint(equalTo: self.tabBar.topAnchor, constant: 30), // Above tab bar
                roundButton.widthAnchor.constraint(equalToConstant: 60),
                roundButton.heightAnchor.constraint(equalToConstant: 60)
            ])
        }
    }
    
    @objc func roundButtonTapped() {
        print("Floating button tapped!")
    }
}
