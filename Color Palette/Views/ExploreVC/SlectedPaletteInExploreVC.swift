//////
//////  SlectedPaletteInExploreVC.swift
//////  Color Palette
//////
//////  Created by mac on 14/03/2025.
//////
////
////import UIKit
////
////class SlectedPaletteInExploreVC: UIViewController, UITabBarDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
////    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
////        return selectedPalette?.colors.count ?? 0
////    }
////    
////    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
////        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SlectedPaletteCVCell", for: indexPath) as! SlectedPaletteCVCell
////        let color = selectedPalette?.colors[indexPath.row]
////        cell.colorView.backgroundColor = UIColor(hex: color ?? "FFFFFF")
////        cell.hexaCodeLabel.text = color
////        cell.rgbColorLabel.text = hexToRGBString(color ?? "FFFFFF")
////        if indexPath == selectedIndexPath {
////                cell.layer.borderWidth = 2.0
////                cell.layer.cornerRadius = 10.0
////                cell.layer.borderColor = UIColor.gray.cgColor
////            } else {
////                cell.layer.borderWidth = 0.0
////            }
////        return cell
////    }
////    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
////        let collectionViewWidth = collectionView.bounds.width
////        let relativeWidth = collectionViewWidth * 0.25 // 50% of the collection view's width
////        let relativeHeight = relativeWidth * 3 // Maintaining a 1:1.32 aspect ratio, for example
////        
////        return CGSize(width: relativeWidth, height: relativeHeight)
////    }
////    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
////        // Restore previous cell to normal state
////        if let previousIndexPath = selectedIndexPath,
////           previousIndexPath != indexPath,
////           let previousCell = collectionView.cellForItem(at: previousIndexPath) as? SlectedPaletteCVCell {
////            previousCell.layer.borderWidth = 0.0
////            previousCell.layer.borderColor = nil
////        }
////        
////        // Update new selected cell
////        if let cell = collectionView.cellForItem(at: indexPath) as? SlectedPaletteCVCell {
////            cell.layer.borderWidth = 2.0
////            cell.layer.cornerRadius = 10.0
////            cell.layer.borderColor = UIColor.gray.cgColor
////            
////            // Update the main color view with the selected color
////            if let color = selectedPalette?.colors[indexPath.row] {
////                colorView.backgroundColor = UIColor(hex: color)
////            }
////        }
////        
////        selectedIndexPath = indexPath
////    }
////    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
////        if let cell = collectionView.cellForItem(at: indexPath) as? SlectedPaletteCVCell {
////            cell.layer.borderWidth = 0.0
////            cell.layer.borderColor = nil
////        }
////    }
////    
////    private var selectedIndexPath: IndexPath?
////    var selectedPalette: ColorPalette?
////    @IBOutlet weak var exitButtonView: UIButton!
////    @IBOutlet weak var save: UITabBarItem!
////    @IBOutlet weak var colorTitle: UILabel!
////    @IBOutlet weak var adjust: UITabBarItem!
////    @IBOutlet weak var delete: UITabBarItem!
////    @IBOutlet weak var download: UITabBarItem!
////    @IBOutlet weak var tabBar: UITabBar!
////    @IBOutlet weak var colorView: UIView!
////    @IBOutlet weak var collectionView: UICollectionView!
////    override func viewDidLoad() {
////        super.viewDidLoad()
////        print(selectedPalette)
////        colorTitle.text = selectedPalette?.name
////        colorView.backgroundColor = UIColor(hex: selectedPalette?.colors.first ?? "#FFFFFF")
////        tabBar.delegate = self  // Set the delegate
////        if selectedPalette?.colors.count ?? 0 > 0 {
////            let indexPath = IndexPath(item: 0, section: 0)
////            selectedIndexPath = indexPath
////            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .left)
////            collectionView(self.collectionView, didSelectItemAt: indexPath)
////        }
////        exitButtonView.layer.cornerRadius = exitButtonView.frame.height / 2
////        exitButtonView.clipsToBounds = true
////        colorView.layer.cornerRadius = exitButtonView.frame.height / 4
////        colorView.clipsToBounds = true
////        collectionView.delegate = self
////        collectionView.dataSource = self
////        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
////                    layout.scrollDirection = .horizontal
////                    layout.estimatedItemSize = .zero
////                    // Optional: Ensure no vertical scrolling by setting content size
////            collectionView.isScrollEnabled = true // Horizontal scrolling only
////            collectionView.showsHorizontalScrollIndicator = false
////            collectionView.showsVerticalScrollIndicator = false
////                }
////        
////        
////    }
////    @IBAction func closeButtonTapped(_ sender: Any) {
////            self.dismiss(animated: true, completion: nil)
////        }
////    // Delegate method to handle tab selection
////    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
////        if item == save {
////            saveButtonTapped()
////        } else if item == adjust {
////            adjustButtonTapped()
////        } else if item == delete {
////            deleteButtonTapped()
////        }
////    else if item == download {
////        downloadButtonTapped()
////    }
////    }
////
////    // Custom actions for each "button"
////    func saveButtonTapped() {
////        print("Home tab tapped!")
////        // Add your logic here (e.g., navigate, update UI)
////    }
////
////    func adjustButtonTapped() {
////        print("Profile tab tapped!")
////        // Add your logic here
////    }
////
////    func deleteButtonTapped() {
////        print("Settings tab tapped!")
////        // Add your logic here
////    }
////    func downloadButtonTapped() {
////        print("Settings tab tapped!")
////        // Add your logic here
////    }
////    func hexToRGBString(_ hex: String) -> String {
////        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
////        
////        // Remove "#" if it exists
////        if hexString.hasPrefix("#") {
////            hexString.remove(at: hexString.startIndex)
////        }
////        
////        // Check if the hex string is valid (6 characters for RGB)
////        guard hexString.count == 6 else { return "(Invalid)" }
////        
////        var rgbValue: UInt64 = 0
////        Scanner(string: hexString).scanHexInt64(&rgbValue)
////        
////        let red = (rgbValue & 0xFF0000) >> 16
////        let green = (rgbValue & 0x00FF00) >> 8
////        let blue = rgbValue & 0x0000FF
////        
////        return "(\(red), \(green), \(blue))"
////    }
////}
//
////
////  SlectedPaletteInExploreVC.swift
////  Color Palette
////
////  Created by mac on 14/03/2025.
////
//
//import UIKit
//
//class SlectedPaletteInExploreVC: UIViewController, UITabBarDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
//    // MARK: - UICollectionViewDataSource
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return selectedPalette?.colors.count ?? 0
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SlectedPaletteCVCell", for: indexPath) as! SlectedPaletteCVCell
//        let color = selectedPalette?.colors[indexPath.row]
//        cell.colorView.backgroundColor = UIColor(hex: color ?? "FFFFFF")
//        cell.hexaCodeLabel.text = color
//        cell.rgbColorLabel.text = hexToRGBString(color ?? "FFFFFF")
//        if indexPath == selectedIndexPath {
//            cell.colorView.layer.borderWidth = 2.0
//            cell.colorView.layer.cornerRadius = 10.0
//            cell.colorView.layer.borderColor = UIColor.black.cgColor
//        } else {
//            cell.colorView.layer.borderWidth = 0.0
//        }
//        return cell
//    }
//    
//    // MARK: - UICollectionViewDelegateFlowLayout
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let collectionViewWidth = collectionView.bounds.width
//        let relativeWidth = collectionViewWidth * 0.25
//        let relativeHeight = relativeWidth * 3
//        return CGSize(width: relativeWidth, height: relativeHeight)
//    }
//    
//    // MARK: - UICollectionViewDelegate
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        // Restore previous cell to normal state
//        if let previousIndexPath = selectedIndexPath,
//           previousIndexPath != indexPath,
//           let previousCell = collectionView.cellForItem(at: previousIndexPath) as? SlectedPaletteCVCell {
//            previousCell.colorView.layer.borderWidth = 0.0
//            previousCell.colorView.layer.borderColor = nil
//        }
//        
//        // Update new selected cell
//        if let cell = collectionView.cellForItem(at: indexPath) as? SlectedPaletteCVCell {
//            cell.colorView.layer.borderWidth = 2.0
//            cell.colorView.layer.cornerRadius = 10.0
//            cell.colorView.layer.borderColor = UIColor.black.cgColor
//            
//            // Update the main color view with the selected color
//            if let color = selectedPalette?.colors[indexPath.row] {
//                colorView.backgroundColor = UIColor(hex: color)
//            }
//        }
//        
//        selectedIndexPath = indexPath
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        if let cell = collectionView.cellForItem(at: indexPath) as? SlectedPaletteCVCell {
//            cell.colorView.layer.borderWidth = 0.0
//            cell.colorView.layer.borderColor = nil
//        }
//    }
//    
//    // MARK: - Properties
//    private var selectedIndexPath: IndexPath?
//    var selectedPalette: ColorPalette?
//    
//    // MARK: - IBOutlets
//    @IBOutlet weak var exitButtonView: UIButton!
//    @IBOutlet weak var save: UITabBarItem!
//    @IBOutlet weak var colorTitle: UILabel!
//    @IBOutlet weak var adjust: UITabBarItem!
//    @IBOutlet weak var delete: UITabBarItem!
//    @IBOutlet weak var download: UITabBarItem!
//    @IBOutlet weak var tabBar: UITabBar!
//    @IBOutlet weak var colorView: UIView!
//    @IBOutlet weak var collectionView: UICollectionView!
//    
//    // MARK: - Lifecycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // Initial setup
//        print(selectedPalette)
//        colorTitle.text = selectedPalette?.name
//        colorView.backgroundColor = UIColor(hex: selectedPalette?.colors.first ?? "#FFFFFF")
//        
//        // Configure UI elements
//        tabBar.delegate = self
//        exitButtonView.layer.cornerRadius = exitButtonView.frame.height / 2
//        exitButtonView.clipsToBounds = true
//        colorView.layer.cornerRadius = exitButtonView.frame.height / 4
//        colorView.clipsToBounds = true
//        
//        // Set up collection view
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
//            layout.scrollDirection = .horizontal
//            layout.estimatedItemSize = .zero
//            collectionView.isScrollEnabled = true
//            collectionView.showsHorizontalScrollIndicator = false
//            collectionView.showsVerticalScrollIndicator = false
//        }
//        
//        // Reload data and select first item if available
//        collectionView.reloadData()
//        if let colors = selectedPalette?.colors, !colors.isEmpty {
//            let indexPath = IndexPath(item: 0, section: 0)
//            selectedIndexPath = indexPath
//            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .left)
//            collectionView(self.collectionView, didSelectItemAt: indexPath)
//        }
//    }
//    
//    // MARK: - IBActions
//    @IBAction func closeButtonTapped(_ sender: Any) {
//        self.dismiss(animated: true, completion: nil)
//    }
//    @IBAction func saveButtonOnTop(_ sender: Any) {
//    }
//    
//    
//    // MARK: - UITabBarDelegate
//    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        if item == save {
//            saveButtonTapped()
//        } else if item == adjust {
//            adjustButtonTapped()
//        } else if item == delete {
//            deleteButtonTapped()
//        } else if item == download {
//            downloadButtonTapped()
//        }
//    }
//    
//    // MARK: - Custom Actions
//    func saveButtonTapped() {
//        print("Home tab tapped!")
//    }
//    
//    func adjustButtonTapped() {
//        print("Profile tab tapped!")
//    }
//    
//    func deleteButtonTapped() {
//        print("Settings tab tapped!")
//    }
//    
//    func downloadButtonTapped() {
//        print("Settings tab tapped!")
//    }
//    
//    // MARK: - Helper Methods
//    func hexToRGBString(_ hex: String) -> String {
//        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
//        if hexString.hasPrefix("#") {
//            hexString.remove(at: hexString.startIndex)
//        }
//        guard hexString.count == 6 else { return "(Invalid)" }
//        var rgbValue: UInt64 = 0
//        Scanner(string: hexString).scanHexInt64(&rgbValue)
//        let red = (rgbValue & 0xFF0000) >> 16
//        let green = (rgbValue & 0x00FF00) >> 8
//        let blue = rgbValue & 0x0000FF
//        return "(\(red), \(green), \(blue))"
//    }
//}
//

//
//  SlectedPaletteInExploreVC.swift
//  Color Palette
//
//  Created by mac on 14/03/2025.
//

import UIKit

class SlectedPaletteInExploreVC: UIViewController, UITabBarDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedPalette?.colors.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SlectedPaletteCVCell", for: indexPath) as! SlectedPaletteCVCell
        let color = selectedPalette?.colors[indexPath.row]
        cell.colorView.backgroundColor = UIColor(hex: color ?? "FFFFFF")
        cell.hexaCodeLabel.text = color
        cell.rgbColorLabel.text = hexToRGBString(color ?? "FFFFFF")
        if indexPath == selectedIndexPath {
            cell.colorView.layer.borderWidth = 2.0
            cell.colorView.layer.cornerRadius = 10.0
            cell.colorView.layer.borderColor = UIColor.black.cgColor
        } else {
            cell.colorView.layer.borderWidth = 0.0
        }
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let relativeWidth = collectionViewWidth * 0.25
        let relativeHeight = relativeWidth * 3
        return CGSize(width: relativeWidth, height: relativeHeight)
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Restore previous cell to normal state
        if let previousIndexPath = selectedIndexPath,
           previousIndexPath != indexPath,
           let previousCell = collectionView.cellForItem(at: previousIndexPath) as? SlectedPaletteCVCell {
            previousCell.colorView.layer.borderWidth = 0.0
            previousCell.colorView.layer.borderColor = nil
        }
        
        // Update new selected cell
        if let cell = collectionView.cellForItem(at: indexPath) as? SlectedPaletteCVCell {
            cell.colorView.layer.borderWidth = 2.0
            cell.colorView.layer.cornerRadius = 10.0
            cell.colorView.layer.borderColor = UIColor.black.cgColor
            
            // Update the main color view with the selected color
            if let color = selectedPalette?.colors[indexPath.row] {
                colorView.backgroundColor = UIColor(hex: color)
            }
        }
        
        selectedIndexPath = indexPath
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? SlectedPaletteCVCell {
            cell.colorView.layer.borderWidth = 0.0
            cell.colorView.layer.borderColor = nil
        }
    }
    
    // MARK: - Properties
    private var selectedIndexPath: IndexPath?
    var selectedPalette: ColorPalette?
    
    // MARK: - IBOutlets
    @IBOutlet weak var exitButtonView: UIButton!
    @IBOutlet weak var save: UITabBarItem!
    @IBOutlet weak var colorTitle: UILabel!
    @IBOutlet weak var adjust: UITabBarItem!
    @IBOutlet weak var delete: UITabBarItem!
    @IBOutlet weak var download: UITabBarItem!
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!

    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initial setup
       
        colorTitle.text = selectedPalette?.name
        colorView.backgroundColor = UIColor(hex: selectedPalette?.colors.first ?? "#FFFFFF")
        
        // Configure UI elements
        tabBar.delegate = self
        exitButtonView.layer.cornerRadius = exitButtonView.frame.height / 2
        exitButtonView.clipsToBounds = true
        colorView.layer.cornerRadius = exitButtonView.frame.height / 4
        colorView.clipsToBounds = true
        
        // Set up collection view
        collectionView.delegate = self
        collectionView.dataSource = self
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.estimatedItemSize = .zero
            collectionView.isScrollEnabled = true
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.showsVerticalScrollIndicator = false
        }
        
        // Reload data and select first item if available
        collectionView.reloadData()
        if let colors = selectedPalette?.colors, !colors.isEmpty {
            let indexPath = IndexPath(item: 0, section: 0)
            selectedIndexPath = indexPath
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .left)
            collectionView(self.collectionView, didSelectItemAt: indexPath)
        }
    }
    
    // MARK: - IBActions
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonOnTop(_ sender: Any) {
        saveSelectedColor()
    }
    
    // MARK: - UITabBarDelegate
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item == save {
            saveButtonTapped()
        } else if item == adjust {
            adjustButtonTapped()
        } else if item == delete {
            deleteButtonTapped()
        } else if item == download {
            downloadButtonTapped()
        }
    }
    
    // MARK: - Custom Actions
    func saveButtonTapped() {
        saveSelectedColor()
    }
    
    func adjustButtonTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let adjustmentVC = storyboard.instantiateViewController(withIdentifier: "SlectedPaletteAdjustment") as? SlectedPaletteAdjustment else {
            print("Error: Could not instantiate SlectedPaletteAdjustment")
            return
        }
        
        if let indexPath = selectedIndexPath, let selectedColor = selectedPalette {
            adjustmentVC.selectedColor = selectedColor
        }
        adjustmentVC.modalPresentationStyle = .fullScreen
        present(adjustmentVC, animated: true, completion: nil)
        // Alternative: navigationController?.pushViewController(adjustmentVC, animated: true)
    }
    
    func deleteButtonTapped() {
        print("Settings tab tapped!")
    }
    
    func downloadButtonTapped() {
        print("Download tab tapped!")
    }
    
    // MARK: - Helper Methods
    private func saveSelectedColor() {
        guard let indexPath = selectedIndexPath,
              let hexCode = selectedPalette?.colors[indexPath.row] else {
            showToast(message: "No color selected!")
            return
        }
        
        // Check if the color is already saved using CoreDataManager
        if CoreDataManager.shared.isSingleColorSaved(name: hexCode) {
            // Show feedback if already saved
            showToast(message: "Color already saved!")
        } else {
            // Save the color if not already saved
            CoreDataManager.shared.saveSingleColor(name: hexCode)
            // Show feedback for successful save
            showToast(message: "Color saved!")
        }
    }
    
    func hexToRGBString(_ hex: String) -> String {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }
        guard hexString.count == 6 else { return "(Invalid)" }
        var rgbValue: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgbValue)
        let red = (rgbValue & 0xFF0000) >> 16
        let green = (rgbValue & 0x00FF00) >> 8
        let blue = rgbValue & 0x0000FF
        return "(\(red), \(green), \(blue))"
    }
    
    func showToast(message: String, duration: TimeInterval = 2.0) {
        let toastLabel = UILabel()
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center
        toastLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        toastLabel.text = message
        toastLabel.alpha = 0.0
        toastLabel.numberOfLines = 0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        
        // Set dynamic width based on text and padding
        let maxWidth = self.view.frame.size.width * 0.7
        let textSize = toastLabel.sizeThatFits(CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude))
        toastLabel.frame = CGRect(x: 0, y: 0, width: textSize.width + 40, height: textSize.height + 20)
        toastLabel.center = self.view.center
        
        self.view.addSubview(toastLabel)
        
        // Animate fade-in and fade-out
        UIView.animate(withDuration: 0.5, animations: {
            toastLabel.alpha = 1.0
        }) { _ in
            UIView.animate(withDuration: 0.5, delay: duration, options: .curveEaseOut, animations: {
                toastLabel.alpha = 0.0
            }) { _ in
                toastLabel.removeFromSuperview()
            }
        }
    }
}


