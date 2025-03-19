

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
        if let layout = bottomCollectionViewInCollectonVC.collectionViewLayout as? UICollectionViewFlowLayout {
                    layout.estimatedItemSize = .zero // Enforce exact size
                }
        fetchSingleColor()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(refreshFavorites),
            name: CoreDataManager.paletteDidChangeNotification,
            object: nil
        )
    
        
    }
    @objc func refreshFavorites() {
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
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let squareSize: CGFloat = 100
//        return CGSize(width: squareSize, height: squareSize)
//    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let relativeWidth = collectionViewWidth * 0.25 // 50% of the collection view's width
        let relativeHeight = relativeWidth * 1.3 // Maintaining a 1:1.32 aspect ratio, for example
        
        return CGSize(width: relativeWidth, height: relativeHeight)
    }
}
