
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
        collectionView.allowsSelection = true
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(clipboardDidChange),
            name: UIPasteboard.changedNotification,
            object: nil
        )
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func clipboardDidChange() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func configureCell(with colorPalettes: [String]) {
        self.colorPalettes = colorPalettes
        collectionView.reloadData()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorPalettes?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BottomCollectionViewCell", for: indexPath) as! BottomCollectionViewCell
        if let hexColor = colorPalettes?[indexPath.row] {
            cell.configure(with: hexColor)
            cell.onDataChanged = { [weak self] in
                self?.collectionView.reloadData()
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let relativeWidth = collectionViewWidth * 0.25
        let relativeHeight = relativeWidth * 1.3
        return CGSize(width: relativeWidth, height: relativeHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Optional: Add custom selection handling here if needed
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        // Optional: Add custom deselection handling here if needed
    }
}

