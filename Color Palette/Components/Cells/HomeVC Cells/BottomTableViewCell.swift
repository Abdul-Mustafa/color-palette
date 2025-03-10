//
//  BottomTableViewCell.swift
//  Color Palette
//
//  Created by mac on 19/02/2025.
//

import UIKit

class BottomTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  
    var buttonAction: (() -> Void)?
    var colorPalettes: [String]?
    
    @IBOutlet weak var bottomCollectionView: UICollectionView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleInBottomViewTableCell: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        bottomCollectionView.dataSource = self
        bottomCollectionView.delegate = self
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                   layout.scrollDirection = .horizontal
                   layout.estimatedItemSize = .zero
               }
               
               collectionView.alwaysBounceVertical = false
               collectionView.alwaysBounceHorizontal = true
    }
    
  
    
    // Set the color palettes data for the collection view
    func configureCell(with colorPalettes: [String]) {
        self.colorPalettes = colorPalettes
        collectionView.reloadData() // Refresh collection view
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorPalettes?.count ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BottomCollectionViewCell", for: indexPath) as! BottomCollectionViewCell
        cell.colorNameInHexaCodeFormatInBottomCollectionViewCell.text = colorPalettes?[indexPath.row]
        cell.colorViewInBottomCollectionViewCell.backgroundColor = UIColor(hexString: colorPalettes?[indexPath.row] ?? "#FFFFFF")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let relativeWidth = collectionViewWidth * 0.25 // 50% of the collection view's width
        let relativeHeight = relativeWidth * 1.3 // Maintaining a 1:1.32 aspect ratio, for example
        
        return CGSize(width: relativeWidth, height: relativeHeight)
    }
}
