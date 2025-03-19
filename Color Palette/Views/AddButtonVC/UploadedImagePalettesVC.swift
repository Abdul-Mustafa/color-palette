
import UIKit
import CoreImage

class UploadedImagePalettesVC: UIViewController {
    // MARK: - Properties
    private var extractedColors: [UIColor] = []
    var image: UIImage?
    private var selectedIndexPath: IndexPath?
    // MARK: - IBOutlets
    @IBOutlet weak var exitButtonView: UIButton!
    @IBOutlet weak var saveButtonView: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var rSliderOutlet: UISlider!
    @IBOutlet weak var rSliderResult: UILabel!
    @IBOutlet weak var rSliderResultView: UIView!
    @IBOutlet weak var gSliderOutlet: UISlider!
    @IBOutlet weak var gSliderResult: UILabel!
    @IBOutlet weak var gSliderResultView: UIView!
    @IBOutlet weak var bSliderOutlet: UISlider!
    @IBOutlet weak var bSliderResult: UILabel!
    @IBOutlet weak var bSliderResultView: UIView!
    @IBOutlet weak var finalHexaCode: UILabel!
    @IBOutlet weak var copyButton: UIButton!
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCollectionView()
        setupSliders()
        displayImage()
        extractColors()
        exitButtonView.layer.cornerRadius = exitButtonView.frame.height / 2
        exitButtonView.clipsToBounds = true
        sliderResultContainers()
    }
    
    // MARK: - IBActions
    @IBAction func exitButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func savePalettes(_ sender: UIButton) {
        guard let hexCode = finalHexaCode.text else { return }
        
        // Check if the color is already saved using CoreDataManager
        if CoreDataManager.shared.isSingleColorSaved(name: hexCode) {
            // Show feedback if already saved
            let originalText = finalHexaCode.text
            finalHexaCode.text = "Color already saved!"
            showToast(message: "Color already saved!")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.finalHexaCode.text = originalText // Revert after 1 second
            }
        } else {
            // Save the color if not already saved
            CoreDataManager.shared.saveSingleColor(name: hexCode)
            // Show feedback for successful save
            let originalText = finalHexaCode.text
            finalHexaCode.text = "Color saved!"
            showToast(message: "Color saved!")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.finalHexaCode.text = originalText // Revert after 1 second
            }
        }
    }
    
    @IBAction func rSlider(_ sender: UISlider) {
        rSliderResult.text = String(format: "%.0f", sender.value)
        updateFinalColor()
    }
    
    @IBAction func gSlider(_ sender: UISlider) {
        gSliderResult.text = String(format: "%.0f", sender.value)
        updateFinalColor()
    }
    
    @IBAction func bSlider(_ sender: UISlider) {
        bSliderResult.text = String(format: "%.0f", sender.value)
        updateFinalColor()
    }
    @IBAction func copyButtonPressed(_ sender: UIButton) {
            guard let hexCode = finalHexaCode.text else { return }
            UIPasteboard.general.string = hexCode // Copy the hex code to clipboard
            
            // Provide visual feedback
            let originalText = finalHexaCode.text
            finalHexaCode.text = "Copied!"
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.finalHexaCode.text = originalText // Revert after 1 second
            }
        }
    
    // MARK: - Private Methods
    private func setupView() {
        view.backgroundColor = .white
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
    }
    
    private func setupSliders() {
        rSliderOutlet.minimumValue = 0
        rSliderOutlet.maximumValue = 255
        gSliderOutlet.minimumValue = 0
        gSliderOutlet.maximumValue = 255
        bSliderOutlet.minimumValue = 0
        bSliderOutlet.maximumValue = 255
        
        rSliderResult.text = "0"
        gSliderResult.text = "0"
        bSliderResult.text = "0"
        finalHexaCode.text = "#000000"
    }
    
    private func displayImage() {
        guard let image = image else {
            print("No image provided to UploadedImagePalettesVC")
            return
        }
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
    }
    
    private func extractColors() {
        guard let image = image else { return }
        
        if let colors = image.extractDominantColors(count: 5) {
            extractedColors = colors
//            print("Extracted colors: \(colors.map { $0.toHexString() })")
            collectionView.reloadData()
            
            // Select the first color by default
            if !extractedColors.isEmpty {
                let indexPath = IndexPath(item: 0, section: 0)
                selectedIndexPath = indexPath // Set the initial selected index
                collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .left)
                collectionView(self.collectionView, didSelectItemAt: indexPath)
            }
        }
    }
    
    private func sliderResultContainers() {
        rSliderResultView.layer.cornerRadius = 5.0
        rSliderResultView.layer.borderWidth = 1.0
        rSliderResultView.layer.borderColor = UIColor.red.cgColor
        rSliderResultView.clipsToBounds = true
        
        gSliderResultView.layer.cornerRadius = 5.0
        gSliderResultView.layer.borderWidth = 1.0
        gSliderResultView.layer.borderColor = UIColor.green.cgColor
        gSliderResultView.clipsToBounds = true
        
        bSliderResultView.layer.cornerRadius = 5.0
        bSliderResultView.layer.borderWidth = 1.0
        bSliderResultView.layer.borderColor = UIColor.blue.cgColor
        bSliderResultView.clipsToBounds = true
    }
    
    private func updateFinalColor() {
        let r = CGFloat(rSliderOutlet.value) / 255.0
        let g = CGFloat(gSliderOutlet.value) / 255.0
        let b = CGFloat(bSliderOutlet.value) / 255.0
        let color = UIColor(red: r, green: g, blue: b, alpha: 1.0)
        finalHexaCode.text = color.toHexString()
        
        // Update the selected cell's color
        if let indexPath = selectedIndexPath,
           let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCellInUploadedImagePalettesVC {
            cell.colorView.backgroundColor = color
            cell.hexaCodeLabel.text = color.toHexString()
        }
    }
}

// MARK: - UICollectionViewDelegate & DataSource
extension UploadedImagePalettesVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return extractedColors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCellInUploadedImagePalettesVC",
                                                          for: indexPath) as? CollectionViewCellInUploadedImagePalettesVC else {
            fatalError("Unable to dequeue CollectionViewCellInUploadedImagePalettesVC. Verify the identifier in storyboard.")
        }
        let color = extractedColors[indexPath.item]
        cell.colorView.backgroundColor = color
        cell.hexaCodeLabel.text = color.toHexString()
        cell.hexaCodeLabel.textColor = .black
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Restore the previously selected cell to its original color
        if let previousIndexPath = selectedIndexPath,
           previousIndexPath != indexPath,
           let previousCell = collectionView.cellForItem(at: previousIndexPath) as? CollectionViewCellInUploadedImagePalettesVC {
            let originalColor = extractedColors[previousIndexPath.item]
            previousCell.colorView.backgroundColor = originalColor
            previousCell.hexaCodeLabel.text = originalColor.toHexString()
            previousCell.layer.borderWidth = 0.0
        }
        
        // Update the newly selected cell
        let selectedColor = extractedColors[indexPath.item]
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        selectedColor.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        rSliderOutlet.value = Float(r * 255)
        gSliderOutlet.value = Float(g * 255)
        bSliderOutlet.value = Float(b * 255)
        
        rSliderResult.text = String(format: "%.0f", r * 255)
        gSliderResult.text = String(format: "%.0f", g * 255)
        bSliderResult.text = String(format: "%.0f", b * 255)
        
        finalHexaCode.text = selectedColor.toHexString()
        
        if let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCellInUploadedImagePalettesVC {
            cell.layer.borderWidth = 2.0
            cell.layer.cornerRadius = 10.0
            cell.clipsToBounds = true
            cell.layer.borderColor = UIColor.gray.cgColor
        }
        
        // Update the selected index path
        selectedIndexPath = indexPath
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCellInUploadedImagePalettesVC {
            let originalColor = extractedColors[indexPath.item]
            cell.colorView.backgroundColor = originalColor
            cell.hexaCodeLabel.text = originalColor.toHexString()
            cell.layer.borderWidth = 0.0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 5, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

// MARK: - UIImage Extension for Distinct Color Extraction
extension UIImage {
    func extractDominantColors(count: Int = 5) -> [UIColor]? {
        guard let cgImage = self.cgImage else { return nil }
        
        let size = CGSize(width: 100, height: 100)
        let width = Int(size.width)
        let height = Int(size.height)
        
        guard let context = CGContext(
            data: nil,
            width: width,
            height: height,
            bitsPerComponent: 8,
            bytesPerRow: 0,
            space: CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
        ) else { return nil }
        
        context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
        guard let pixelData = context.data else { return nil }
        let data = pixelData.bindMemory(to: UInt8.self, capacity: width * height * 4)
        
        var colors: [(r: CGFloat, g: CGFloat, b: CGFloat, count: Int)] = []
        for y in 0..<height {
            for x in 0..<width {
                let pixelIndex = (y * width + x) * 4
                let r = CGFloat(data[pixelIndex]) / 255.0
                let g = CGFloat(data[pixelIndex + 1]) / 255.0
                let b = CGFloat(data[pixelIndex + 2]) / 255.0
                let a = CGFloat(data[pixelIndex + 3]) / 255.0
                
                if a > 0.1 {
                    colors.append((r: r, g: g, b: b, count: 1))
                }
            }
        }
        
        guard colors.count > 0 else { return nil }
        var clusters = initialClusters(colors: colors, count: min(count, colors.count))
        for _ in 0..<20 {
            clusters = updateClusters(colors: colors, clusters: clusters)
        }
        
        return clusters.map { UIColor(red: $0.r, green: $0.g, blue: $0.b, alpha: 1.0) }
    }
    
    private func initialClusters(colors: [(r: CGFloat, g: CGFloat, b: CGFloat, count: Int)], count: Int) -> [(r: CGFloat, g: CGFloat, b: CGFloat, count: Int)] {
        var shuffled = colors.shuffled()
        return Array(shuffled.prefix(count))
    }
    
    private func updateClusters(colors: [(r: CGFloat, g: CGFloat, b: CGFloat, count: Int)], clusters: [(r: CGFloat, g: CGFloat, b: CGFloat, count: Int)]) -> [(r: CGFloat, g: CGFloat, b: CGFloat, count: Int)] {
        var newClusters: [[(r: CGFloat, g: CGFloat, b: CGFloat, count: Int)]] = Array(repeating: [], count: clusters.count)
        
        for color in colors {
            let closestClusterIndex = clusters.enumerated().min(by: {
                distance($0.element, color) < distance($1.element, color)
            })?.offset ?? 0
            newClusters[closestClusterIndex].append(color)
        }
        
        return newClusters.map { cluster in
            guard !cluster.isEmpty else { return (r: 0, g: 0, b: 0, count: 0) }
            let total = cluster.reduce((r: 0.0, g: 0.0, b: 0.0, count: 0)) { (acc, color) in
                (r: acc.r + color.r, g: acc.g + color.g, b: acc.b + color.b, count: acc.count + color.count)
            }
            let count = CGFloat(total.count)
            return (r: total.r / count, g: total.g / count, b: total.b / count, count: total.count)
        }
    }
    
    private func distance(_ a: (r: CGFloat, g: CGFloat, b: CGFloat, count: Int), _ b: (r: CGFloat, g: CGFloat, b: CGFloat, count: Int)) -> CGFloat {
        let dr = a.r - b.r
        let dg = a.g - b.g
        let db = a.b - b.b
        return dr * dr + dg * dg + db * db
    }
}

// MARK: - UIColor Extension
extension UIColor {
    func toHexString() -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb: Int = (Int)(r * 255) << 16 | (Int)(g * 255) << 8 | (Int)(b * 255) << 0
        return String(format: "#%06X", rgb)
    }
}

extension UploadedImagePalettesVC {
    func showToast(message: String, duration: TimeInterval = 2.0) {
          let toastLabel = UILabel()
          toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.7)
          toastLabel.textColor = UIColor.white
          toastLabel.textAlignment = .center
          toastLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
          toastLabel.text = message
          toastLabel.alpha = 0.0
          toastLabel.numberOfLines = 0
          toastLabel.layer.cornerRadius = 10
          toastLabel.clipsToBounds = true
          
          // Set dynamic width based on text and padding
          let maxWidth = self.view.frame.size.width * 0.7
          let textSize = toastLabel.sizeThatFits(CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude))
          toastLabel.frame = CGRect(x: 0, y: 0, width: textSize.width + 40, height: textSize.height + 20)
          toastLabel.center = self.view.center

          self.view.addSubview(toastLabel)
          
          // Animate fade-in and fade-out
          UIView.animate(withDuration: 0.5, animations: {
              toastLabel.alpha = 1.0
          }) { _ in
              UIView.animate(withDuration: 0.5, delay: duration, options: .curveEaseOut, animations: {
                  toastLabel.alpha = 0.0
              }) { _ in
                  toastLabel.removeFromSuperview()
              }
          }
      }
}
