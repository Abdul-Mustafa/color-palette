//import UIKit
//
//class BottomCollectionViewCellInCollectionVC: UICollectionViewCell {
//    @IBOutlet weak var colorViewInBottomCollectionViewCell: UIView!
//    @IBOutlet weak var colorNameInHexaCodeFormatInBottomCollectionViewCell: UILabel!
//    @IBOutlet weak var viewWithColorLabel: UIView!
//    
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupButtons()
        updateButtonVisibility()
        
        // Pin colorViewInBottomCollectionViewCell to contentView
        colorViewInBottomCollectionViewCell.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            colorViewInBottomCollectionViewCell.topAnchor.constraint(equalTo: contentView.topAnchor),
            colorViewInBottomCollectionViewCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            colorViewInBottomCollectionViewCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            colorViewInBottomCollectionViewCell.bottomAnchor.constraint(equalTo: viewWithColorLabel.topAnchor)
        ])
    }
    
    private func setupButtons() {
        // Add placeholder images for visibility
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
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
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
             updateButtonVisibility() // Disabled for testing
        }
    }
}
