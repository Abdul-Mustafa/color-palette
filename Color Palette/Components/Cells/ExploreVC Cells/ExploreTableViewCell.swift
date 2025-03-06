//
//  ExploreTableViewCell.swift
//  Color Palette
//
//  Created by mac on 24/02/2025.
//

import UIKit

class ExploreTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var colorPalettes: [ColorPalette]?
    @IBOutlet weak var collectionViewInExploreVC: UICollectionView!
    @IBOutlet weak var colorNameAtTop: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionViewInExploreVC.dataSource = self
        collectionViewInExploreVC.delegate = self
        // Initialization code
        if let layout = collectionViewInExploreVC.collectionViewLayout as? UICollectionViewFlowLayout {
                   layout.scrollDirection = .horizontal
                   layout.estimatedItemSize = .zero
               }
    }
    func configureCell(with colorPalettes: [ColorPalette]?) {
        self.colorPalettes = colorPalettes
      
        collectionViewInExploreVC.reloadData() // Refresh collection view
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        colorPalettes?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExploreCollectionViewCell", for: indexPath) as! ExploreCollectionViewCell
        cell.industryLabelInCollectionView.text = colorPalettes?[indexPath.row].name
       
        cell.leftColorContrainer.backgroundColor = UIColor(hex: colorPalettes?[indexPath.row].colors.first ?? "#FFFFFF")
        cell.midleColorContainer.backgroundColor = UIColor(hex: colorPalettes?[indexPath.row].colors[1] ?? "#FFFFFF")
        cell.rightColorContainer.backgroundColor = UIColor(hex: colorPalettes?[indexPath.row].colors[2] ?? "#FFFFFF")
        cell.topBarIncollectionViewCell.backgroundColor = UIColor(hex: colorPalettes?[indexPath.row].colors[2] ?? "#FFFFFF")
        let backGroundColor = UIColor(hexString: colorPalettes?[indexPath.row].colors[1] ?? "#FFFFFF").adjustedBrightness()
        cell.backgroundColor = backGroundColor
        cell.industryLabelInCollectionView.textColor = UIColor(hex: colorPalettes?[indexPath.row].colors[2] ?? "#FFFFFF")
        cell.topSeperatorLine.backgroundColor = UIColor(hex: colorPalettes?[indexPath.row].colors[2] ?? "#FFFFFF")
        cell.bottomSeperatorLine.backgroundColor = UIColor(hex: colorPalettes?[indexPath.row].colors[2] ?? "#FFFFFF")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            // Example: Make width 1/3 of screen width, height dependent on width
//            let screenWidth = UIScreen.main.bounds.width
//            let cellWidth = screenWidth/2 // Dependent on screen width
//            let cellHeight = cellWidth/2  // Height depends on width (e.g., 1.5x width)
            
        return CGSize(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.width/3)
        }
    
 
}
