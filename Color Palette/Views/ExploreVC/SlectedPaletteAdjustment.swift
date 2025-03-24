//
//  SlectedPaletteAdjustment.swift
//  Color Palette
//
//  Created by mac on 15/03/2025.
//

import UIKit

class SlectedPaletteAdjustment: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Properties
    var selectedColor: ColorPalette?
    private var selectedIndexPath: IndexPath?
    
    // MARK: - IBOutlets
    @IBOutlet weak var colorCodeInBottom: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var colorTitle: UILabel!
    @IBOutlet weak var exitButtonView: UIButton!
    @IBOutlet weak var rSliderOutlet: UISlider!
    @IBOutlet weak var rSliderResult: UILabel!
    @IBOutlet weak var gSliderOutlet: UISlider!
    @IBOutlet weak var gSliderResult: UILabel!
    @IBOutlet weak var bSliderOutlet: UISlider!
    @IBOutlet weak var bSliderResult: UILabel!
    @IBOutlet weak var copyButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    //
    @IBOutlet weak var rSliderResultView: UIView!

    @IBOutlet weak var gSliderResultView: UIView!

    @IBOutlet weak var bSliderResultView: UIView!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        sliderResultContainers()
        setupView()
        setupCollectionView()
        setupSliders()
        
        colorTitle.text = selectedColor?.name
        
        exitButtonView.layer.cornerRadius = exitButtonView.frame.height / 2
        exitButtonView.clipsToBounds = true
    
        
        // Select first item by default
        if selectedColor?.colors.count ?? 0 > 0 {
            let indexPath = IndexPath(item: 0, section: 0)
            selectedIndexPath = indexPath
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .left)
            collectionView(self.collectionView, didSelectItemAt: indexPath)
        }
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
           layout.estimatedItemSize = .zero
        }
        NotificationCenter.default.addObserver(
                    self,
                    selector: #selector(showPremiumScreen),
                    name: CoreDataManager.showPremiumScreenNotification,
                    object: nil
                )
    }
    @objc func showPremiumScreen() {
            let vc = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: "ProScreenVC") as! ProScreenVC
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }

        deinit {
            // Remove both observers
            NotificationCenter.default.removeObserver(self, name: CoreDataManager.paletteDidChangeNotification, object: nil)
            NotificationCenter.default.removeObserver(self, name: CoreDataManager.showPremiumScreenNotification, object: nil)
        }
    // MARK: - Setup Methods
    private func setupView() {
        view.backgroundColor = .white
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
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
        colorCodeInBottom.text = "#000000"
    }
    
    // MARK: - IBActions
    @IBAction func exitButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func copyButtonAtBottom(_ sender: Any) {
        guard let hexCode = colorCodeInBottom.text else { return }
        UIPasteboard.general.string = hexCode
        
        let originalText = colorCodeInBottom.text
        colorCodeInBottom.text = "Copied!"
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.colorCodeInBottom.text = originalText
        }
    }
    
    @IBAction func saveButton(_ sender: Any) {
        guard let hexCode = colorCodeInBottom.text else { return }
        
        if CoreDataManager.shared.isSingleColorSaved(name: hexCode) {
            showToast(message: "Color already saved!")
            let originalText = colorCodeInBottom.text
            colorCodeInBottom.text = "Color already saved!"
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.colorCodeInBottom.text = originalText
            }
        } else {
            CoreDataManager.shared.saveSingleColor(name: hexCode)
            showToast(message: "Color saved!")
            let originalText = colorCodeInBottom.text
            colorCodeInBottom.text = "Color saved!"
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.colorCodeInBottom.text = originalText
            }
        }
    }
    
    @IBAction func shareButton(_ sender: Any) {
        guard let hexCode = colorCodeInBottom.text else { return }
        let activityVC = UIActivityViewController(activityItems: ["Check out this color: \(hexCode)"], applicationActivities: nil)
        present(activityVC, animated: true)
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
    
    // MARK: - Private Methods
    private func updateFinalColor() {
        let r = CGFloat(rSliderOutlet.value) / 255.0
        let g = CGFloat(gSliderOutlet.value) / 255.0
        let b = CGFloat(bSliderOutlet.value) / 255.0
        let color = UIColor(red: r, green: g, blue: b, alpha: 1.0)
        colorCodeInBottom.text = color.toHexString()
        
        if let indexPath = selectedIndexPath,
           let cell = collectionView.cellForItem(at: indexPath) as? AdjustmentVCCollectionViewCell {
            cell.colorView.backgroundColor = color
            cell.hexaCodeLabel.text = color.toHexString()
        }
    }
    
    private func showToast(message: String, duration: TimeInterval = 2.0) {
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
        
        let maxWidth = self.view.frame.size.width * 0.7
        let textSize = toastLabel.sizeThatFits(CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude))
        toastLabel.frame = CGRect(x: 0, y: 0, width: textSize.width + 40, height: textSize.height + 20)
        toastLabel.center = self.view.center
        
        self.view.addSubview(toastLabel)
        
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
    
    // MARK: - UICollectionView DataSource & Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedColor?.colors.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdjustmentVCCollectionViewCell", for: indexPath) as! AdjustmentVCCollectionViewCell
        let colorHex = selectedColor?.colors[indexPath.row] ?? "#FFFFFF"
        
        cell.colorView.backgroundColor = UIColor(hexString: colorHex)
        cell.hexaCodeLabel.text = colorHex
        print(cell.hexaCodeLabel.text)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Restore previous cell
        if let previousIndexPath = selectedIndexPath,
           previousIndexPath != indexPath,
           let previousCell = collectionView.cellForItem(at: previousIndexPath) as? AdjustmentVCCollectionViewCell {
            let originalColor = UIColor(hexString: selectedColor?.colors[previousIndexPath.item] ?? "#FFFFFF")
            previousCell.colorView.backgroundColor = originalColor
            previousCell.hexaCodeLabel.text = selectedColor?.colors[previousIndexPath.item]
            previousCell.layer.borderWidth = 0.0
        }
        
        // Update new selection
        let selectedColorHex = selectedColor?.colors[indexPath.item] ?? "#FFFFFF"
        let color = UIColor(hexString: selectedColorHex)
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        color.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        rSliderOutlet.value = Float(r * 255)
        gSliderOutlet.value = Float(g * 255)
        bSliderOutlet.value = Float(b * 255)
        
        rSliderResult.text = String(format: "%.0f", r * 255)
        gSliderResult.text = String(format: "%.0f", g * 255)
        bSliderResult.text = String(format: "%.0f", b * 255)
        
        colorCodeInBottom.text = color.toHexString()
        
        if let cell = collectionView.cellForItem(at: indexPath) as? AdjustmentVCCollectionViewCell {
            cell.layer.borderWidth = 2.0
            cell.layer.cornerRadius = 10.0
            cell.clipsToBounds = true
            cell.layer.borderColor = UIColor.gray.cgColor
        }
        
        selectedIndexPath = indexPath
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 5, height: collectionView.frame.size.height)
    }
}

