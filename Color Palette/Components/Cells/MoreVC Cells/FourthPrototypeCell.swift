//
//  BottomThreeCells.swift
//  Color Palette
//
//  Created by mac on 27/02/2025.
//

import UIKit

class FourthPrototypeCell: UITableViewCell {
    
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 8
        layer.masksToBounds = true
    }
}
