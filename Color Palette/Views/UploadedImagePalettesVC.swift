//////
//////  Untitled.swift
//////  Color Palette
//////
//////  Created by mac on 10/03/2025.
//////
////
////import UIKit
////import CoreImage
////
////class UploadedImagePalettesVC: UIViewController {
////    
////    var image: UIImage?
////    
////    @IBOutlet weak var collectionView: UICollectionView!
////    @IBOutlet weak var imageView: UIImageView!
////    @IBOutlet weak var exitButtonView: UIButton!
////    @IBAction func exitButton(_ sender: UIButton) {
////    }
////    @IBAction func savePalettes(_ sender: UIButton) {
////    }
////    @IBOutlet weak var r_sliderResult: UILabel!
////    @IBOutlet weak var g_sliderResult: UILabel!
////    @IBOutlet weak var b_sliderResult: UILabel!
////    
////    @IBOutlet weak var finalHexaCode: UILabel!
////    override func viewDidLoad() {
////        super.viewDidLoad()
////        view.backgroundColor = .white
////        displayImage()
////        extractColors()
////    }
////    
////    private func displayImage() {
////        guard let image = image else { return }
////        let imageView = UIImageView(image: image)
////        imageView.contentMode = .scaleAspectFit
////        imageView.translatesAutoresizingMaskIntoConstraints = false
////        view.addSubview(imageView)
////        
////        NSLayoutConstraint.activate([
////            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
////            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
////            imageView.widthAnchor.constraint(equalToConstant: 300),
////            imageView.heightAnchor.constraint(equalToConstant: 300)
////        ])
////    }
////    
////    private func extractColors() {
////        guard let image = image, let ciImage = CIImage(image: image) else { return }
////        
////        let filter = CIFilter(name: "CIAreaAverage")!
////        filter.setValue(ciImage, forKey: kCIInputImageKey)
////        
////        guard let outputImage = filter.outputImage else { return }
////        
////        var bitmap = [UInt8](repeating: 0, count: 4)
////        let context = CIContext()
////        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: CGColorSpaceCreateDeviceRGB())
////        
////        let color = UIColor(red: CGFloat(bitmap[0]) / 255, green: CGFloat(bitmap[1]) / 255, blue: CGFloat(bitmap[2]) / 255, alpha: 1)
////        
////        let colorView = UIView()
////        colorView.backgroundColor = color
////        colorView.translatesAutoresizingMaskIntoConstraints = false
////        view.addSubview(colorView)
////        
////        NSLayoutConstraint.activate([
////            colorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 350),
////            colorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
////            colorView.widthAnchor.constraint(equalToConstant: 100),
////            colorView.heightAnchor.constraint(equalToConstant: 100)
////        ])
////    }
////}
//
////
////  UploadedImagePalettesVC.swift
////  Color Palette
////
////  Created by mac on 10/03/2025.
////
//
////
////  UploadedImagePalettesVC.swift
////  Color Palette
////
////  Created by mac on 10/03/2025.
////
//
////
////  UploadedImagePalettesVC.swift
////  Color Palette
////
////  Created by mac on 10/03/2025.
////
//
////
////  UploadedImagePalettesVC.swift
////  Color Palette
////
////  Created by mac on 10/03/2025.
////
//
////import UIKit
////import CoreImage
////
////class UploadedImagePalettesVC: UIViewController {
////    // MARK: - Properties
////    private var extractedColors: [UIColor] = []
////    var image: UIImage?
////    @IBOutlet weak var exitButtonView: UIButton!
////    @IBOutlet weak var saveButtonView: UIButton!
////    @IBOutlet weak var imageView: UIImageView!
////    // MARK: - IBOutlets
////    @IBOutlet weak var collectionView: UICollectionView!
////    
////    @IBOutlet weak var rSliderOutlet: UISlider!
////    @IBOutlet weak var rSliderResult: UILabel!
////    
////    @IBOutlet weak var gSliderOutlet: UISlider!
////    @IBOutlet weak var gSliderResult: UILabel!
////    
////    @IBOutlet weak var bSliderOutlet: UISlider!
////    @IBOutlet weak var bSliderResult: UILabel!
////    
////    @IBOutlet weak var finalHexaCode: UILabel!
////    
////    // MARK: - Lifecycle
////    override func viewDidLoad() {
////        super.viewDidLoad()
////        setupView()
////        setupCollectionView()
////        displayImage()
////        extractColors()
////        exitButtonView.layer.cornerRadius = exitButtonView.frame.height / 2
////        exitButtonView.layer.cornerRadius = exitButtonView.frame.width / 2
////            exitButtonView.clipsToBounds = true
////    }
////    @IBAction func exitButton(_ sender: UIButton) {
////        dismiss(animated: true)
////    }
////    @IBAction func savePalettes(_ sender: UIButton) {
////        // Implement save functionality
////    }
////    
////    @IBAction func rSlider(_ sender: UISlider) {
////    }
////    
////    @IBAction func gSlider(_ sender: UISlider) {
////    }
////    // MARK: - IBActions
////    @IBAction func bSlider(_ sender: UISlider) {
////    }
////    
////   
////    
////    // MARK: - Private Methods
////    private func setupView() {
////        view.backgroundColor = .white
////    }
////    
////    private func setupCollectionView() {
////        collectionView.delegate = self
////        collectionView.dataSource = self
////        // No register call needed since the cell is in the storyboard
////    }
////    
////    private func displayImage() {
////        guard let image = image else {
////            print("No image provided to UploadedImagePalettesVC")
////            return
////        }
////        imageView.image = image
////        imageView.contentMode = .scaleAspectFit
////    }
////    
////    private func extractColors() {
////        guard let image = image, let ciImage = CIImage(image: image) else { return }
////        
////        let filter = CIFilter(name: "CIAreaAverage")!
////        filter.setValue(ciImage, forKey: kCIInputImageKey)
////        
////        guard let outputImage = filter.outputImage else { return }
////        
////        var bitmap = [UInt8](repeating: 0, count: 4)
////        let context = CIContext()
////        context.render(outputImage,
////                      toBitmap: &bitmap,
////                      rowBytes: 4,
////                      bounds: CGRect(x: 0, y: 0, width: 1, height: 1),
////                      format: .RGBA8,
////                      colorSpace: CGColorSpaceCreateDeviceRGB())
////        
////        let color = UIColor(red: CGFloat(bitmap[0]) / 255.0,
////                          green: CGFloat(bitmap[1]) / 255.0,
////                          blue: CGFloat(bitmap[2]) / 255.0,
////                          alpha: 1.0)
////        extractedColors.append(color)
////        collectionView.reloadData()
////    }
////}
////
////// MARK: - UICollectionViewDelegate & DataSource
////extension UploadedImagePalettesVC: UICollectionViewDelegate, UICollectionViewDataSource {
////    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
////        print(extractedColors.count)
////        return extractedColors.count
////    }
////    
////    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
////        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCellInUploadedImagePalettesVC",
////                                                          for: indexPath) as? CollectionViewCellInUploadedImagePalettesVC else {
////            fatalError("Unable to dequeue CollectionViewCellInUploadedImagePalettesVC. Verify the identifier in storyboard.")
////        }
////        let color = extractedColors[indexPath.item]
////        cell.colorView.backgroundColor = color
////        cell.hexaCodeLabel.text = color.toHexString()
////        cell.hexaCodeLabel.textColor = .black
////        
////        return cell
////    }
//// 
////}
////
////// MARK: - UIColor Extension
////extension UIColor {
////    func toHexString() -> String {
////        var r: CGFloat = 0
////        var g: CGFloat = 0
////        var b: CGFloat = 0
////        var a: CGFloat = 0
////        
////        getRed(&r, green: &g, blue: &b, alpha: &a)
////        
////        let rgb: Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
////        return String(format: "#%06x", rgb)
////    }
////}
//import UIKit
//import CoreImage
//
//class UploadedImagePalettesVC: UIViewController {
//    // MARK: - Properties
//    private var extractedColors: [UIColor] = []
//    var image: UIImage?
//    @IBOutlet weak var exitButtonView: UIButton!
//    @IBOutlet weak var saveButtonView: UIButton!
//    @IBOutlet weak var imageView: UIImageView!
//    @IBOutlet weak var collectionView: UICollectionView!
//    
//    @IBOutlet weak var rSliderOutlet: UISlider!
//    @IBOutlet weak var rSliderResult: UILabel!
//    @IBOutlet weak var rSliderResultView: UIView!
//    @IBOutlet weak var gSliderOutlet: UISlider!
//    @IBOutlet weak var gSliderResult: UILabel!
//    @IBOutlet weak var gSliderResultView: UIView!
//    @IBOutlet weak var bSliderOutlet: UISlider!
//    @IBOutlet weak var bSliderResult: UILabel!
//    @IBOutlet weak var bSliderResultView: UIView!
//    @IBOutlet weak var finalHexaCode: UILabel!
//    
//    // MARK: - Lifecycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupView()
//        setupCollectionView()
//        displayImage()
//        extractColors()
//        exitButtonView.layer.cornerRadius = exitButtonView.frame.height / 2
//        exitButtonView.clipsToBounds = true
//        sliderResultContainers()
//        
//    }
//    
//    @IBAction func exitButton(_ sender: UIButton) {
//        dismiss(animated: true)
//    }
//    
//    @IBAction func savePalettes(_ sender: UIButton) {
//        // Implement save functionality
//    }
//    
//    @IBAction func rSlider(_ sender: UISlider) {}
//    @IBAction func gSlider(_ sender: UISlider) {}
//    @IBAction func bSlider(_ sender: UISlider) {}
//    
//    // MARK: - Private Methods
//    private func setupView() {
//        view.backgroundColor = .white
//    }
//    
//    private func setupCollectionView() {
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        collectionView.isScrollEnabled = true
//        collectionView.showsVerticalScrollIndicator = false
//        collectionView.showsHorizontalScrollIndicator = false
//        
//        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
//            layout.scrollDirection = .horizontal
//        }
//    }
//    
//    private func displayImage() {
//        guard let image = image else {
//            print("No image provided to UploadedImagePalettesVC")
//            return
//        }
//        imageView.image = image
//        imageView.contentMode = .scaleAspectFit
//    }
//    
//    private func extractColors() {
//        guard let image = image else { return }
//        
//        // Extract 5 distinct dominant colors
//        if let colors = image.extractDominantColors(count: 5) {
//            extractedColors = colors
//            print("Extracted colors: \(colors.map { $0.toHexString() })")
//            collectionView.reloadData()
//        }
//    }
//}
//
//// MARK: - UICollectionViewDelegate & DataSource
//extension UploadedImagePalettesVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        print("Number of extracted colors: \(extractedColors.count)")
//        return extractedColors.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCellInUploadedImagePalettesVC",
//                                                          for: indexPath) as? CollectionViewCellInUploadedImagePalettesVC else {
//            fatalError("Unable to dequeue CollectionViewCellInUploadedImagePalettesVC. Verify the identifier in storyboard.")
//        }
//        let color = extractedColors[indexPath.item]
//        cell.colorView.backgroundColor = color
//        cell.hexaCodeLabel.text = color.toHexString()
//        cell.hexaCodeLabel.textColor = .black
//        
//        return cell
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: collectionView.frame.size.width / 5, height: (collectionView.frame.size.height ) )
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 10
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//    
//
//    func sliderResultContainers(){
//        
//        rSliderResultView.layer.cornerRadius = 5.0 // Adjust the value as needed
//
//        // Add border
//        rSliderResultView.layer.borderWidth = 1.0 // Border thickness
//        rSliderResultView.layer.borderColor = UIColor.red.cgColor // Border color (change as needed)
//
//        // Optional: Ensure the view clips to its bounds if you have subviews
//        rSliderResultView.clipsToBounds = true
//        gSliderResultView.layer.cornerRadius = 5.0 // Adjust the value as needed
//
//        // Add border
//        gSliderResultView.layer.borderWidth = 1.0 // Border thickness
//        gSliderResultView.layer.borderColor = UIColor.green.cgColor // Border color (change as needed)
//
//        // Optional: Ensure the view clips to its bounds if you have subviews
//        gSliderResultView.clipsToBounds = true
//        bSliderResultView.layer.cornerRadius = 5.0 // Adjust the value as needed
//
//        // Add border
//        bSliderResultView.layer.borderWidth = 1.0 // Border thickness
//        bSliderResultView.layer.borderColor = UIColor.blue.cgColor // Border color (change as needed)
//
//        // Optional: Ensure the view clips to its bounds if you have subviews
//        bSliderResultView.clipsToBounds = true
//    }
//}
//
//// MARK: - UIImage Extension for Distinct Color Extraction
//extension UIImage {
//    func extractDominantColors(count: Int = 5) -> [UIColor]? {
//        guard let cgImage = self.cgImage else { return nil }
//        
//        // Resize image for performance
//        let size = CGSize(width: 100, height: 100)
//        let width = Int(size.width)
//        let height = Int(size.height)
//        
//        guard let context = CGContext(
//            data: nil,
//            width: width,
//            height: height,
//            bitsPerComponent: 8,
//            bytesPerRow: 0,
//            space: CGColorSpaceCreateDeviceRGB(),
//            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
//        ) else { return nil }
//        
//        context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
//        guard let pixelData = context.data else { return nil }
//        let data = pixelData.bindMemory(to: UInt8.self, capacity: width * height * 4)
//        
//        // Collect color samples
//        var colors: [(r: CGFloat, g: CGFloat, b: CGFloat, count: Int)] = []
//        for y in 0..<height {
//            for x in 0..<width {
//                let pixelIndex = (y * width + x) * 4
//                let r = CGFloat(data[pixelIndex]) / 255.0
//                let g = CGFloat(data[pixelIndex + 1]) / 255.0
//                let b = CGFloat(data[pixelIndex + 2]) / 255.0
//                let a = CGFloat(data[pixelIndex + 3]) / 255.0
//                
//                if a > 0.1 { // Skip nearly transparent pixels
//                    colors.append((r: r, g: g, b: b, count: 1))
//                }
//            }
//        }
//        
//        // Simplified k-means clustering to find distinct colors
//        guard colors.count > 0 else { return nil }
//        var clusters = initialClusters(colors: colors, count: min(count, colors.count))
//        for _ in 0..<20 { // Iterate to refine clusters (10 iterations for simplicity)
//            clusters = updateClusters(colors: colors, clusters: clusters)
//        }
//        
//        // Convert clusters to UIColor
//        return clusters.map { UIColor(red: $0.r, green: $0.g, blue: $0.b, alpha: 1.0) }
//    }
//    
//    private func initialClusters(colors: [(r: CGFloat, g: CGFloat, b: CGFloat, count: Int)], count: Int) -> [(r: CGFloat, g: CGFloat, b: CGFloat, count: Int)] {
//        var shuffled = colors.shuffled()
//        return Array(shuffled.prefix(count))
//    }
//    
//    private func updateClusters(colors: [(r: CGFloat, g: CGFloat, b: CGFloat, count: Int)], clusters: [(r: CGFloat, g: CGFloat, b: CGFloat, count: Int)]) -> [(r: CGFloat, g: CGFloat, b: CGFloat, count: Int)] {
//        var newClusters: [[(r: CGFloat, g: CGFloat, b: CGFloat, count: Int)]] = Array(repeating: [], count: clusters.count)
//        
//        // Assign each color to the nearest cluster
//        for color in colors {
//            let closestClusterIndex = clusters.enumerated().min(by: {
//                distance($0.element, color) < distance($1.element, color)
//            })?.offset ?? 0
//            newClusters[closestClusterIndex].append(color)
//        }
//        
//        // Calculate new cluster centroids
//        return newClusters.map { cluster in
//            guard !cluster.isEmpty else { return (r: 0, g: 0, b: 0, count: 0) }
//            let total = cluster.reduce((r: 0.0, g: 0.0, b: 0.0, count: 0)) { (acc, color) in
//                (r: acc.r + color.r, g: acc.g + color.g, b: acc.b + color.b, count: acc.count + color.count)
//            }
//            let count = CGFloat(total.count)
//            return (r: total.r / count, g: total.g / count, b: total.b / count, count: total.count)
//        }
//    }
//    
//    private func distance(_ a: (r: CGFloat, g: CGFloat, b: CGFloat, count: Int), _ b: (r: CGFloat, g: CGFloat, b: CGFloat, count: Int)) -> CGFloat {
//        let dr = a.r - b.r
//        let dg = a.g - b.g
//        let db = a.b - b.b
//        return dr * dr + dg * dg + db * db // Euclidean distance squared
//    }
//    
//  
//}
//
//// MARK: - UIColor Extension
//extension UIColor {
//    func toHexString() -> String {
//        var r: CGFloat = 0
//        var g: CGFloat = 0
//        var b: CGFloat = 0
//        var a: CGFloat = 0
//        
//        getRed(&r, green: &g, blue: &b, alpha: &a)
//        
//        let rgb: Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
//        return String(format: "#%06x", rgb)
//    }
//}

import UIKit
import CoreImage

class UploadedImagePalettesVC: UIViewController {
    // MARK: - Properties
    private var extractedColors: [UIColor] = []
    var image: UIImage?
    
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
        // Implement save functionality here if needed
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
            print("Extracted colors: \(colors.map { $0.toHexString() })")
            collectionView.reloadData()
            
            // Select the first color by default
            if !extractedColors.isEmpty {
                let indexPath = IndexPath(item: 0, section: 0)
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
    }
}

// MARK: - UICollectionViewDelegate & DataSource
extension UploadedImagePalettesVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Number of extracted colors: \(extractedColors.count)")
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
            cell.layer.cornerRadius = 10.0 // Add corner radius here
            cell.clipsToBounds = true
            cell.layer.borderColor = UIColor.gray.cgColor
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCellInUploadedImagePalettesVC {
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
        return String(format: "%06x", rgb)
    }
}

