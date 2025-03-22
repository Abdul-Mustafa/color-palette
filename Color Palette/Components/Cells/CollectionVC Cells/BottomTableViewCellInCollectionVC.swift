//
//import UIKit
//
//class BottomTableViewCellInCollectionVC: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
//    var singleColorsInCorData: [SingleColor] = []
//    
//    @IBOutlet weak var titleInBottomViewTableCell: UILabel!
//    @IBOutlet weak var bottomCollectionViewInCollectonVC: UICollectionView!
//    
//    var collectionViewContentHeight: CGFloat {
//        return bottomCollectionViewInCollectonVC.contentSize.height
//    }
//    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        
//        bottomCollectionViewInCollectonVC.dataSource = self
//        bottomCollectionViewInCollectonVC.delegate = self
//        bottomCollectionViewInCollectonVC.allowsSelection = true // Enable cell selection
//        if let layout = bottomCollectionViewInCollectonVC.collectionViewLayout as? UICollectionViewFlowLayout {
//            layout.estimatedItemSize = .zero // Enforce exact size
//        }
//        fetchSingleColor()
//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(refreshFavorites),
//            name: CoreDataManager.paletteDidChangeNotification,
//            object: nil
//        )
//    }
//    
//    @objc func refreshFavorites() {
//        fetchSingleColor()
//    }
//    
//    func fetchSingleColor() {
//        singleColorsInCorData = CoreDataManager.shared.fetchSingleColors()
//        bottomCollectionViewInCollectonVC.reloadData()
//        bottomCollectionViewInCollectonVC.layoutIfNeeded()
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
//        cell.configure(with: colorName.name ?? "#FFFFFF")
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let collectionViewWidth = collectionView.bounds.width
//        let relativeWidth = collectionViewWidth * 0.25
//        let relativeHeight = relativeWidth * 1.3
//        return CGSize(width: relativeWidth, height: relativeHeight)
//    }
//}
import UIKit

protocol BottomTableViewCellDelegate: AnyObject {
    func didUpdateCollectionViewHeight(_ height: CGFloat)
}

class BottomTableViewCellInCollectionVC: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    var singleColorsInCorData: [SingleColor] = []
    
    @IBOutlet weak var titleInBottomViewTableCell: UILabel!
    @IBOutlet weak var bottomCollectionViewInCollectonVC: UICollectionView!
    
    weak var delegate: BottomTableViewCellDelegate?
    
    var collectionViewContentHeight: CGFloat {
        return bottomCollectionViewInCollectonVC.contentSize.height
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bottomCollectionViewInCollectonVC.dataSource = self
        bottomCollectionViewInCollectonVC.delegate = self
        bottomCollectionViewInCollectonVC.allowsSelection = true
        if let layout = bottomCollectionViewInCollectonVC.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.estimatedItemSize = .zero // Enforce exact size
        }
        fetchSingleColor() // Initial data load
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
        // Ensure layout is updated and height is propagated after data load
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.bottomCollectionViewInCollectonVC.layoutIfNeeded()
            let newHeight = self.collectionViewContentHeight
            self.delegate?.didUpdateCollectionViewHeight(newHeight)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return singleColorsInCorData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BottomCollectionViewCellInCollectionVC", for: indexPath) as! BottomCollectionViewCellInCollectionVC
        let colorName = singleColorsInCorData[indexPath.row]
        cell.configure(with: colorName.name ?? "#FFFFFF")
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let relativeWidth = collectionViewWidth * 0.25
        let relativeHeight = relativeWidth * 1.3
        return CGSize(width: relativeWidth, height: relativeHeight)
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Ensure layout updates when selection changes (shows/hides buttons)
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.bottomCollectionViewInCollectonVC.layoutIfNeeded()
            self.delegate?.didUpdateCollectionViewHeight(self.collectionViewContentHeight)
        }
    }
}
