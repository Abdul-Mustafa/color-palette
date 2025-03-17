//
//  SlectedPaletteAdjustment.swift
//  Color Palette
//
//  Created by mac on 15/03/2025.
//

import UIKit

class SlectedPaletteAdjustment: UIViewController {
    var selectedColor: String? // Property to receive the hex code

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        if let color = selectedColor {
            print("Received color: \(color)")
            // Use the color as needed (e.g., set a view's background)
        }
    }
}
