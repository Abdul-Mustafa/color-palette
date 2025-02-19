
import UIKit


class HomeTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var colorPalettes: [String]?
    

    // TopView
    @IBOutlet weak var colorSideBarContainer: UIView!
    @IBOutlet weak var heartButtonInTopView: UIButton!
    @IBOutlet weak var colorTitleInTopView: UILabel!
    // SideBar
    @IBOutlet weak var ellipsisButtonInColorSideBar: UIButton!
    @IBOutlet weak var hexaCodeInColorSideBar: UILabel!
    @IBOutlet weak var colorTitleInColorSideBar: UILabel!
    // Collection View
    @IBOutlet weak var collectionView: UICollectionView!

    @IBOutlet weak var underLine: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isScrollEnabled = false
    }

    // Set the color palettes data for the collection view
    func configureCell(with colorPalettes: [String]) {
        self.colorPalettes = colorPalettes
        
        collectionView.reloadData() // Refresh collection view
    }

    // UICollectionViewDataSource Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorPalettes?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        let colorName = colorPalettes?[indexPath.row]
        let backgroundColor = UIColor(hexString: colorName ??  "#FFFFFF")
        let textColor = backgroundColor.adjustedBrightness()
        cell.colorCodeInBottomCenterInCollectionViewCell.text = colorName
        cell.colorCodeInBottomCenterInCollectionViewCell.textColor = textColor
        cell.ellipsisButtonInCollectionViewCell.tintColor = textColor
        cell.backgroundColor = backgroundColor
       
        return cell
    }

    // Set Collection View Cell Size
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





extension UIColor {
    /// Initializes a UIColor from a hex string (e.g., "#FFFFFF" or "FFFFFF")
    convenience init(hexString: String) {
        var hexSanitized = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if hexSanitized.hasPrefix("#") {
            hexSanitized.remove(at: hexSanitized.startIndex)
        }
        
        guard hexSanitized.count == 6 else {
            self.init(white: 1.0, alpha: 1.0) // Default to white if invalid
            return
        }

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = CGFloat((rgb >> 16) & 0xFF) / 255.0
        let green = CGFloat((rgb >> 8) & 0xFF) / 255.0
        let blue = CGFloat(rgb & 0xFF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    /// Returns a much lighter or darker variant of the color for better contrast
    func adjustedBrightness() -> UIColor {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        // Calculate luminance using the standard formula
        let luminance = (0.299 * red + 0.587 * green + 0.114 * blue)
        
        let adjustment: CGFloat = luminance > 0.5 ? -0.5 : 0.5 // Make changes more pronounced
        
        let adjustedRed = max(0, min(1, red + adjustment))
        let adjustedGreen = max(0, min(1, green + adjustment))
        let adjustedBlue = max(0, min(1, blue + adjustment))
        
        return UIColor(red: adjustedRed, green: adjustedGreen, blue: adjustedBlue, alpha: alpha)
    }
}


