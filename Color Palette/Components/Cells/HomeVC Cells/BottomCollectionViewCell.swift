//////
//////  BottomCollectionViewCell.swift
//////  Color Palette
//////
//////  Created by mac on 19/02/2025.
//////
////
////import UIKit
////
////class BottomCollectionViewCell: UICollectionViewCell {
////    @IBOutlet weak var colorViewInBottomCollectionViewCell: UIView!
////    
////   
////    @IBOutlet weak var colorNameInHexaCodeFormatInBottomCollectionViewCell: UILabel!
////    
////}
////  BottomCollectionViewCell.swift
////  Color Palette
////  Created by mac on 19/02/2025
//
//import UIKit
//
//class BottomCollectionViewCell: UICollectionViewCell {
//    @IBOutlet weak var colorViewInBottomCollectionViewCell: UIView!
//    @IBOutlet weak var colorNameInHexaCodeFormatInBottomCollectionViewCell: UILabel!
//    
//    // Button declarations
//    private let heartButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setImage(UIImage(systemName: "heart"), for: .normal)
//        button.tintColor = .white
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//    
//    private let copyButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setImage(UIImage(systemName: "doc.on.doc"), for: .normal)
//        button.tintColor = .white
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//    
//    private let shareButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
//        button.tintColor = .white
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        setupButtons()
//    }
//    
//    private func setupButtons() {
//        // Add buttons to the colorView
//        colorViewInBottomCollectionViewCell.addSubview(heartButton)
//        colorViewInBottomCollectionViewCell.addSubview(copyButton)
//        colorViewInBottomCollectionViewCell.addSubview(shareButton)
//        
//        // Create a vertical stack view for the buttons
//        let stackView = UIStackView(arrangedSubviews: [heartButton, copyButton, shareButton])
//        stackView.axis = .vertical
//        stackView.alignment = .center
//        stackView.distribution = .equalSpacing
//        stackView.spacing = 5
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        
//        colorViewInBottomCollectionViewCell.addSubview(stackView)
//        
//        // Set up constraints
//        NSLayoutConstraint.activate([
//            // Center the stack view in the colorView
//            stackView.centerXAnchor.constraint(equalTo: colorViewInBottomCollectionViewCell.centerXAnchor),
//            stackView.centerYAnchor.constraint(equalTo: colorViewInBottomCollectionViewCell.centerYAnchor),
//            
//            // Set button sizes relative to colorView (e.g., 20% of colorView's width)
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
//    // Optional: Configure cell with data
//    func configure(with hexColor: String) {
//        colorNameInHexaCodeFormatInBottomCollectionViewCell.text = hexColor
//        colorViewInBottomCollectionViewCell.backgroundColor = UIColor(hex: hexColor)
//        // Ensure buttons are visible against background
//        heartButton.tintColor = contrastingColor(for: colorViewInBottomCollectionViewCell.backgroundColor ?? .white)
//        copyButton.tintColor = contrastingColor(for: colorViewInBottomCollectionViewCell.backgroundColor ?? .white)
//        shareButton.tintColor = contrastingColor(for: colorViewInBottomCollectionViewCell.backgroundColor ?? .white)
//    }
//    
//    // Helper function to determine contrasting color
//    private func contrastingColor(for color: UIColor) -> UIColor {
//        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
//        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
//        let luminance = (0.299 * red + 0.587 * green + 0.114 * blue)
//        return luminance > 0.5 ? .black : .white
//    }
//}
//
//// UIColor extension for hex support
///
import UIKit

class BottomCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var colorViewInBottomCollectionViewCell: UIView!
    @IBOutlet weak var colorNameInHexaCodeFormatInBottomCollectionViewCell: UILabel!
    
    // Button declarations remain the same
    private let heartButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let copyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "doc.on.doc"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupButtons()
        updateButtonVisibility()
    }
    
    private func setupButtons() {
        // Add buttons to the colorView
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
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: colorViewInBottomCollectionViewCell.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: colorViewInBottomCollectionViewCell.centerYAnchor),
            
            heartButton.widthAnchor.constraint(equalTo: colorViewInBottomCollectionViewCell.widthAnchor, multiplier: 0.17),
            heartButton.heightAnchor.constraint(equalTo: heartButton.widthAnchor),
            
            copyButton.widthAnchor.constraint(equalTo: colorViewInBottomCollectionViewCell.widthAnchor, multiplier: 0.17),
            copyButton.heightAnchor.constraint(equalTo: copyButton.widthAnchor),
            
            shareButton.widthAnchor.constraint(equalTo: colorViewInBottomCollectionViewCell.widthAnchor, multiplier: 0.17),
            shareButton.heightAnchor.constraint(equalTo: shareButton.widthAnchor)
        ])
    }
    
    // Update button visibility based on selection state
    private func updateButtonVisibility() {
        heartButton.isHidden = !isSelected
        copyButton.isHidden = !isSelected
        shareButton.isHidden = !isSelected
    }
    
    // Override isSelected to update button visibility
    override var isSelected: Bool {
        didSet {
            updateButtonVisibility()
        }
    }
    
    func configure(with hexColor: String) {
        colorNameInHexaCodeFormatInBottomCollectionViewCell.text = hexColor
        colorViewInBottomCollectionViewCell.backgroundColor = UIColor(hex: hexColor)
        heartButton.tintColor = contrastingColor(for: colorViewInBottomCollectionViewCell.backgroundColor ?? .white)
        copyButton.tintColor = contrastingColor(for: colorViewInBottomCollectionViewCell.backgroundColor ?? .white)
        shareButton.tintColor = contrastingColor(for: colorViewInBottomCollectionViewCell.backgroundColor ?? .white)
        updateButtonVisibility() // Ensure visibility is correct after configuration
    }
    
    private func contrastingColor(for color: UIColor) -> UIColor {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        let luminance = (0.299 * red + 0.587 * green + 0.114 * blue)
        return luminance > 0.5 ? .black : .white
    }
}
