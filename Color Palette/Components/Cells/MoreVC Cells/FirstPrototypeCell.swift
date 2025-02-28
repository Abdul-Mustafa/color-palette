//
//  FirstCellInMoreVC.swift
//  Color Palette
//
//  Created by mac on 27/02/2025.
//

import UIKit

class FirstPrototypeCell: UITableViewCell {
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }
}
