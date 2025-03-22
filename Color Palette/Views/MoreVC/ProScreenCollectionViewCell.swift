//
//  ProScreenCollectionViewCell.swift
//  Color Palette
//
//  Created by mac on 21/03/2025.
//

import UIKit

class ProScreenCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var planDuration: UILabel!
    @IBOutlet weak var planType: UILabel!
    @IBOutlet weak var planPricing: UILabel!
    @IBOutlet weak var trialview: UIView!
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 2.0
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = 15.0
    }
}
