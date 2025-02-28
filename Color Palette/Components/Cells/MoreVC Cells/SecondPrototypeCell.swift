//
//  ImageLabelButtonCell.swift
//  Color Palette
//
//  Created by mac on 27/02/2025.
//

import UIKit

class SecondPrototypeCell: UITableViewCell {
    
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //layer.cornerRadius = 8
        //layer.masksToBounds = true
    }
}
