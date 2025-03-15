//
//  SlectedPaletteInExploreVC.swift
//  Color Palette
//
//  Created by mac on 14/03/2025.
//

import UIKit

class SlectedPaletteInExploreVC: UIViewController, UITabBarDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedPalette?.colors.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SlectedPaletteCVCell", for: indexPath) as! SlectedPaletteCVCell
        let color = selectedPalette?.colors[indexPath.row]
        cell.colorView.backgroundColor = UIColor(hex: color ?? "FFFFFF")
        cell.hexaCodeLabel.text = color
        cell.rgbColorLabel.text = hexToRGBString(color ?? "FFFFFF")
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let relativeWidth = collectionViewWidth * 0.25 // 50% of the collection view's width
        let relativeHeight = relativeWidth * 3 // Maintaining a 1:1.32 aspect ratio, for example
        
        return CGSize(width: relativeWidth, height: relativeHeight)
    }
    
    
    var selectedPalette: ColorPalette?
    @IBOutlet weak var exitButtonView: UIButton!
    @IBOutlet weak var save: UITabBarItem!
    @IBOutlet weak var colorTitle: UILabel!
    @IBOutlet weak var adjust: UITabBarItem!
    @IBOutlet weak var delete: UITabBarItem!
    @IBOutlet weak var download: UITabBarItem!
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(selectedPalette)
        colorTitle.text = selectedPalette?.name
        colorView.backgroundColor = UIColor(hex: selectedPalette?.colors.first ?? "#FFFFFF")
        tabBar.delegate = self  // Set the delegate
        exitButtonView.layer.cornerRadius = exitButtonView.frame.height / 2
        exitButtonView.clipsToBounds = true
        colorView.layer.cornerRadius = exitButtonView.frame.height / 4
        colorView.clipsToBounds = true
        collectionView.delegate = self
        collectionView.dataSource = self
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                    layout.scrollDirection = .horizontal
                    layout.estimatedItemSize = .zero
                    // Optional: Ensure no vertical scrolling by setting content size
            collectionView.isScrollEnabled = true // Horizontal scrolling only
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.showsVerticalScrollIndicator = false
                }
        
    }
    @IBAction func closeButtonTapped(_ sender: Any) {
            self.dismiss(animated: true, completion: nil)
        }
    // Delegate method to handle tab selection
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item == save {
            saveButtonTapped()
        } else if item == adjust {
            adjustButtonTapped()
        } else if item == delete {
            deleteButtonTapped()
        }
    else if item == download {
        downloadButtonTapped()
    }
    }

    // Custom actions for each "button"
    func saveButtonTapped() {
        print("Home tab tapped!")
        // Add your logic here (e.g., navigate, update UI)
    }

    func adjustButtonTapped() {
        print("Profile tab tapped!")
        // Add your logic here
    }

    func deleteButtonTapped() {
        print("Settings tab tapped!")
        // Add your logic here
    }
    func downloadButtonTapped() {
        print("Settings tab tapped!")
        // Add your logic here
    }
    func hexToRGBString(_ hex: String) -> String {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        // Remove "#" if it exists
        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }
        
        // Check if the hex string is valid (6 characters for RGB)
        guard hexString.count == 6 else { return "(Invalid)" }
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgbValue)
        
        let red = (rgbValue & 0xFF0000) >> 16
        let green = (rgbValue & 0x00FF00) >> 8
        let blue = rgbValue & 0x0000FF
        
        return "(\(red), \(green), \(blue))"
    }
}
