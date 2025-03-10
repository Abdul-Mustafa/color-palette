//import UIKit
//
//class AddButtonViewController: UIViewController {
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        setupUI()
//        
//    }
// 
// 
//    private func setupUI() {
//        // Title Label
//        let titleLabel = UILabel()
//        titleLabel.text = "Color Collect From"
//        titleLabel.textAlignment = .center
//        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
//        titleLabel.textColor = UIColor(hexString: "F24674")
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        
//        // Separator Line
//        let separatorLine = UIView()
//        separatorLine.backgroundColor = .lightGray
//        separatorLine.translatesAutoresizingMaskIntoConstraints = false
//        
//        // Buttons
//        let button1 = createButton(title: "Camera", iconName: "Vector (2)", color: UIColor(hexString: "909392"), isSystemIcon: false)
//        let button2 = createButton(title: "Gallery", iconName: "Group 2228", color: UIColor(hexString: "F24674"), isSystemIcon: false)
//        let button3 = createButton(title: "Pinterest", iconName: "Vector (3)", color: UIColor(hexString: "FF9BAD"), isSystemIcon: false)
//        
//        // StackView for buttons
//        let stackView = UIStackView(arrangedSubviews: [button1, button2, button3])
//        stackView.axis = .vertical
//        stackView.spacing = 20
//        stackView.alignment = .center
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        
//        // Add subviews
//        view.addSubview(titleLabel)
//        view.addSubview(separatorLine)
//        view.addSubview(stackView)
//        
//        // Dynamic button size
//        let buttonWidth = view.bounds.width * 0.8
//        let buttonHeight = view.bounds.height * 0.1
//        
//        NSLayoutConstraint.activate([
//            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
//            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            
//            separatorLine.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
//            separatorLine.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
//            separatorLine.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
//            separatorLine.heightAnchor.constraint(equalToConstant: 1),
//            
//            stackView.topAnchor.constraint(equalTo: separatorLine.bottomAnchor, constant: 20),
//            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
//        ])
//        
//        [button1, button2, button3].forEach { button in
//            NSLayoutConstraint.activate([
//                button.widthAnchor.constraint(equalToConstant: buttonWidth),
//                button.heightAnchor.constraint(equalToConstant: buttonHeight)
//            ])
//        }
//    }
//    
//    private func createButton(title: String, iconName: String, color: UIColor, isSystemIcon: Bool) -> UIButton {
//        let button = UIButton(type: .system)
//        button.setTitle("  \(title)", for: .normal)
//        button.setTitleColor(.white, for: .normal)
//        
//        button.backgroundColor = color
//        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
//        button.layer.cornerRadius = 15
//        button.translatesAutoresizingMaskIntoConstraints = false
//        
//        // Add icon based on whether it's a system icon or custom image
//        let icon: UIImage?
//        if isSystemIcon {
//            icon = UIImage(systemName: iconName)
//        } else {
//            // For custom images, don't include the extension in the name
//            icon = UIImage(named: iconName)?.withRenderingMode(.alwaysTemplate)
//        }
//        
//        button.setImage(icon, for: .normal)
//        button.tintColor = .white
//        button.imageView?.contentMode = .scaleAspectFit
//        button.contentHorizontalAlignment = .center
//        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 10)
//        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
//        
//        return button
//    }
//}
//
//// Assuming you have this extension for hex colors


import UIKit

class AddButtonViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private var galleryButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        
        if navigationController == nil {
            print("Warning: This view controller needs to be embedded in a UINavigationController")
        }
    }
 
    private func setupUI() {
        let titleLabel = UILabel()
        titleLabel.text = "Color Collect From"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textColor = UIColor(hexString: "F24674")
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let separatorLine = UIView()
        separatorLine.backgroundColor = .lightGray
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        
        let button1 = createButton(title: "Camera", iconName: "Vector (2)", color: UIColor(hexString: "909392"), isSystemIcon: false)
        galleryButton = createButton(title: "Gallery", iconName: "Group 2228", color: UIColor(hexString: "F24674"), isSystemIcon: false)
        let button3 = createButton(title: "Pinterest", iconName: "Vector (3)", color: UIColor(hexString: "FF9BAD"), isSystemIcon: false)
        
        galleryButton.addTarget(self, action: #selector(galleryButtonTapped), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [button1, galleryButton, button3])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(titleLabel)
        view.addSubview(separatorLine)
        view.addSubview(stackView)
        
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
        
        [button1, galleryButton, button3].forEach { button in
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
        
        let icon: UIImage?
        if isSystemIcon {
            icon = UIImage(systemName: iconName)
        } else {
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
    
    @objc private func galleryButtonTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else {
            print("No image selected")
            picker.dismiss(animated: true)
            return
        }
        
        print("Image selected successfully")
        picker.dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            let colorVC = ColorDisplayViewController(image: selectedImage)
            
            if let navController = self.navigationController {
                print("Pushing to navigation controller")
                navController.pushViewController(colorVC, animated: true)
            } else {
                print("Presenting modally - no navigation controller found")
                colorVC.modalPresentationStyle = .fullScreen
                self.present(colorVC, animated: true)
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

class ColorDisplayViewController: UIViewController {
    private let selectedImage: UIImage
    
    init(image: UIImage) {
        self.selectedImage = image
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        let imageView = UIImageView(image: selectedImage)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let colors = extractColors(from: selectedImage)
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        colors.forEach { color in
            let colorView = UIView()
            colorView.backgroundColor = color
            colorView.heightAnchor.constraint(equalToConstant: 50).isActive = true
            stackView.addArrangedSubview(colorView)
        }
        
        view.addSubview(imageView)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            
            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func extractColors(from image: UIImage) -> [UIColor] {
        guard let cgImage = image.cgImage,
              let dataProvider = cgImage.dataProvider,
              let data = dataProvider.data,
              let bytes = CFDataGetBytePtr(data) else {
            return [.red, .blue, .green]
        }
        
        var extractedColors: [UIColor] = []
        let pixelCount = cgImage.width * cgImage.height
        let bytesPerPixel = cgImage.bitsPerPixel / 8
        
        for i in 0..<min(5, pixelCount) {
            let offset = i * bytesPerPixel * (pixelCount / 5)
            let r = CGFloat(bytes[offset]) / 255.0
            let g = CGFloat(bytes[offset + 1]) / 255.0
            let b = CGFloat(bytes[offset + 2]) / 255.0
            extractedColors.append(UIColor(red: r, green: g, blue: b, alpha: 1.0))
        }
        
        return extractedColors
    }
}

