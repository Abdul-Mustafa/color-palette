//
//  JustLabelCell.swift
//  Color Palette
//
//  Created by mac on 27/02/2025.
//

import UIKit

class ThirdPrototypeCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 6
        layer.masksToBounds = true
    }
}
