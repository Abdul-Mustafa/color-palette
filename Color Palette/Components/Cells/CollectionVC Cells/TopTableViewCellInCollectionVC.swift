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
        // Initialization code
    }
    
    @IBAction func DeleteNamedColorsToCoreData(_ sender: UIButton) {
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
        return cell
    }
}
