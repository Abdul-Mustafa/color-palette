//
//  BottomTableViewCellInCollectionVC.swift
//  Color Palette
//
//  Created by mac on 04/03/2025.
//

import UIKit

class BottomTableViewCellInCollectionVC: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
 
    
    @IBOutlet weak var titleInBottomViewTableCell: UILabel!
    @IBOutlet weak var bottomCollectionViewInCollectonVC: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = bottomCollectionViewInCollectonVC.dequeueReusableCell(withReuseIdentifier: "BottomCollectionViewCellInCollectionVC", for: indexPath) as! BottomCollectionViewCellInCollectionVC
        return cell
    }

}
