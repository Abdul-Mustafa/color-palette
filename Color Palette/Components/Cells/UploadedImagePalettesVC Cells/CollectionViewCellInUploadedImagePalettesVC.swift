//
//  CollectionViewCellInUploadedImagePalettesVC.swift
//  Color Palette
//
//  Created by mac on 11/03/2025.
//

import UIKit

class CollectionViewCellInUploadedImagePalettesVC: UICollectionViewCell {
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var hexaCodeLabel: UILabel!
    override func awakeFromNib() {
            super.awakeFromNib()
            
            // Add corner radius to the colorView
            colorView.layer.cornerRadius = 10  // Adjust this value as needed
            colorView.clipsToBounds = true
            
            // Optional: Add corner radius to the entire cell
            // layer.cornerRadius = 10
            // clipsToBounds = true
        }
}
