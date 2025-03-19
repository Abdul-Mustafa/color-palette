import UIKit

class BottomCollectionViewCellInCollectionVC: UICollectionViewCell {
    @IBOutlet weak var colorViewInBottomCollectionViewCell: UIView!
    @IBOutlet weak var colorNameInHexaCodeFormatInBottomCollectionViewCell: UILabel!
    @IBOutlet weak var viewWithColorLabel: UIView!
    
}

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
//    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        setupButtons()
//        updateButtonVisibility()
//    }
//    
//    private func setupButtons() {
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
//        // Store the centerY constraint to update later
//        centerYConstraint = stackView.centerYAnchor.constraint(equalTo: colorViewInBottomCollectionViewCell.centerYAnchor)
//        
//        NSLayoutConstraint.activate([
//            stackView.centerXAnchor.constraint(equalTo: colorViewInBottomCollectionViewCell.centerXAnchor),
//            centerYConstraint!,
//            
//            heartButton.widthAnchor.constraint(equalTo: colorViewInBottomCollectionViewCell.widthAnchor, multiplier: 0.17),
//            heartButton.heightAnchor.constraint(equalTo: heartButton.widthAnchor),
//            
//            copyButton.widthAnchor.constraint(equalTo: colorViewInBottomCollectionViewCell.widthAnchor, multiplier: 0.17),
//            copyButton.heightAnchor.constraint(equalTo: copyButton.widthAnchor),
//            
//            shareButton.widthAnchor.constraint(equalTo: colorViewInBottomCollectionViewCell.widthAnchor, multiplier: 0.17),
//            shareButton.heightAnchor.constraint(equalTo: shareButton.widthAnchor)
//        ])
//    }
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        // Update the centerY constraint with the offset once the layout is ready
//        if let constraint = centerYConstraint {
//            constraint.constant = -viewWithColorLabel.frame.height / 2
//        }
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
//}
