//
//  TabBar.swift
//  Color Palette
//
//  Created by mac on 07/02/2025.
//

import UIKit
//
//class TabBar: UITabBar {
//
//    /*
//    // Only override draw() if you perform custom drawing.
//    // An empty implementation adversely affects performance during animation.
//    override func draw(_ rect: CGRect) {
//        // Drawing code
//    }
//    */
//
//}


class TabBar: UITabBar {
    override func awakeFromNib() {
        super.awakeFromNib()
        setupAppearance()
    }

    private func setupAppearance() {
        self.backgroundColor = UIColor(hex: "#F24674")
        self.barTintColor = UIColor.systemBlue    // Background color
        self.tintColor = UIColor(hex: "#FFFFFF")          // Selected item color
        self.unselectedItemTintColor = UIColor(hex: "#D5D5D5")// Unselected item color
        self.isTranslucent = false              // Disable transparency
    }
}

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
