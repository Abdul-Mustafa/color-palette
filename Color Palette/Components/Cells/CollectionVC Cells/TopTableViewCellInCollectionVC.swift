//
//  CollectionVCTableViewCell.swift
//  Color Palette
//
//  Created by mac on 04/03/2025.
//

import UIKit

class TopTableViewCellInCollectionVC: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    
    
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
    @IBOutlet weak var underLine: UIView!
    @IBOutlet weak var topCollectionviewInCollectionVC: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        topCollectionviewInCollectionVC.dataSource = self
        topCollectionviewInCollectionVC.delegate = self
        topCollectionviewInCollectionVC.isScrollEnabled = false
        // Initialization code
    }
    

    @IBAction func heartButtonTapped(_ sender: UIButton) {
            buttonAction?()
        }
    
    // Set the color palettes data for the collection view
    func configureCell(with colorPalettes: [String]) {
        self.colorPalettes = colorPalettes
        topCollectionviewInCollectionVC.reloadData() // Refresh collection view
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = topCollectionviewInCollectionVC.dequeueReusableCell(withReuseIdentifier: "TopCollectionViewCellInCollectionVC", for: indexPath) as! TopCollectionViewCellInCollectionVC
        
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
