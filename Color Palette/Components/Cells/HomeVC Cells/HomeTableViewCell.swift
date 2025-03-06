////
////import UIKit
////
////
////class HomeTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
////
////    var colorPalettes: [String]?
////    var buttonAction: (() -> Void)?
////
////    // TopView
////    @IBOutlet weak var colorSideBarContainer: UIView!
////    @IBOutlet weak var heartButtonInTopView: UIButton!
////    @IBOutlet weak var colorTitleInTopView: UILabel!
////    // SideBar
////    @IBOutlet weak var ellipsisButtonInColorSideBar: UIButton!
////    @IBOutlet weak var hexaCodeInColorSideBar: UILabel!
////    @IBOutlet weak var colorTitleInColorSideBar: UILabel!
////    // Collection View
////    @IBOutlet weak var collectionView: UICollectionView!
////
////    @IBOutlet weak var underLine: UIView!
////    override func awakeFromNib() {
////        super.awakeFromNib()
////        collectionView.dataSource = self
////        collectionView.delegate = self
////        collectionView.isScrollEnabled = false
////      
////    }
////
////    @IBAction func saveNamedColorsToCoreData(_ sender: UIButton) {
////        buttonAction?()
////        
////    }
////    
////    // Set the color palettes data for the collection view
////    func configureCell(with colorPalettes: [String]) {
////        self.colorPalettes = colorPalettes
////        collectionView.reloadData() // Refresh collection view
////        
////    }
////
////    // UICollectionViewDataSource Methods
////    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
////        return colorPalettes?.count ?? 0
////    }
////    
////    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
////        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
////        let colorName = colorPalettes?[indexPath.row]
////        let backgroundColor = UIColor(hexString: colorName ??  "#FFFFFF")
////        let textColor = backgroundColor.adjustedBrightness()
////        cell.colorCodeInBottomCenterInCollectionViewCell.text = colorName
////        cell.colorCodeInBottomCenterInCollectionViewCell.textColor = textColor
////        cell.ellipsisButtonInCollectionViewCell.tintColor = textColor
////        cell.backgroundColor = backgroundColor
////        // Define UIActions with images from Assets
////        let favAction = UIAction(title: "Fav", image: UIImage(systemName: "heart")) { _ in
////            print("Fav tapped for \(colorName)")
////        }
////        
////        let lockAction = UIAction(title: "Lock", image: UIImage(systemName: "lock")) { _ in
////            print("Lock tapped for \(colorName)")
////        }
////        
////        let copyAction = UIAction(title: "Copy", image: UIImage(systemName: "doc.on.doc")) { _ in
////            UIPasteboard.general.string = colorName
////            print("Copied \(colorName)")
////        }
////        
////        let shareAction = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { _ in
////            let activityVC = UIActivityViewController(activityItems: [colorName], applicationActivities: nil)
////            if let viewController = collectionView.window?.rootViewController {
////                viewController.present(activityVC, animated: true)
////                
////            }
////        }
////        
////        // Assign the menu to the button
////        cell.ellipsisButtonInCollectionViewCell.menu = UIMenu(children: [favAction, lockAction, copyAction, shareAction])
////        cell.ellipsisButtonInCollectionViewCell.showsMenuAsPrimaryAction = true
////       
////        return cell
////    }
////
////    // Set Collection View Cell Size
////    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
////        return CGSize(width: collectionView.frame.size.width / 5, height: (collectionView.frame.size.height / 2)-2.5)
////    }
////    
////    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
////        return 5
////        
////    }
////    
////    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
////        return 0
////        
////    }
////}
////
////
////
////
////
//import UIKit
//
//class HomeTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//
//    var colorPalettes: [String]?
//    var buttonAction: (() -> Void)?
//
//    // TopView
//    @IBOutlet weak var colorSideBarContainer: UIView!
//    @IBOutlet weak var heartButtonInTopView: UIButton!
//    @IBOutlet weak var colorTitleInTopView: UILabel!
//    // SideBar
//    @IBOutlet weak var ellipsisButtonInColorSideBar: UIButton!
//    @IBOutlet weak var hexaCodeInColorSideBar: UILabel!
//    @IBOutlet weak var colorTitleInColorSideBar: UILabel!
//    // Collection View
//    @IBOutlet weak var collectionView: UICollectionView!
//
//    @IBOutlet weak var underLine: UIView!
//    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        collectionView.dataSource = self
//        collectionView.delegate = self
//        collectionView.isScrollEnabled = false
//    }
//
//    @IBAction func saveNamedColorsToCoreData(_ sender: UIButton) {
//        buttonAction?()
//    }
//    
//    // Set the color palettes data for the collection view
//    func configureCell(with colorPalettes: [String]) {
//        self.colorPalettes = colorPalettes
//        collectionView.reloadData() // Refresh collection view
//    }
//
//    // UICollectionViewDataSource Methods
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return colorPalettes?.count ?? 0
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
//        let colorName = colorPalettes?[indexPath.row] ?? "#FFFFFF"
//        let backgroundColor = UIColor(hexString: colorName)
//        let textColor = backgroundColor.adjustedBrightness()
//        cell.colorCodeInBottomCenterInCollectionViewCell.text = colorName
//        cell.colorCodeInBottomCenterInCollectionViewCell.textColor = textColor
//        cell.ellipsisButtonInCollectionViewCell.tintColor = textColor
//        cell.backgroundColor = backgroundColor
//        
//        // Check if the color is saved in SingleColor
//        let isSaved = CoreDataManager.shared.isSingleColorSaved(name: colorName)
//        
//        // Updated favAction with SingleColor save/delete logic
//        let favAction = UIAction(title: "Fav", image: UIImage(systemName: isSaved ? "heart.fill" : "heart")) { [weak self] _ in
//            guard let self = self else { return }
//            if isSaved {
//                let alert = UIAlertController(
//                    title: "Unsave Color",
//                    message: "Do you want to unsave this color?",
//                    preferredStyle: .alert
//                )
//                let unsaveAction = UIAlertAction(title: "Yes", style: .destructive) { _ in
//                    CoreDataManager.shared.deleteSingleColor(name: colorName)
//                    DispatchQueue.main.async {
//                        // Update the cell's menu
//                        if let updatedCell = self.collectionView.cellForItem(at: indexPath) as? HomeCollectionViewCell {
//                            updatedCell.ellipsisButtonInCollectionViewCell.menu = self.createMenu(for: colorName, at: indexPath)
//                        }
//                    }
//                }
//                let cancelAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
//                alert.addAction(unsaveAction)
//                alert.addAction(cancelAction)
//                
//                // Present the alert from the root view controller
//                if let rootVC = self.window?.rootViewController {
//                    rootVC.present(alert, animated: true, completion: nil)
//                }
//            } else {
//                CoreDataManager.shared.saveSingleColor(name: colorName)
//                DispatchQueue.main.async {
//                    // Update the cell's menu
//                    if let updatedCell = self.collectionView.cellForItem(at: indexPath) as? HomeCollectionViewCell {
//                        updatedCell.ellipsisButtonInCollectionViewCell.menu = self.createMenu(for: colorName, at: indexPath)
//                    }
//                }
//            }
//        }
//        // Disable the action if already saved to prevent duplicates
//        favAction.attributes = isSaved ? .disabled : []
//        
//        let lockAction = UIAction(title: "Lock", image: UIImage(systemName: "lock")) { _ in
//            print("Lock tapped for \(colorName)")
//        }
//        
//        let copyAction = UIAction(title: "Copy", image: UIImage(systemName: "doc.on.doc")) { _ in
//            UIPasteboard.general.string = colorName
//            print("Copied \(colorName)")
//        }
//        
//        let shareAction = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { _ in
//            let activityVC = UIActivityViewController(activityItems: [colorName], applicationActivities: nil)
//            if let viewController = collectionView.window?.rootViewController {
//                viewController.present(activityVC, animated: true)
//            }
//        }
//        
//        // Assign the menu to the button
//        cell.ellipsisButtonInCollectionViewCell.menu = UIMenu(children: [favAction, lockAction, copyAction, shareAction])
//        cell.ellipsisButtonInCollectionViewCell.showsMenuAsPrimaryAction = true
//       
//        return cell
//    }
//
//    // Helper method to create the menu dynamically
//    private func createMenu(for colorName: String, at indexPath: IndexPath) -> UIMenu {
//        let isSaved = CoreDataManager.shared.isSingleColorSaved(name: colorName)
//        let favAction = UIAction(title: "Fav", image: UIImage(systemName: isSaved ? "heart.fill" : "heart")) { [weak self] _ in
//            guard let self = self else { return }
//            if isSaved {
//                let alert = UIAlertController(
//                    title: "Unsave Color",
//                    message: "Do you want to unsave this color?",
//                    preferredStyle: .alert
//                )
//                let unsaveAction = UIAlertAction(title: "Yes", style: .destructive) { _ in
//                    CoreDataManager.shared.deleteSingleColor(name: colorName)
//                    DispatchQueue.main.async {
//                        if let updatedCell = self.collectionView.cellForItem(at: indexPath) as? HomeCollectionViewCell {
//                            updatedCell.ellipsisButtonInCollectionViewCell.menu = self.createMenu(for: colorName, at: indexPath)
//                        }
//                    }
//                }
//                let cancelAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
//                alert.addAction(unsaveAction)
//                alert.addAction(cancelAction)
//                if let rootVC = self.window?.rootViewController {
//                    rootVC.present(alert, animated: true, completion: nil)
//                }
//            } else {
//                CoreDataManager.shared.saveSingleColor(name: colorName)
//                DispatchQueue.main.async {
//                    if let updatedCell = self.collectionView.cellForItem(at: indexPath) as? HomeCollectionViewCell {
//                        updatedCell.ellipsisButtonInCollectionViewCell.menu = self.createMenu(for: colorName, at: indexPath)
//                    }
//                }
//            }
//        }
//        favAction.attributes = isSaved ? .disabled : []
//        
//        let lockAction = UIAction(title: "Lock", image: UIImage(systemName: "lock")) { _ in
//            print("Lock tapped for \(colorName)")
//        }
//        let copyAction = UIAction(title: "Copy", image: UIImage(systemName: "doc.on.doc")) { _ in
//            UIPasteboard.general.string = colorName
//            print("Copied \(colorName)")
//        }
//        let shareAction = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { _ in
//            let activityVC = UIActivityViewController(activityItems: [colorName], applicationActivities: nil)
//            if let viewController = self.collectionView.window?.rootViewController {
//                viewController.present(activityVC, animated: true)
//            }
//        }
//        
//        return UIMenu(children: [favAction, lockAction, copyAction, shareAction])
//    }
//
//    // Set Collection View Cell Size
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: collectionView.frame.size.width / 5, height: (collectionView.frame.size.height / 2) - 2.5)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 5
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//}
//
//import UIKit
//
//class HomeTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//
//    var colorPalettes: [String]?
//    var buttonAction: (() -> Void)?
//
//    // TopView
//    @IBOutlet weak var colorSideBarContainer: UIView!
//    @IBOutlet weak var heartButtonInTopView: UIButton!
//    @IBOutlet weak var colorTitleInTopView: UILabel!
//    // SideBar
//    @IBOutlet weak var ellipsisButtonInColorSideBar: UIButton!
//    @IBOutlet weak var hexaCodeInColorSideBar: UILabel!
//    @IBOutlet weak var colorTitleInColorSideBar: UILabel!
//    // Collection View
//    @IBOutlet weak var collectionView: UICollectionView!
//
//    @IBOutlet weak var underLine: UIView!
//    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        collectionView.dataSource = self
//        collectionView.delegate = self
//        collectionView.isScrollEnabled = false
//        
//        // Register for clipboard change notifications (optional, if system clipboard changes matter)
//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(clipboardDidChange),
//            name: UIPasteboard.changedNotification,
//            object: nil
//        )
//    }
//    
//    deinit {
//        NotificationCenter.default.removeObserver(self)
//    }
//    
//    @objc func clipboardDidChange() {
//        DispatchQueue.main.async {
//            self.collectionView.reloadData()
//        }
//    }
//
//    @IBAction func saveNamedColorsToCoreData(_ sender: UIButton) {
//        buttonAction?()
//    }
//    
//    // Set the color palettes data for the collection view
//    func configureCell(with colorPalettes: [String]) {
//        self.colorPalettes = colorPalettes
//        collectionView.reloadData() // Refresh collection view
//    }
//
//    // UICollectionViewDataSource Methods
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return colorPalettes?.count ?? 0
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
//        let colorName = colorPalettes?[indexPath.row] ?? "#FFFFFF"
//        let backgroundColor = UIColor(hexString: colorName)
//        let textColor = backgroundColor.adjustedBrightness()
//        cell.colorCodeInBottomCenterInCollectionViewCell.text = colorName
//        cell.colorCodeInBottomCenterInCollectionViewCell.textColor = textColor
//        cell.ellipsisButtonInCollectionViewCell.tintColor = textColor
//        cell.backgroundColor = backgroundColor
//        
//        // Check if the color is saved in SingleColor
//        let isSaved = CoreDataManager.shared.isSingleColorSaved(name: colorName)
//        
//        // Check if the color is currently in the clipboard
//        let isCopied = UIPasteboard.general.string == colorName
//        
//        // Updated favAction
//        let favAction = UIAction(title: "Fav", image: UIImage(systemName: isSaved ? "heart.fill" : "heart")) { [weak self] _ in
//            guard let self = self else { return }
//            if isSaved {
//                let alert = UIAlertController(
//                    title: "Unsave Color",
//                    message: "Do you want to unsave this color?",
//                    preferredStyle: .alert
//                )
//                let unsaveAction = UIAlertAction(title: "Yes", style: .destructive) { _ in
//                    CoreDataManager.shared.deleteSingleColor(name: colorName)
//                    DispatchQueue.main.async {
//                        self.collectionView.reloadData() // Reload all cells
//                    }
//                }
//                let cancelAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
//                alert.addAction(unsaveAction)
//                alert.addAction(cancelAction)
//                if let rootVC = self.window?.rootViewController {
//                    rootVC.present(alert, animated: true, completion: nil)
//                }
//            } else {
//                CoreDataManager.shared.saveSingleColor(name: colorName)
//                DispatchQueue.main.async {
//                    self.collectionView.reloadData() // Reload all cells
//                }
//            }
//        }
//        favAction.attributes = isSaved ? .disabled : []
//        
//        let lockAction = UIAction(title: "Lock", image: UIImage(systemName: "lock")) { _ in
//            print("Lock tapped for \(colorName)")
//        }
//        
//        // Updated copyAction with clipboard check
//        let copyAction = UIAction(title: "Copy", image: UIImage(systemName: isCopied ? "doc.on.doc.fill" : "doc.on.doc")) { [weak self] _ in
//            guard let self = self else { return }
//            UIPasteboard.general.string = colorName
//            print("Copied \(colorName)")
//            DispatchQueue.main.async {
//                self.collectionView.reloadData() // Reload all cells to update all "Copy" icons
//            }
//        }
//        
//        let shareAction = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { _ in
//            let activityVC = UIActivityViewController(activityItems: [colorName], applicationActivities: nil)
//            if let viewController = collectionView.window?.rootViewController {
//                viewController.present(activityVC, animated: true)
//            }
//        }
//        
//        // Assign the menu to the button
//        cell.ellipsisButtonInCollectionViewCell.menu = UIMenu(children: [favAction, lockAction, copyAction, shareAction])
//        cell.ellipsisButtonInCollectionViewCell.showsMenuAsPrimaryAction = true
//       
//        return cell
//    }
//
//    // Set Collection View Cell Size
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: collectionView.frame.size.width / 5, height: (collectionView.frame.size.height / 2) - 2.5)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 5
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//}
//

import UIKit

class HomeTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var colorPalettes: [String]?
    var buttonAction: (() -> Void)?

    // TopView
    @IBOutlet weak var colorSideBarContainer: UIView!
    @IBOutlet weak var heartButtonInTopView: UIButton!
    @IBOutlet weak var colorTitleInTopView: UILabel!
    // SideBar
    @IBOutlet weak var ellipsisButtonInColorSideBar: UIButton!
    @IBOutlet weak var hexaCodeInColorSideBar: UILabel!
    @IBOutlet weak var colorTitleInColorSideBar: UILabel!
    // Collection View
    @IBOutlet weak var collectionView: UICollectionView!

    @IBOutlet weak var underLine: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isScrollEnabled = false
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(clipboardDidChange),
            name: UIPasteboard.changedNotification,
            object: nil
        )
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func clipboardDidChange() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

    @IBAction func saveNamedColorsToCoreData(_ sender: UIButton) {
        buttonAction?()
    }
    
    func configureCell(with colorPalettes: [String]) {
        self.colorPalettes = colorPalettes
        collectionView.reloadData()
    }

    // UICollectionViewDataSource Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorPalettes?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        let colorName = colorPalettes?[indexPath.row] ?? "#FFFFFF"
        let backgroundColor = UIColor(hexString: colorName)
        let textColor = backgroundColor.adjustedBrightness()
        cell.colorCodeInBottomCenterInCollectionViewCell.text = colorName
        cell.colorCodeInBottomCenterInCollectionViewCell.textColor = textColor
        cell.ellipsisButtonInCollectionViewCell.tintColor = textColor
        cell.backgroundColor = backgroundColor
        
        let isSaved = CoreDataManager.shared.isSingleColorSaved(name: colorName)
        let isCopied = UIPasteboard.general.string == colorName
        
        let favAction = UIAction(title: "Fav", image: UIImage(systemName: isSaved ? "heart.fill" : "heart")) { [weak self] _ in
            guard let self = self else { return }
            if isSaved {
                let alert = UIAlertController(
                    title: "Unsave Color",
                    message: "Do you want to unsave this color?",
                    preferredStyle: .alert
                )
                let unsaveAction = UIAlertAction(title: "Yes", style: .destructive) { _ in
                    CoreDataManager.shared.deleteSingleColor(name: colorName)
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
                let cancelAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
                alert.addAction(unsaveAction)
                alert.addAction(cancelAction)
                if let rootVC = self.window?.rootViewController {
                    rootVC.present(alert, animated: true, completion: nil)
                }
            } else {
                CoreDataManager.shared.saveSingleColor(name: colorName)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
        favAction.attributes = isSaved ? .disabled : []
        
        let lockAction = UIAction(title: "Lock", image: UIImage(systemName: "lock")) { _ in
            print("Lock tapped for \(colorName)")
        }
        
        let copyAction = UIAction(title: "Copy", image: UIImage(systemName: isCopied ? "doc.on.doc.fill" : "doc.on.doc")) { [weak self] _ in
            guard let self = self else { return }
            UIPasteboard.general.string = colorName
            print("Copied \(colorName)")
            DispatchQueue.main.async {
                self.collectionView.reloadData() // Reload all cells to update "Copy" icons
            }
        }
        
        let shareAction = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { _ in
            let activityVC = UIActivityViewController(activityItems: [colorName], applicationActivities: nil)
            if let viewController = collectionView.window?.rootViewController {
                viewController.present(activityVC, animated: true)
            }
        }
        
        cell.ellipsisButtonInCollectionViewCell.menu = UIMenu(children: [favAction, lockAction, copyAction, shareAction])
        cell.ellipsisButtonInCollectionViewCell.showsMenuAsPrimaryAction = true
       
        return cell
    }

    // Set Collection View Cell Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 5, height: (collectionView.frame.size.height / 2) - 2.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
