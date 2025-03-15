

import UIKit

class AddButtonViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private var galleryButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        
        if navigationController == nil {
            print("Warning: This view controller should be embedded in a UINavigationController for optimal navigation")
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
        
        let cameraButton = createButton(title: "Camera", iconName: "Vector (2)", color: UIColor(hexString: "909392"), isSystemIcon: false)
        galleryButton = createButton(title: "Gallery", iconName: "Group 2228", color: UIColor(hexString: "F24674"), isSystemIcon: false)
        let pinterestButton = createButton(title: "Pinterest", iconName: "Vector (3)", color: UIColor(hexString: "FF9BAD"), isSystemIcon: false)
        
        galleryButton.addTarget(self, action: #selector(galleryButtonTapped), for: .touchUpInside)
        cameraButton.addTarget(self, action: #selector(cameraButtonTapped), for: .touchUpInside)
        pinterestButton.addTarget(self, action: #selector(pinterestButtonTapped), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [cameraButton, galleryButton, pinterestButton])
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
        
        [cameraButton, galleryButton, pinterestButton].forEach { button in
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
    
    @objc private func cameraButtonTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc private func pinterestButtonTapped() {
        print("Pinterest button tapped - implementation pending")
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else {
            print("No image selected")
            picker.dismiss(animated: true)
            return
        }
        
        picker.dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            // Explicitly load the storyboard
            let storyboard = UIStoryboard(name: "Main", bundle: nil) // Adjust "Main" if your storyboard has a different name
            guard let colorVC = storyboard.instantiateViewController(withIdentifier: "UploadedImagePalettesVC") as? UploadedImagePalettesVC else {
                print("Failed to instantiate UploadedImagePalettesVC. Verify:")
                print("1. Storyboard file 'Main.storyboard' exists in the project")
                print("2. View Controller has Storyboard ID 'UploadedImagePalettesVC' set in Interface Builder")
                print("3. Class is set to 'UploadedImagePalettesVC' in Identity Inspector")
                return
            }
            colorVC.image = selectedImage
            print("Presenting UploadedImagePalettesVC modally (no navigation controller)")
            colorVC.modalPresentationStyle = .fullScreen
            self.present(colorVC, animated: true)
        
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

