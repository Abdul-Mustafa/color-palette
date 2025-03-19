
import UIKit

class BottomTableViewCellInCollectionVC: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    var singleColorsInCorData: [SingleColor] = []
    
    @IBOutlet weak var titleInBottomViewTableCell: UILabel!
    @IBOutlet weak var bottomCollectionViewInCollectonVC: UICollectionView!
    
    var collectionViewContentHeight: CGFloat {
        return bottomCollectionViewInCollectonVC.contentSize.height
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bottomCollectionViewInCollectonVC.dataSource = self
        bottomCollectionViewInCollectonVC.delegate = self
        bottomCollectionViewInCollectonVC.allowsSelection = true // Enable cell selection
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
        bottomCollectionViewInCollectonVC.layoutIfNeeded()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return singleColorsInCorData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = bottomCollectionViewInCollectonVC.dequeueReusableCell(withReuseIdentifier: "BottomCollectionViewCellInCollectionVC", for: indexPath) as! BottomCollectionViewCellInCollectionVC
        let colorName = singleColorsInCorData[indexPath.row]
        cell.configure(with: colorName.name ?? "#FFFFFF")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let relativeWidth = collectionViewWidth * 0.25
        let relativeHeight = relativeWidth * 1.3
        return CGSize(width: relativeWidth, height: relativeHeight)
    }
}
