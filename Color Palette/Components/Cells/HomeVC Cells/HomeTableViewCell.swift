

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
        print("colorName is \(colorName)")
        let isSaved = CoreDataManager.shared.isSingleColorSaved(name: colorName)
        print(isSaved)
        let isCopied = UIPasteboard.general.string == colorName
        
        let favAction = UIAction(title: "Fav", image: UIImage(systemName: isSaved ? "heart.fill" : "heart")) { [weak self] _ in
            print("before the guard")
            guard let self = self else { return }
            print("after the guard")
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
