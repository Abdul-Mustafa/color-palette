////
////  BottomTableViewCellInCollectionVC.swift
////  Color Palette
////
////  Created by mac on 04/03/2025.
////
//
//import UIKit
//
//class BottomTableViewCellInCollectionVC: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
//    var singleColorsInCorData: [SingleColor] = []
//    
//    @IBOutlet weak var titleInBottomViewTableCell: UILabel!
//    @IBOutlet weak var bottomCollectionViewInCollectonVC: UICollectionView!
//    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        bottomCollectionViewInCollectonVC.dataSource = self
//        bottomCollectionViewInCollectonVC.delegate = self
//        bottomCollectionViewInCollectonVC.showsVerticalScrollIndicator = false
//        fetchSingleColor()
//    }
//    
//    func fetchSingleColor() {
//        singleColorsInCorData = CoreDataManager.shared.fetchSingleColors()
//        bottomCollectionViewInCollectonVC.reloadData()
//    }
//    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return singleColorsInCorData.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = bottomCollectionViewInCollectonVC.dequeueReusableCell(withReuseIdentifier: "BottomCollectionViewCellInCollectionVC", for: indexPath) as! BottomCollectionViewCellInCollectionVC
//        let colorName = singleColorsInCorData[indexPath.row]
//        let backgroundColor = UIColor(hexString: colorName.name ?? "")
//        cell.colorViewInBottomCollectionViewCell.backgroundColor = backgroundColor
//        cell.colorNameInHexaCodeFormatInBottomCollectionViewCell.text = colorName.name
//        
//        return cell
//    }
//    
//    // Add this method to set a square size for cells
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let squareSize: CGFloat = 100 // Set your desired size here (width = height)
//        return CGSize(width: squareSize, height: squareSize)
//    }
//}

import UIKit

class BottomTableViewCellInCollectionVC: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    var singleColorsInCorData: [SingleColor] = []
    
    @IBOutlet weak var titleInBottomViewTableCell: UILabel!
    @IBOutlet weak var bottomCollectionViewInCollectonVC: UICollectionView!
    
    // Property to expose the content height
    var collectionViewContentHeight: CGFloat {
        return bottomCollectionViewInCollectonVC.contentSize.height
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bottomCollectionViewInCollectonVC.dataSource = self
        bottomCollectionViewInCollectonVC.delegate = self
        fetchSingleColor()
    }
    
    func fetchSingleColor() {
        singleColorsInCorData = CoreDataManager.shared.fetchSingleColors()
        bottomCollectionViewInCollectonVC.reloadData()
        // Ensure layout is updated after reloading data
        bottomCollectionViewInCollectonVC.layoutIfNeeded()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func collectionView(_ collectionView: UITableView, numberOfItemsInSection section: Int) -> Int {
        return singleColorsInCorData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return singleColorsInCorData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = bottomCollectionViewInCollectonVC.dequeueReusableCell(withReuseIdentifier: "BottomCollectionViewCellInCollectionVC", for: indexPath) as! BottomCollectionViewCellInCollectionVC
        let colorName = singleColorsInCorData[indexPath.row]
        let backgroundColor = UIColor(hexString: colorName.name ?? "")
        cell.colorViewInBottomCollectionViewCell.backgroundColor = backgroundColor
        cell.colorNameInHexaCodeFormatInBottomCollectionViewCell.text = colorName.name
        return cell
    }
    
    // Set square size for collection view cells (example: 50x50)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let squareSize: CGFloat = 100
        return CGSize(width: squareSize, height: squareSize)
    }
}
