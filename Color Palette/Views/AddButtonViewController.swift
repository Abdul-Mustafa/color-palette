import UIKit

class AddButtonViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        // Title Label
        let titleLabel = UILabel()
        titleLabel.text = "Color Collect From"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textColor = UIColor(hexString: "F24674")
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Separator Line
        let separatorLine = UIView()
        separatorLine.backgroundColor = .lightGray
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        
        // Buttons
        let button1 = createButton(title: "Camera", iconName: "Vector (2)", color: UIColor(hexString: "909392"), isSystemIcon: false)
        let button2 = createButton(title: "Gallery", iconName: "Group 2228", color: UIColor(hexString: "F24674"), isSystemIcon: false)
        let button3 = createButton(title: "Pinterest", iconName: "Vector (3)", color: UIColor(hexString: "FF9BAD"), isSystemIcon: false)
        
        // StackView for buttons
        let stackView = UIStackView(arrangedSubviews: [button1, button2, button3])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add subviews
        view.addSubview(titleLabel)
        view.addSubview(separatorLine)
        view.addSubview(stackView)
        
        // Dynamic button size
        let buttonWidth = view.bounds.width * 0.8
        let buttonHeight = view.bounds.height * 0.1
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            separatorLine.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            separatorLine.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            separatorLine.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            separatorLine.heightAnchor.constraint(equalToConstant: 1),
            
            stackView.topAnchor.constraint(equalTo: separatorLine.bottomAnchor, constant: 20),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        [button1, button2, button3].forEach { button in
            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalToConstant: buttonWidth),
                button.heightAnchor.constraint(equalToConstant: buttonHeight)
            ])
        }
    }
    
    private func createButton(title: String, iconName: String, color: UIColor, isSystemIcon: Bool) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle("  \(title)", for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        button.backgroundColor = color
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        
        // Add icon based on whether it's a system icon or custom image
        let icon: UIImage?
        if isSystemIcon {
            icon = UIImage(systemName: iconName)
        } else {
            // For custom images, don't include the extension in the name
            icon = UIImage(named: iconName)?.withRenderingMode(.alwaysTemplate)
        }
        
        button.setImage(icon, for: .normal)
        button.tintColor = .white
        button.imageView?.contentMode = .scaleAspectFit
        button.contentHorizontalAlignment = .center
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 10)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        
        return button
    }
}

// Assuming you have this extension for hex colors
