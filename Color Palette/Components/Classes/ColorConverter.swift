//
//  ColorConverter.swift
//  Color Palette
//
//  Created by mac on 26/02/2025.
//
import UIKit

extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if hexSanitized.hasPrefix("#") {
            hexSanitized.remove(at: hexSanitized.startIndex)
        }
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let r = CGFloat((rgb >> 16) & 0xFF) / 255.0
        let g = CGFloat((rgb >> 8) & 0xFF) / 255.0
        let b = CGFloat(rgb & 0xFF) / 255.0
        
        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
}

extension UIColor {
    /// Initializes a UIColor from a hex string (e.g., "#FFFFFF" or "FFFFFF")
    convenience init(hexString: String) {
        var hexSanitized = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if hexSanitized.hasPrefix("#") {
            hexSanitized.remove(at: hexSanitized.startIndex)
        }
        
        guard hexSanitized.count == 6 else {
            self.init(white: 1.0, alpha: 1.0) // Default to white if invalid
            return
        }

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = CGFloat((rgb >> 16) & 0xFF) / 255.0
        let green = CGFloat((rgb >> 8) & 0xFF) / 255.0
        let blue = CGFloat(rgb & 0xFF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    /// Returns a much lighter or darker variant of the color for better contrast
    func adjustedBrightness() -> UIColor {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        // Calculate luminance using the standard formula
        let luminance = (0.299 * red + 0.587 * green + 0.114 * blue)
        
        let adjustment: CGFloat = luminance > 0.5 ? -0.5 : 0.5 // Make changes more pronounced
        
        let adjustedRed = max(0, min(1, red + adjustment))
        let adjustedGreen = max(0, min(1, green + adjustment))
        let adjustedBlue = max(0, min(1, blue + adjustment))
        
        return UIColor(red: adjustedRed, green: adjustedGreen, blue: adjustedBlue, alpha: alpha)
    }
    
}



