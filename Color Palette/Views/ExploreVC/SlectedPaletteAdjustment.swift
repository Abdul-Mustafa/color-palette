//
//  SlectedPaletteAdjustment.swift
//  Color Palette
//
//  Created by mac on 15/03/2025.
//

import UIKit

class SlectedPaletteAdjustment: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        selectedColor?.colors.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "AdjustmentVCCollectionViewCell", for: indexPath) as! AdjustmentVCCollectionViewCell
        cell.colorView.backgroundColor = UIColor(hexString: selectedColor?.colors[indexPath.row] ?? "#FFFFFF")
        cell.hexaCodeLabel.text = selectedColor?.colors[indexPath.row]
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 5, height: collectionView.frame.size.height)
    }
    
    var selectedColor: ColorPalette? // Property to receive the hex code

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var colorTitle: UILabel!
    @IBOutlet weak var exitButtonView: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        colorTitle.text = selectedColor?.name
        exitButtonView.layer.cornerRadius = exitButtonView.frame.height / 2
        exitButtonView.clipsToBounds = true
        view.backgroundColor = .white
        if let color = selectedColor {
            print("Received color: \(color)")
            // Use the color as needed (e.g., set a view's background)
        }
        //
        collectionView.isScrollEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
    
        //
    }
    @IBAction func copyButtonAtBottom(_ sender: Any) {
    }
    @IBAction func exitButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBAction func saveButton(_ sender: Any) {
    }
    @IBAction func shareButton(_ sender: Any) {
    }
    
}
