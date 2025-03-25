//
//
//import UIKit
//
//class AddButtonViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//    
//    private var galleryButton: UIButton!
//    var firsttimeload = true
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        if !isPremiumUser() && firsttimeload {
//            firsttimeload = false
//            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProScreenVC") as! ProScreenVC
//            vc.modalPresentationStyle = .fullScreen
//            present(vc, animated: true, completion: nil)
//        }
//    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        setupUI()
//        
//        if navigationController == nil {
//            print("Warning: This view controller should be embedded in a UINavigationController for optimal navigation")
//        }
//    }
//    
//
//    
//    private func setupUI() {
//        let titleLabel = UILabel()
//        titleLabel.text = "Color Collect From"
//        titleLabel.textAlignment = .center
//        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
//        titleLabel.textColor = UIColor(hexString: "F24674")
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        
//        let separatorLine = UIView()
//        separatorLine.backgroundColor = .lightGray
//        separatorLine.translatesAutoresizingMaskIntoConstraints = false
//        
//        let cameraButton = createButton(title: "Camera", iconName: "Vector (2)", color: UIColor(hexString: "909392"), isSystemIcon: false)
//        galleryButton = createButton(title: "Gallery", iconName: "Group 2228", color: UIColor(hexString: "F24674"), isSystemIcon: false)
//        let pinterestButton = createButton(title: "Pinterest", iconName: "Vector (3)", color: UIColor(hexString: "FF9BAD"), isSystemIcon: false)
//        
//        galleryButton.addTarget(self, action: #selector(galleryButtonTapped), for: .touchUpInside)
//        cameraButton.addTarget(self, action: #selector(cameraButtonTapped), for: .touchUpInside)
//        pinterestButton.addTarget(self, action: #selector(pinterestButtonTapped), for: .touchUpInside)
//        
//        let stackView = UIStackView(arrangedSubviews: [cameraButton, galleryButton, pinterestButton])
//        stackView.axis = .vertical
//        stackView.spacing = 20
//        stackView.alignment = .center
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        
//        view.addSubview(titleLabel)
//        view.addSubview(separatorLine)
//        view.addSubview(stackView)
//        
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
//        [cameraButton, galleryButton, pinterestButton].forEach { button in
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
//        let icon: UIImage?
//        if isSystemIcon {
//            icon = UIImage(systemName: iconName)
//        } else {
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
//    
//    @objc private func galleryButtonTapped() {
//        if !isPremiumUser(){
//            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProScreenVC") as! ProScreenVC
//            vc.modalPresentationStyle = .fullScreen
//            present(vc, animated: true, completion: nil)
//        }
//        else {
//            let imagePicker = UIImagePickerController()
//            imagePicker.sourceType = .photoLibrary
//            imagePicker.delegate = self
//            imagePicker.allowsEditing = false
//            present(imagePicker, animated: true, completion: nil)}
//    }
//    
//    @objc private func cameraButtonTapped() {
//        if !isPremiumUser(){
//            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProScreenVC") as! ProScreenVC
//            vc.modalPresentationStyle = .fullScreen
//            present(vc, animated: true, completion: nil)
//        }
//        else {
//            let imagePicker = UIImagePickerController()
//            imagePicker.sourceType = .camera
//            imagePicker.delegate = self
//            imagePicker.allowsEditing = false
//            present(imagePicker, animated: true, completion: nil)}
//    }
//    
//    @objc private func pinterestButtonTapped() {
//        print("Pinterest button tapped - implementation pending")
//    }
//    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        guard let selectedImage = info[.originalImage] as? UIImage else {
//            print("No image selected")
//            picker.dismiss(animated: true)
//            return
//        }
//        
//        picker.dismiss(animated: true) { [weak self] in
//            guard let self = self else { return }
//            // Explicitly load the storyboard
//            let storyboard = UIStoryboard(name: "Main", bundle: nil) // Adjust "Main" if your storyboard has a different name
//            guard let colorVC = storyboard.instantiateViewController(withIdentifier: "UploadedImagePalettesVC") as? UploadedImagePalettesVC else {
//                print("Failed to instantiate UploadedImagePalettesVC. Verify:")
//                print("1. Storyboard file 'Main.storyboard' exists in the project")
//                print("2. View Controller has Storyboard ID 'UploadedImagePalettesVC' set in Interface Builder")
//                print("3. Class is set to 'UploadedImagePalettesVC' in Identity Inspector")
//                return
//            }
//            colorVC.image = selectedImage
//            print("Presenting UploadedImagePalettesVC modally (no navigation controller)")
//            colorVC.modalPresentationStyle = .fullScreen
//            self.present(colorVC, animated: true)
//        
//        }
//    }
//    
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        picker.dismiss(animated: true)
//    }
//}
//
import UIKit

class AddButtonViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private var galleryButton: UIButton!
    var firsttimeload = true
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !isPremiumUser() && firsttimeload {
            firsttimeload = false
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProScreenVC") as! ProScreenVC
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
    }
    
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
        if !UserLimitsManager.canUploadImage() {
            showToast(message: UserLimitsManager.limitReachedMessage(for: .imageUpload))
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProScreenVC") as! ProScreenVC
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        } else {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @objc private func cameraButtonTapped() {
        if !UserLimitsManager.canUseCamera() {
            showToast(message: UserLimitsManager.limitReachedMessage(for: .cameraUsage))
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProScreenVC") as! ProScreenVC
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        } else {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .camera
            imagePicker.delegate = self
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }
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
        
        if picker.sourceType == .camera {
            UserLimitsManager.incrementCameraUsage()
        } else if picker.sourceType == .photoLibrary {
            UserLimitsManager.incrementImageUpload()
        }
        
        picker.dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let colorVC = storyboard.instantiateViewController(withIdentifier: "UploadedImagePalettesVC") as? UploadedImagePalettesVC else {
                print("Failed to instantiate UploadedImagePalettesVC")
                return
            }
            colorVC.image = selectedImage
            colorVC.modalPresentationStyle = .fullScreen
            self.present(colorVC, animated: true)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    private func showToast(message: String, duration: TimeInterval = 2.0) {
        let toastLabel = UILabel()
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center
        toastLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        toastLabel.text = message
        toastLabel.alpha = 0.0
        toastLabel.numberOfLines = 0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        
        let maxWidth = view.frame.size.width * 0.7
        let textSize = toastLabel.sizeThatFits(CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude))
        toastLabel.frame = CGRect(x: 0, y: 0, width: textSize.width + 40, height: textSize.height + 20)
        toastLabel.center = view.center
        
        view.addSubview(toastLabel)
        
        UIView.animate(withDuration: 0.5, animations: {
            toastLabel.alpha = 1.0
        }) { _ in
            UIView.animate(withDuration: 0.5, delay: duration, options: .curveEaseOut, animations: {
                toastLabel.alpha = 0.0
            }) { _ in
                toastLabel.removeFromSuperview()
            }
        }
    }
}
