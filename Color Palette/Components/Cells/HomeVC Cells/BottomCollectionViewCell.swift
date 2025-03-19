
import UIKit
class BottomCollectionViewCell: UICollectionViewCell {
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
    var onDataChanged: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupButtons()
        updateButtonVisibility()
    }
    
    private func setupButtons() {
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
        
        // Store the centerY constraint to update later
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
        // Update the centerY constraint with the offset once the layout is ready
        if let constraint = centerYConstraint {
            constraint.constant = -viewWithColorLabel.frame.height / 2
        }
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
    
    func configure(with hexColor: String) {
        self.hexColor = hexColor
        colorNameInHexaCodeFormatInBottomCollectionViewCell.text = hexColor
        colorViewInBottomCollectionViewCell.backgroundColor = UIColor(hex: hexColor)
        
        let textColor = contrastingColor(for: colorViewInBottomCollectionViewCell.backgroundColor ?? .white)
        let isSaved = CoreDataManager.shared.isSingleColorSaved(name: hexColor)
        let isCopied = UIPasteboard.general.string == hexColor
        
        heartButton.setImage(UIImage(systemName: isSaved ? "heart.fill" : "heart"), for: .normal)
        heartButton.tintColor = textColor
        
        copyButton.setImage(UIImage(systemName: isCopied ? "doc.on.doc.fill" : "doc.on.doc"), for: .normal)
        copyButton.tintColor = textColor
        
        shareButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        shareButton.tintColor = textColor
        
        updateButtonVisibility()
    }
    
    private func contrastingColor(for color: UIColor) -> UIColor {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        let luminance = (0.299 * red + 0.587 * green + 0.114 * blue)
        return luminance > 0.5 ? .black : .white
    }
    
    @objc private func heartButtonTapped() {
        let isSaved = CoreDataManager.shared.isSingleColorSaved(name: hexColor)
        
        if isSaved {
            let alert = UIAlertController(
                title: "Unsave Color",
                message: "Do you want to unsave this color?",
                preferredStyle: .alert
            )
            let unsaveAction = UIAlertAction(title: "Yes", style: .destructive) { [weak self] _ in
                guard let self = self else { return }
                CoreDataManager.shared.deleteSingleColor(name: self.hexColor)
                DispatchQueue.main.async {
                    self.configure(with: self.hexColor)
                    self.onDataChanged?()
                }
            }
            let cancelAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
            alert.addAction(unsaveAction)
            alert.addAction(cancelAction)
            if let rootVC = window?.rootViewController {
                rootVC.present(alert, animated: true, completion: nil)
            }
        } else {
            CoreDataManager.shared.saveSingleColor(name: hexColor)
            DispatchQueue.main.async {
                self.configure(with: self.hexColor)
                self.onDataChanged?()
            }
        }
    }
    
    @objc private func copyButtonTapped() {
        UIPasteboard.general.string = hexColor
        DispatchQueue.main.async {
            self.configure(with: self.hexColor)
            self.onDataChanged?()
        }
    }
    
    @objc private func shareButtonTapped() {
        let activityVC = UIActivityViewController(activityItems: [hexColor], applicationActivities: nil)
        if let viewController = window?.rootViewController {
            viewController.present(activityVC, animated: true)
        }
    }
}
