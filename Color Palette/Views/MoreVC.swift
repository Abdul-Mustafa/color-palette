//
//  MoreVC.swift
//  Color Palette
//
//  Created by mac on 12/02/2025.
//

import UIKit


class MoreVC: UIViewController {
    
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var profileArrow: UIImageView!
    @IBOutlet weak var SecondView: UIView!
    @IBOutlet weak var languageArrow: UIImageView!
    @IBOutlet weak var ThirdView: UIView!
    @IBOutlet weak var premiumLabel: UIView!
    var referenceForTopBar : TopBar?

    @IBOutlet weak var SubView: UIView!
    
    @IBOutlet weak var navigationArrow: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // update xib inside viewTop
        if let refrenceForViewTop = Bundle.main.loadNibNamed("TopBar", owner: self
                                                             , options: nil)?.first as? TopBar {
        
            SubView.addSubview(refrenceForViewTop)
            
            refrenceForViewTop.frame.size.height = SubView.frame.size.height
            refrenceForViewTop.frame.size.width = SubView.frame.size.width
            referenceForTopBar = refrenceForViewTop
            referenceForTopBar?.title.text = "Settings"
            
            premiumLabel.layer.borderWidth = 2.0
            premiumLabel.layer.borderColor = UIColor(hex: "#F24674").cgColor
            premiumLabel.layer.cornerRadius = 10
            navigationArrow.transform = CGAffineTransform(rotationAngle: .pi / 2)
            
            firstViewFunctinality()
            SecondViewFunctinality()
            thirdViewFunctinality()
        }


        

    }

}


extension MoreVC : SubViewDelegate {
    func didTapOnMe(name: String, showMe updateMe: String) {
       
        print(name,updateMe)
        
    }
}
 







extension MoreVC{
    
    
    func firstViewFunctinality(){
        
        firstView.layer.cornerRadius = 10
        profileArrow.transform = CGAffineTransform(rotationAngle: .pi / 2)
    }
}


extension MoreVC{
    
    
    func SecondViewFunctinality(){
        
        SecondView.layer.cornerRadius = 10
        languageArrow.transform = CGAffineTransform(rotationAngle: .pi / 2)
    }
}

extension MoreVC{
    
    
    func thirdViewFunctinality(){
        
        ThirdView.layer.cornerRadius = 10
    }
}






extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if hexSanitized.hasPrefix("#") {
            hexSanitized.remove(at: hexSanitized.startIndex)
        }
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let r = CGFloat((rgb >> 16) & 0xFF) / 255.0
        let g = CGFloat((rgb >> 8) & 0xFF) / 255.0
        let b = CGFloat(rgb & 0xFF) / 255.0
        
        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
}
