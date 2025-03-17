//
//  AdjustmentVCCollectionViewCell.swift
//  Color Palette
//
//  Created by mac on 17/03/2025.
//

import UIKit

class AdjustmentVCCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var hexaCodeLabel: UILabel!
    override func awakeFromNib() {
            super.awakeFromNib()
            
            // Add corner radius to the colorView
            colorView.layer.cornerRadius = 10
            colorView.clipsToBounds = true
        

        }
    
    
}
