//
//
//import UIKit
//
//class TopTableViewCellInCollectionVC: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    
//    var colorPalettes: [String]?
//    var buttonAction: (() -> Void)?
//    private var copiedColor: String? // Track which color was copied
//
//    // TopView
//    @IBOutlet weak var colorSideBarContainer: UIView!
//    @IBOutlet weak var heartButtonInTopView: UIButton!
//    @IBOutlet weak var colorTitleInTopView: UILabel!
//    // SideBar
//    @IBOutlet weak var ellipsisButtonInColorSideBar: UIButton!
//    @IBOutlet weak var hexaCodeInColorSideBar: UILabel!
//    @IBOutlet weak var colorTitleInColorSideBar: UILabel!
//    @IBOutlet weak var underLine: UIView!
//    @IBOutlet weak var topCollectionviewInCollectionVC: UICollectionView!
//    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        topCollectionviewInCollectionVC.dataSource = self
//        topCollectionviewInCollectionVC.delegate = self
//        topCollectionviewInCollectionVC.isScrollEnabled = false
//        
//        // Add long press gesture recognizer
//        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
//        topCollectionviewInCollectionVC.addGestureRecognizer(longPressGesture)
//    }
//    
//    @IBAction func heartButtonTapped(_ sender: UIButton) {
//        buttonAction?()
//    }
//    
//    func configureCell(with colorPalettes: [String]) {
//        self.colorPalettes = colorPalettes
//        topCollectionviewInCollectionVC.reloadData()
//    }
//    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }
//    
//    @objc func handleLongPress(gesture: UILongPressGestureRecognizer) {
//        if gesture.state == .began {
//            let point = gesture.location(in: topCollectionviewInCollectionVC)
//            
//            if let indexPath = topCollectionviewInCollectionVC.indexPathForItem(at: point),
//               let cell = topCollectionviewInCollectionVC.cellForItem(at: indexPath) as? TopCollectionViewCellInCollectionVC {
//                
//                let colorName = colorPalettes?[indexPath.row] ?? "#FFFFFF"
//                let isCopied = colorName == copiedColor
//                
//                // Create UIAction items
//                let lockAction = UIAction(title: "Lock", image: UIImage(systemName: "lock")) { _ in
//                    print("Lock tapped for \(colorName)")
//                    // Add your lock logic here
//                }
//                
//                let copyAction = UIAction(
//                    title: "Copy",
//                    image: UIImage(systemName: isCopied ? "doc.on.doc.fill" : "doc.on.doc")
//                ) { [weak self] _ in
//                    guard let self = self else { return }
//                    UIPasteboard.general.string = colorName
//                    self.copiedColor = colorName
//                    print("Copied \(colorName)")
//                    self.topCollectionviewInCollectionVC.reloadData()
//                }
//                
//                let shareAction = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { _ in
//                    let activityVC = UIActivityViewController(activityItems: [colorName], applicationActivities: nil)
//                    if let viewController = self.getViewController() {
//                        viewController.present(activityVC, animated: true)
//                    }
//                }
//                
//                let heartAction = UIAction(title: "Favorite", image: UIImage(systemName: "heart")) { _ in
//                    print("Heart tapped for \(colorName)")
//                    // Add your favorite logic here
//                }
//                
//                // Create the menu
//                let menu = UIMenu(title: "", children: [lockAction, copyAction, shareAction, heartAction])
//                
//                // Show the menu using a temporary UIButton
//                let tempButton = UIButton()
//                tempButton.menu = menu
//                tempButton.showsMenuAsPrimaryAction = true
//                self.addSubview(tempButton)
//                
//                // Position the button at the cell's location
//                tempButton.frame = cell.frame
//                
//                // Trigger the menu
//                tempButton.sendActions(for: .touchUpInside)
//                
//                // Remove the temporary button
//                DispatchQueue.main.async {
//                    tempButton.removeFromSuperview()
//                }
//            }
//        }
//    }
//    
//    // Helper method to get the parent view controller
//    private func getViewController() -> UIViewController? {
//        var responder: UIResponder? = self
//        while responder != nil {
//            responder = responder?.next
//            if let viewController = responder as? UIViewController {
//                return viewController
//            }
//        }
//        return nil
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 10 // Adjust if needed based on colorPalettes count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopCollectionViewCellInCollectionVC", for: indexPath) as! TopCollectionViewCellInCollectionVC
//        
//        let colorName = colorPalettes?[indexPath.row] ?? "#FFFFFF"
//        let backgroundColor = UIColor(hexString: colorName)
//        let textColor = backgroundColor.adjustedBrightness()
//        
//        cell.colorCodeInBottomCenterInCollectionViewCell.text = colorName
//        cell.colorCodeInBottomCenterInCollectionViewCell.textColor = textColor
//        cell.ellipsisButtonInCollectionViewCell.tintColor = textColor
//        cell.backgroundColor = backgroundColor
//        let isSaved = CoreDataManager.shared.isSingleColorSaved(name: colorName)
//        
//        let isCopied = UIPasteboard.general.string == colorName
//        
//        let favAction = UIAction(title: "Fav", image: UIImage(systemName: isSaved ? "heart.fill" : "heart")) { [weak self] _ in
//            print("before the guard")
//            guard let self = self else { return }
//            print("after the guard")
//            if isSaved {
//                let alert = UIAlertController(
//                    title: "Unsave Color",
//                    message: "Do you want to unsave this color?",
//                    preferredStyle: .alert
//                )
//                let unsaveAction = UIAlertAction(title: "Yes", style: .destructive) { _ in
//                    CoreDataManager.shared.deleteSingleColor(name: colorName)
//                    DispatchQueue.main.async {
//                        self.topCollectionviewInCollectionVC.reloadData()
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
//                    self.topCollectionviewInCollectionVC.reloadData()
//                }
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
//            
//            DispatchQueue.main.async {
//                
//                self.topCollectionviewInCollectionVC.reloadData() // Reload all cells to update "Copy" icons
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
//        cell.ellipsisButtonInCollectionViewCell.menu = UIMenu(children: [favAction, lockAction, copyAction, shareAction])
//        cell.ellipsisButtonInCollectionViewCell.showsMenuAsPrimaryAction = true
//        
//        return cell
//    }
//    
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
import UIKit

class TopTableViewCellInCollectionVC: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var colorPalettes: [String]?
    var buttonAction: (() -> Void)?
    
    @IBOutlet weak var colorSideBarContainer: UIView!
    @IBOutlet weak var heartButtonInTopView: UIButton!
    @IBOutlet weak var colorTitleInTopView: UILabel!
    @IBOutlet weak var ellipsisButtonInColorSideBar: UIButton!
    @IBOutlet weak var hexaCodeInColorSideBar: UILabel!
    @IBOutlet weak var colorTitleInColorSideBar: UILabel!
    @IBOutlet weak var underLine: UIView!
    @IBOutlet weak var topCollectionviewInCollectionVC: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        topCollectionviewInCollectionVC.dataSource = self
        topCollectionviewInCollectionVC.delegate = self
        topCollectionviewInCollectionVC.isScrollEnabled = false
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(clipboardDidChange(_:)),
            name: UIPasteboard.changedNotification,
            object: nil
        )
        
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
                self.topCollectionviewInCollectionVC.reloadItems(at: affectedIndices)
            }
        }
    }
    
    @IBAction func heartButtonTapped(_ sender: UIButton) {
        buttonAction?()
    }
    @IBAction func proButtonAction(_ sender: Any) {
            // Use the responder chain to find the parent view controller and present ProScreenVC
            if let viewController = findParentViewController() {
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProScreenVC") as! ProScreenVC
                vc.modalPresentationStyle = .fullScreen
                viewController.present(vc, animated: true, completion: nil)
            } else {
                print("Error: Could not find a view controller to present ProScreenVC")
            }
        }
        
        // Helper method to find the parent view controller
        private func findParentViewController() -> UIViewController? {
            var responder: UIResponder? = self
            while responder != nil {
                responder = responder?.next
                if let viewController = responder as? UIViewController {
                    return viewController
                }
            }
            return nil
        }
    func configureCell(with colorPalettes: [String]) {
        self.colorPalettes = colorPalettes
        topCollectionviewInCollectionVC.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorPalettes?.count ?? 0 // Fixed to use actual count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopCollectionViewCellInCollectionVC", for: indexPath) as! TopCollectionViewCellInCollectionVC
        
        if indexPath.row > 1 && !isPremiumUser() {
                cell.ellipsisButtonInCollectionViewCell.isHidden = true
                cell.colorCodeInBottomCenterInCollectionViewCell.isHidden = true
            cell.proButtonOutlet.isHidden = false
            } else {
                cell.ellipsisButtonInCollectionViewCell.isHidden = false
                cell.colorCodeInBottomCenterInCollectionViewCell.isHidden = false
                cell.proButtonOutlet.isHidden = true
            }
        let colorName = colorPalettes?[indexPath.row] ?? "#FFFFFF"
        let backgroundColor = UIColor(hexString: colorName)
        let textColor = backgroundColor.adjustedBrightness()
        
        cell.colorCodeInBottomCenterInCollectionViewCell.text = colorName
        cell.colorCodeInBottomCenterInCollectionViewCell.textColor = textColor
        cell.ellipsisButtonInCollectionViewCell.tintColor = textColor
        cell.backgroundColor = backgroundColor
        
        let isSaved = CoreDataManager.shared.isSingleColorSaved(name: colorName)
        let isCopied = UIPasteboard.general.string == colorName
        
        cell.ellipsisButtonInCollectionViewCell.isUserInteractionEnabled = true
        
        let favAction = UIAction(title: "Fav", image: UIImage(systemName: isSaved ? "heart.fill" : "heart")) { [weak self] _ in
            guard let self = self else { return }
            print("Fav tapped for \(colorName) at \(indexPath)")
            if isSaved {
                let alert = UIAlertController(
                    title: "Unsave Color",
                    message: "Do you want to unsave this color?",
                    preferredStyle: .alert
                )
                let unsaveAction = UIAlertAction(title: "Yes", style: .destructive) { _ in
                    CoreDataManager.shared.deleteSingleColor(name: colorName)
                    self.topCollectionviewInCollectionVC.reloadItems(at: [indexPath])
                }
                let cancelAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
                alert.addAction(unsaveAction)
                alert.addAction(cancelAction)
                if let rootVC = self.window?.rootViewController {
                    rootVC.present(alert, animated: true, completion: nil)
                }
            } else {
                CoreDataManager.shared.saveSingleColor(name: colorName)
                self.topCollectionviewInCollectionVC.reloadItems(at: [indexPath])
            }
        }
        
       
        
        let copyAction = UIAction(title: "Copy", image: UIImage(systemName: isCopied ? "doc.on.doc.fill" : "doc.on.doc")) { [weak self] _ in
            guard let self = self else { return }
            print("Copy tapped for \(colorName)")
            UIPasteboard.general.string = colorName
            // clipboardDidChange will handle the reload
        }
        
        let shareAction = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { _ in
            print("Share tapped for \(colorName)")
            let activityVC = UIActivityViewController(activityItems: [colorName], applicationActivities: nil)
            if let viewController = collectionView.window?.rootViewController {
                viewController.present(activityVC, animated: true)
            }
        }
        
        let menu = UIMenu(title: "", children: [favAction, copyAction, shareAction])
        cell.ellipsisButtonInCollectionViewCell.menu = menu
        cell.ellipsisButtonInCollectionViewCell.showsMenuAsPrimaryAction = true
        
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row > 1 && !isPremiumUser() {
            if let viewController = findParentViewController() {
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProScreenVC") as! ProScreenVC
                vc.modalPresentationStyle = .fullScreen
                viewController.present(vc, animated: true, completion: nil)
            } else {
                print("Error: Could not find a view controller to present ProScreenVC")
            }
            } else {
             
            }
    }
}
