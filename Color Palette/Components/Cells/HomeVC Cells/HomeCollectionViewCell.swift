//
//  HomeCollectionViewCell.swift
//  Color Palette
//
//  Created by mac on 17/02/2025.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var ellipsisButtonInCollectionViewCell: UIButton!
    
    @IBOutlet weak var colorCodeInBottomCenterInCollectionViewCell: UILabel!
    @IBOutlet weak var ActionForEllipsisButtonInCollectionViewCell: UIButton!
    
    @IBOutlet weak var proButtonOutlet: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        proButtonOutlet.layer.borderWidth = 1
        proButtonOutlet.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        proButtonOutlet.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        proButtonOutlet.layer.cornerRadius = 10.0 // Match viewDidLoad value
        proButtonOutlet.clipsToBounds = true
    }
    
    @IBAction func proButtonAction(_ sender: Any) {
      
    }
    
}
