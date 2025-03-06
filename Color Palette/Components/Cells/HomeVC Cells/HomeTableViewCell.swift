
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
      
    }

    @IBAction func saveNamedColorsToCoreData(_ sender: UIButton) {
        buttonAction?()
        
    }
    
    // Set the color palettes data for the collection view
    func configureCell(with colorPalettes: [String]) {
        self.colorPalettes = colorPalettes
        collectionView.reloadData() // Refresh collection view
        
    }

    // UICollectionViewDataSource Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorPalettes?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        let colorName = colorPalettes?[indexPath.row]
        let backgroundColor = UIColor(hexString: colorName ??  "#FFFFFF")
        let textColor = backgroundColor.adjustedBrightness()
        cell.colorCodeInBottomCenterInCollectionViewCell.text = colorName
        cell.colorCodeInBottomCenterInCollectionViewCell.textColor = textColor
        cell.ellipsisButtonInCollectionViewCell.tintColor = textColor
        cell.backgroundColor = backgroundColor
        // Define UIActions with images from Assets
        let favAction = UIAction(title: "Fav", image: UIImage(systemName: "heart")) { _ in
            print("Fav tapped for \(colorName)")
        }
        
        let lockAction = UIAction(title: "Lock", image: UIImage(systemName: "lock")) { _ in
            print("Lock tapped for \(colorName)")
        }
        
        let copyAction = UIAction(title: "Copy", image: UIImage(systemName: "doc.on.doc")) { _ in
            UIPasteboard.general.string = colorName
            print("Copied \(colorName)")
        }
        
        let shareAction = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { _ in
            let activityVC = UIActivityViewController(activityItems: [colorName], applicationActivities: nil)
            if let viewController = collectionView.window?.rootViewController {
                viewController.present(activityVC, animated: true)
                
            }
        }
        
        // Assign the menu to the button
        cell.ellipsisButtonInCollectionViewCell.menu = UIMenu(children: [favAction, lockAction, copyAction, shareAction])
        cell.ellipsisButtonInCollectionViewCell.showsMenuAsPrimaryAction = true
       
        return cell
    }

    // Set Collection View Cell Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 5, height: (collectionView.frame.size.height / 2)-2.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
        
    }
}





