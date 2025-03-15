//
//  SlectedPaletteCVCell.swift
//  Color Palette
//
//  Created by mac on 15/03/2025.
//

import UIKit

class SlectedPaletteCVCell: UICollectionViewCell {
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var hexaCodeLabel: UILabel!
    @IBOutlet weak var rgbColorLabel: UILabel!
    override func awakeFromNib() {
            super.awakeFromNib()
            // Make the colorView rounded
            colorView.layer.cornerRadius = 10 // Adjust the radius as needed
            colorView.clipsToBounds = true    // Ensures the content stays within the rounded bounds
        }
}
