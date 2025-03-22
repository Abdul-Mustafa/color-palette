//
//import UIKit
//
//class BottomCollectionViewCellInCollectionVC: UICollectionViewCell {
//    @IBOutlet weak var colorViewInBottomCollectionViewCell: UIView!
//    @IBOutlet weak var colorNameInHexaCodeFormatInBottomCollectionViewCell: UILabel!
//    @IBOutlet weak var viewWithColorLabel: UIView!
//    
//    private let heartButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//    
//    private let copyButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//    
//    private let shareButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//    
//    private var centerYConstraint: NSLayoutConstraint?
//    private var hexColor: String = "#FFFFFF"
//    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        setupButtons()
//        updateButtonVisibility() // Ensure initial visibility state
//        
//        colorViewInBottomCollectionViewCell.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            colorViewInBottomCollectionViewCell.topAnchor.constraint(equalTo: contentView.topAnchor),
//            colorViewInBottomCollectionViewCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            colorViewInBottomCollectionViewCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            colorViewInBottomCollectionViewCell.bottomAnchor.constraint(equalTo: viewWithColorLabel.topAnchor)
//        ])
//    }
//    
//    private func setupButtons() {
//        heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
//        copyButton.setImage(UIImage(systemName: "doc.on.doc"), for: .normal)
//        shareButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
//        
//        colorViewInBottomCollectionViewCell.addSubview(heartButton)
//        colorViewInBottomCollectionViewCell.addSubview(copyButton)
//        colorViewInBottomCollectionViewCell.addSubview(shareButton)
//        
//        let stackView = UIStackView(arrangedSubviews: [heartButton, copyButton, shareButton])
//        stackView.axis = .vertical
//        stackView.alignment = .center
//        stackView.distribution = .equalSpacing
//        stackView.spacing = 5
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        
//        colorViewInBottomCollectionViewCell.addSubview(stackView)
//        
//        centerYConstraint = stackView.centerYAnchor.constraint(equalTo: colorViewInBottomCollectionViewCell.centerYAnchor)
//        
//        NSLayoutConstraint.activate([
//            stackView.centerXAnchor.constraint(equalTo: colorViewInBottomCollectionViewCell.centerXAnchor),
//            centerYConstraint!,
//            heartButton.widthAnchor.constraint(equalTo: colorViewInBottomCollectionViewCell.widthAnchor, multiplier: 0.17),
//            heartButton.heightAnchor.constraint(equalTo: heartButton.widthAnchor),
//            copyButton.widthAnchor.constraint(equalTo: colorViewInBottomCollectionViewCell.widthAnchor, multiplier: 0.17),
//            copyButton.heightAnchor.constraint(equalTo: copyButton.widthAnchor),
//            shareButton.widthAnchor.constraint(equalTo: colorViewInBottomCollectionViewCell.widthAnchor, multiplier: 0.17),
//            shareButton.heightAnchor.constraint(equalTo: shareButton.widthAnchor)
//        ])
//        
//        heartButton.addTarget(self, action: #selector(heartButtonTapped), for: .touchUpInside)
//        copyButton.addTarget(self, action: #selector(copyButtonTapped), for: .touchUpInside)
//        shareButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
//    }
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        if let constraint = centerYConstraint {
//            constraint.constant = -viewWithColorLabel.frame.height / 2
//        }
//    }
//    
//    func updateButtonColors() {
//        let textColor = contrastingColor(for: colorViewInBottomCollectionViewCell.backgroundColor ?? .white)
//        heartButton.tintColor = textColor
//        copyButton.tintColor = textColor
//        shareButton.tintColor = textColor
//    }
//    
//    private func contrastingColor(for color: UIColor) -> UIColor {
//        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
//        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
//        let luminance = (0.299 * red + 0.587 * green + 0.114 * blue)
//        return luminance > 0.5 ? .black : .white
//    }
//    
//    func configure(with hexColor: String) {
//        self.hexColor = hexColor
//        colorViewInBottomCollectionViewCell.backgroundColor = UIColor(hexString: hexColor)
//        colorNameInHexaCodeFormatInBottomCollectionViewCell.text = hexColor
//        updateButtonColors()
//        updateButtonVisibility() // Ensure visibility updates after configuration
//    }
//    
//    private func updateButtonVisibility() {
//        heartButton.isHidden = !isSelected
//        copyButton.isHidden = !isSelected
//        shareButton.isHidden = !isSelected
//    }
//    
//    override var isSelected: Bool {
//        didSet {
//            updateButtonVisibility()
//        }
//    }
//    
//    @objc private func heartButtonTapped() {
//        let alert = UIAlertController(
//            title: "Remove Color",
//            message: "Are you sure you want to remove this color from your favorites?",
//            preferredStyle: .alert
//        )
//        let removeAction = UIAlertAction(title: "Yes", style: .destructive) { [weak self] _ in
//            guard let self = self else { return }
//            CoreDataManager.shared.deleteSingleColor(name: self.hexColor)
//            NotificationCenter.default.post(name: CoreDataManager.paletteDidChangeNotification, object: nil)
//        }
//        let cancelAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
//        alert.addAction(removeAction)
//        alert.addAction(cancelAction)
//        
//        if let rootVC = window?.rootViewController {
//            rootVC.present(alert, animated: true, completion: nil)
//        }
//    }
//    
//    @objc private func copyButtonTapped() {
//        UIPasteboard.general.string = hexColor
//        copyButton.tintColor = .systemGreen
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
//            self?.updateButtonColors()
//        }
//    }
//    
//    @objc private func shareButtonTapped() {
//        let activityVC = UIActivityViewController(activityItems: [hexColor], applicationActivities: nil)
//        if let rootVC = window?.rootViewController {
//            rootVC.present(activityVC, animated: true, completion: nil)
//        }
//    }
//}
import UIKit

class BottomCollectionViewCellInCollectionVC: UICollectionViewCell {
    @IBOutlet weak var colorViewInBottomCollectionViewCell: UIView!
    @IBOutlet weak var colorNameInHexaCodeFormatInBottomCollectionViewCell: UILabel!
    @IBOutlet weak var viewWithColorLabel: UIView!
    
    private let heartButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let copyButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var centerYConstraint: NSLayoutConstraint?
    private var hexColor: String = "#FFFFFF"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupButtons()
        updateButtonVisibility()
        
        colorViewInBottomCollectionViewCell.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            colorViewInBottomCollectionViewCell.topAnchor.constraint(equalTo: contentView.topAnchor),
            colorViewInBottomCollectionViewCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            colorViewInBottomCollectionViewCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            colorViewInBottomCollectionViewCell.bottomAnchor.constraint(equalTo: viewWithColorLabel.topAnchor)
        ])
    }
    
    private func setupButtons() {
        heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        copyButton.setImage(UIImage(systemName: "doc.on.doc"), for: .normal)
        shareButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        
        colorViewInBottomCollectionViewCell.addSubview(heartButton)
        colorViewInBottomCollectionViewCell.addSubview(copyButton)
        colorViewInBottomCollectionViewCell.addSubview(shareButton)
        
        let stackView = UIStackView(arrangedSubviews: [heartButton, copyButton, shareButton])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        colorViewInBottomCollectionViewCell.addSubview(stackView)
        
        centerYConstraint = stackView.centerYAnchor.constraint(equalTo: colorViewInBottomCollectionViewCell.centerYAnchor)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: colorViewInBottomCollectionViewCell.centerXAnchor),
            centerYConstraint!,
            heartButton.widthAnchor.constraint(equalTo: colorViewInBottomCollectionViewCell.widthAnchor, multiplier: 0.17),
            heartButton.heightAnchor.constraint(equalTo: heartButton.widthAnchor),
            copyButton.widthAnchor.constraint(equalTo: colorViewInBottomCollectionViewCell.widthAnchor, multiplier: 0.17),
            copyButton.heightAnchor.constraint(equalTo: copyButton.widthAnchor),
            shareButton.widthAnchor.constraint(equalTo: colorViewInBottomCollectionViewCell.widthAnchor, multiplier: 0.17),
            shareButton.heightAnchor.constraint(equalTo: shareButton.widthAnchor)
        ])
        
        heartButton.addTarget(self, action: #selector(heartButtonTapped), for: .touchUpInside)
        copyButton.addTarget(self, action: #selector(copyButtonTapped), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let constraint = centerYConstraint {
            constraint.constant = -viewWithColorLabel.frame.height / 2
        }
    }
    
    func updateButtonColors() {
        let textColor = contrastingColor(for: colorViewInBottomCollectionViewCell.backgroundColor ?? .white)
        heartButton.tintColor = textColor
        copyButton.tintColor = textColor
        shareButton.tintColor = textColor
    }
    
    private func contrastingColor(for color: UIColor) -> UIColor {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        let luminance = (0.299 * red + 0.587 * green + 0.114 * blue)
        return luminance > 0.5 ? .black : .white
    }
    
    func configure(with hexColor: String) {
        self.hexColor = hexColor
        colorViewInBottomCollectionViewCell.backgroundColor = UIColor(hexString: hexColor)
        colorNameInHexaCodeFormatInBottomCollectionViewCell.text = hexColor
        updateButtonColors()
        updateButtonVisibility()
    }
    
    private func updateButtonVisibility() {
        heartButton.isHidden = !isSelected
        copyButton.isHidden = !isSelected
        shareButton.isHidden = !isSelected
    }
    
    override var isSelected: Bool {
        didSet {
            updateButtonVisibility()
        }
    }
    
    @objc private func heartButtonTapped() {
        let alert = UIAlertController(
            title: "Remove Color",
            message: "Are you sure you want to remove this color from your favorites?",
            preferredStyle: .alert
        )
        let removeAction = UIAlertAction(title: "Yes", style: .destructive) { [weak self] _ in
            guard let self = self else { return }
            CoreDataManager.shared.deleteSingleColor(name: self.hexColor)
            NotificationCenter.default.post(name: CoreDataManager.paletteDidChangeNotification, object: nil)
        }
        let cancelAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        alert.addAction(removeAction)
        alert.addAction(cancelAction)
        
        if let rootVC = window?.rootViewController {
            rootVC.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc private func copyButtonTapped() {
        UIPasteboard.general.string = hexColor
        copyButton.tintColor = .systemGreen
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
            self?.updateButtonColors()
        }
    }
    
    @objc private func shareButtonTapped() {
        let activityVC = UIActivityViewController(activityItems: [hexColor], applicationActivities: nil)
        if let rootVC = window?.rootViewController {
            rootVC.present(activityVC, animated: true, completion: nil)
        }
    }
}
