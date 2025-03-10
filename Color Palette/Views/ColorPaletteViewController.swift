//
//  Untitled.swift
//  Color Palette
//
//  Created by mac on 10/03/2025.
//

import UIKit
import CoreImage

class ColorPaletteViewController: UIViewController {
    
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        displayImage()
        extractColors()
    }
    
    private func displayImage() {
        guard let image = image else { return }
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 300),
            imageView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    private func extractColors() {
        guard let image = image, let ciImage = CIImage(image: image) else { return }
        
        let filter = CIFilter(name: "CIAreaAverage")!
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        
        guard let outputImage = filter.outputImage else { return }
        
        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext()
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: CGColorSpaceCreateDeviceRGB())
        
        let color = UIColor(red: CGFloat(bitmap[0]) / 255, green: CGFloat(bitmap[1]) / 255, blue: CGFloat(bitmap[2]) / 255, alpha: 1)
        
        let colorView = UIView()
        colorView.backgroundColor = color
        colorView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(colorView)
        
        NSLayoutConstraint.activate([
            colorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 350),
            colorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            colorView.widthAnchor.constraint(equalToConstant: 100),
            colorView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}
