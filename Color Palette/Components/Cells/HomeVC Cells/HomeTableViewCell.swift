////
////
////import UIKit
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
////    
////    override func awakeFromNib() {
////        super.awakeFromNib()
////        collectionView.dataSource = self
////        collectionView.delegate = self
////        collectionView.isScrollEnabled = false
////        NotificationCenter.default.addObserver(
////            self,
////            selector: #selector(clipboardDidChange),
////            name: UIPasteboard.changedNotification,
////            object: nil
////        )
////    }
////    
////    deinit {
////        NotificationCenter.default.removeObserver(self)
////    }
////    
////    @objc func clipboardDidChange() {
////        DispatchQueue.main.async {
////            self.collectionView.reloadData()
////        }
////    }
////
////    @IBAction func saveNamedColorsToCoreData(_ sender: UIButton) {
////        buttonAction?()
////    }
////    
////    func configureCell(with colorPalettes: [String]) {
////        self.colorPalettes = colorPalettes
////        collectionView.reloadData()
////    }
////
////    // UICollectionViewDataSource Methods
////    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
////        return colorPalettes?.count ?? 0
////    }
////    
////    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
////        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
////        let colorName = colorPalettes?[indexPath.row] ?? "#FFFFFF"
////        let backgroundColor = UIColor(hexString: colorName)
////        let textColor = backgroundColor.adjustedBrightness()
////        cell.colorCodeInBottomCenterInCollectionViewCell.text = colorName
////        cell.colorCodeInBottomCenterInCollectionViewCell.textColor = textColor
////        cell.ellipsisButtonInCollectionViewCell.tintColor = textColor
////        cell.backgroundColor = backgroundColor
////       
////        let isSaved = CoreDataManager.shared.isSingleColorSaved(name: colorName)
////        
////        let isCopied = UIPasteboard.general.string == colorName
////        
////        let favAction = UIAction(title: "Fav", image: UIImage(systemName: isSaved ? "heart.fill" : "heart")) { [weak self] _ in
////            print("before the guard")
////            guard let self = self else { return }
////            print("after the guard")
////            if isSaved {
////                let alert = UIAlertController(
////                    title: "Unsave Color",
////                    message: "Do you want to unsave this color?",
////                    preferredStyle: .alert
////                )
////                let unsaveAction = UIAlertAction(title: "Yes", style: .destructive) { _ in
////                    CoreDataManager.shared.deleteSingleColor(name: colorName)
////                    DispatchQueue.main.async {
////                        self.collectionView.reloadData()
////                    }
////                }
////                let cancelAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
////                alert.addAction(unsaveAction)
////                alert.addAction(cancelAction)
////                if let rootVC = self.window?.rootViewController {
////                    rootVC.present(alert, animated: true, completion: nil)
////                }
////            } else {
////                CoreDataManager.shared.saveSingleColor(name: colorName)
////                DispatchQueue.main.async {
////                    self.collectionView.reloadData()
////                }
////            }
////        }
////      
////        let lockAction = UIAction(title: "Lock", image: UIImage(systemName: "lock")) { _ in
////            print("Lock tapped for \(colorName)")
////        }
////        
////        let copyAction = UIAction(title: "Copy", image: UIImage(systemName: isCopied ? "doc.on.doc.fill" : "doc.on.doc")) { [weak self] _ in
////            guard let self = self else { return }
////            UIPasteboard.general.string = colorName
////            
////            DispatchQueue.main.async {
////                
////                self.collectionView.reloadData() // Reload all cells to update "Copy" icons
////            }
////        }
////        
////        let shareAction = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { _ in
////            let activityVC = UIActivityViewController(activityItems: [colorName], applicationActivities: nil)
////            if let viewController = collectionView.window?.rootViewController {
////                viewController.present(activityVC, animated: true)
////            }
////        }
////        
////        cell.ellipsisButtonInCollectionViewCell.menu = UIMenu(children: [favAction, lockAction, copyAction, shareAction])
////        cell.ellipsisButtonInCollectionViewCell.showsMenuAsPrimaryAction = true
////       
////        return cell
////    }
////
////    // Set Collection View Cell Size
////    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
////        return CGSize(width: collectionView.frame.size.width / 5, height: (collectionView.frame.size.height / 2) - 2.5)
////    }
////    
////    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
////        return 5
////    }
////    
////    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
////        return 0
////    }
////    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
////        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) // No extra padding
////    }
////}
//import UIKit
//
//class HomeTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
//    @IBOutlet weak var underLine: UIView!
//    
//    // Unique identifier to distinguish this cell instance
//    private let cellID = UUID()
//    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        collectionView.dataSource = self
//        collectionView.delegate = self
//        collectionView.isScrollEnabled = false
//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(clipboardDidChange(_:)),
//            name: UIPasteboard.changedNotification,
//            object: nil
//        )
//        // Add observer for Core Data changes if needed
//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(coreDataDidChange(_:)),
//            name: CoreDataManager.paletteDidChangeNotification, // Assuming this exists
//            object: nil
//        )
//    }
//    
//    deinit {
//        NotificationCenter.default.removeObserver(self)
//    }
//    
//    @objc func clipboardDidChange(_ notification: Notification) {
//        DispatchQueue.main.async { [weak self] in
//            guard let self = self, let colorPalettes = self.colorPalettes else { return }
//            let clipboardString = UIPasteboard.general.string ?? ""
//            let affectedIndices = colorPalettes.enumerated()
//                .filter { $1 == clipboardString }
//                .map { IndexPath(item: $0.offset, section: 0) }
//            if !affectedIndices.isEmpty {
//                self.collectionView.reloadItems(at: affectedIndices)
//            }
//        }
//    }
//    
//    @objc func coreDataDidChange(_ notification: Notification) {
//        DispatchQueue.main.async { [weak self] in
//            guard let self = self else { return }
//            self.collectionView.reloadData() // Full reload for simplicity; refine if needed
//        }
//    }
//
//    @IBAction func saveNamedColorsToCoreData(_ sender: UIButton) {
//        buttonAction?()
//    }
//    
//    func configureCell(with colorPalettes: [String]) {
//        self.colorPalettes = colorPalettes
//        collectionView.reloadData()
//    }
//
//    // UICollectionViewDataSource Methods
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return colorPalettes?.count ?? 0
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
//        guard let colorName = colorPalettes?[indexPath.row] else { return cell }
//        
//        let backgroundColor = UIColor(hexString: colorName)
//        let textColor = backgroundColor.adjustedBrightness()
//        cell.colorCodeInBottomCenterInCollectionViewCell.text = colorName
//        cell.colorCodeInBottomCenterInCollectionViewCell.textColor = textColor
//        cell.ellipsisButtonInCollectionViewCell.tintColor = textColor
//        cell.backgroundColor = backgroundColor
//       
//        let isSaved = CoreDataManager.shared.isSingleColorSaved(name: colorName)
//        let isCopied = UIPasteboard.general.string == colorName
//        
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
//                    // Post notification with context to target this specific cell
//                    NotificationCenter.default.post(
//                        name: CoreDataManager.paletteDidChangeNotification,
//                        object: nil,
//                        userInfo: ["cellID": self.cellID, "indexPath": indexPath]
//                    )
//                }
//                let cancelAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
//                alert.addAction(unsaveAction)
//                alert.addAction(cancelAction)
//                if let rootVC = self.window?.rootViewController {
//                    rootVC.present(alert, animated: true, completion: nil)
//                }
//            } else {
//                CoreDataManager.shared.saveSingleColor(name: colorName)
//                // Post notification with context
//                NotificationCenter.default.post(
//                    name: CoreDataManager.paletteDidChangeNotification,
//                    object: nil,
//                    userInfo: ["cellID": self.cellID, "indexPath": indexPath]
//                )
//            }
//        }
//      
//        let lockAction = UIAction(title: "Lock", image: UIImage(systemName: "lock")) { _ in
//            print("Lock tapped for \(colorName)")
//        }
//        
//        let copyAction = UIAction(title: "Copy", image: UIImage(systemName: isCopied ? "doc.on.doc.fill" : "doc.on.doc")) { [weak self] _ in
//            guard let self = self else { return }
//            UIPasteboard.general.string = colorName
//            // Clipboard change will trigger clipboardDidChange; no immediate reload here
//        }
//        
//        let shareAction = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { _ in
//            let activityVC = UIActivityViewController(activityItems: [colorName], applicationActivities: nil)
//            if let viewController = collectionView.window?.rootViewController {
//                viewController.present(activityVC, animated: true)
//            }
//        }
//        
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
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//    }
//}

import UIKit

class HomeTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var colorPalettes: [String]?
    var buttonAction: (() -> Void)?
    
    @IBOutlet weak var colorSideBarContainer: UIView!
    @IBOutlet weak var heartButtonInTopView: UIButton!
    @IBOutlet weak var colorTitleInTopView: UILabel!
    @IBOutlet weak var ellipsisButtonInColorSideBar: UIButton!
    @IBOutlet weak var hexaCodeInColorSideBar: UILabel!
    @IBOutlet weak var colorTitleInColorSideBar: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var underLine: UIView!
    
    private var tableIndexPath: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isScrollEnabled = false
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(clipboardDidChange(_:)),
            name: UIPasteboard.changedNotification,
            object: nil
        )
        // Ensure ellipsis button is tappable
        ellipsisButtonInColorSideBar.isUserInteractionEnabled = true
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func clipboardDidChange(_ notification: Notification) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self, let colorPalettes = self.colorPalettes else { return }
            let clipboardString = UIPasteboard.general.string ?? ""
            let affectedIndices = colorPalettes.enumerated()
                .filter { $1 == clipboardString }
                .map { IndexPath(item: $0.offset, section: 0) }
            if !affectedIndices.isEmpty {
                self.collectionView.reloadItems(at: affectedIndices)
            }
        }
    }

    @IBAction func saveNamedColorsToCoreData(_ sender: UIButton) {
        buttonAction?()
    }
    
    func configureCell(with colorPalettes: [String], tableIndexPath: IndexPath? = nil) {
        self.colorPalettes = colorPalettes
        self.tableIndexPath = tableIndexPath
        collectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorPalettes?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        guard let colorName = colorPalettes?[indexPath.row] else { return cell }
        
        let backgroundColor = UIColor(hexString: colorName)
        let textColor = backgroundColor.adjustedBrightness()
        cell.colorCodeInBottomCenterInCollectionViewCell.text = colorName
        cell.colorCodeInBottomCenterInCollectionViewCell.textColor = textColor
        cell.ellipsisButtonInCollectionViewCell.tintColor = textColor
        cell.backgroundColor = backgroundColor
       
        let isSaved = CoreDataManager.shared.isSingleColorSaved(name: colorName)
        let isCopied = UIPasteboard.general.string == colorName
        
        let favAction = UIAction(title: "Fav", image: UIImage(systemName: isSaved ? "heart.fill" : "heart")) { [weak self] _ in
            guard let self = self, let tableIndexPath = self.tableIndexPath else { return }
            print("Fav tapped for \(colorName) at \(indexPath)") // Debug log
            if isSaved {
                let alert = UIAlertController(
                    title: "Unsave Color",
                    message: "Do you want to unsave this color?",
                    preferredStyle: .alert
                )
                let unsaveAction = UIAlertAction(title: "Yes", style: .destructive) { _ in
                    CoreDataManager.shared.deleteSingleColor(name: colorName)
                    NotificationCenter.default.post(
                        name: CoreDataManager.paletteDidChangeNotification,
                        object: nil,
                        userInfo: ["tableIndexPath": tableIndexPath, "collectionIndexPath": indexPath]
                    )
                }
                let cancelAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
                alert.addAction(unsaveAction)
                alert.addAction(cancelAction)
                if let rootVC = self.window?.rootViewController {
                    rootVC.present(alert, animated: true, completion: nil)
                }
            } else {
                CoreDataManager.shared.saveSingleColor(name: colorName)
                NotificationCenter.default.post(
                    name: CoreDataManager.paletteDidChangeNotification,
                    object: nil,
                    userInfo: ["tableIndexPath": tableIndexPath, "collectionIndexPath": indexPath]
                )
            }
        }
      
        let lockAction = UIAction(title: "Lock", image: UIImage(systemName: "lock")) { _ in
            print("Lock tapped for \(colorName)") // Debug log
        }
        
        let copyAction = UIAction(title: "Copy", image: UIImage(systemName: isCopied ? "doc.on.doc.fill" : "doc.on.doc")) { [weak self] _ in
            guard let self = self else { return }
            print("Copy tapped for \(colorName)") // Debug log
            UIPasteboard.general.string = colorName
        }
        
        let shareAction = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { _ in
            print("Share tapped for \(colorName)") // Debug log
            let activityVC = UIActivityViewController(activityItems: [colorName], applicationActivities: nil)
            if let viewController = collectionView.window?.rootViewController {
                viewController.present(activityVC, animated: true)
            }
        }
        
        let menu = UIMenu(title: "", children: [favAction, lockAction, copyAction, shareAction])
        cell.ellipsisButtonInCollectionViewCell.menu = menu
        cell.ellipsisButtonInCollectionViewCell.showsMenuAsPrimaryAction = true
        cell.ellipsisButtonInCollectionViewCell.isUserInteractionEnabled = true // Ensure tappable
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 5, height: (collectionView.frame.size.height / 2) - 2.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
