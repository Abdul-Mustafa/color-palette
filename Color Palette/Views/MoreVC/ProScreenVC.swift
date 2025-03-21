//
//  ProScreenVC.swift
//  Color Palette
//
//  Created by mac on 21/03/2025.
//

import UIKit
import StoreKit
import SVProgressHUD


class ProScreenVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var plans = ["WEEKLY", "MONTHLY", "YEARLY","LIFETIME"]
    var planType: [String] = ["Basic Plan", "3 Day Free Trial", "Popular","Recommended"]
//    var planDetail: [String] = ["Per Day", "Per Week", "Per Month"/*, "50% off"*/]
    var productList = [weeklySub,monthlySub,yearlySub,lifeTimeProduct]
    
    var amount = [3.99, 9.99, 19.99, 39.99]
    let offDays = [7, 4, 12, 1]
    var selectedProduct = 1
    var previousCell: ProScreenCollectionViewCell?
    var price: String?
    var planAmount: [Double] = []
    var attributeString: NSAttributedString?
    var freestring: NSAttributedString?
    
    
    @IBOutlet weak var restoreBtn: UIButton!
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var planCollectionView: UICollectionView!
    
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        planCollectionView.reloadData()
//        applyGradientToButton()
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        planCollectionView.reloadData()
//        applyGradientToButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeButton()
        findValues()
        continueBtn.layer.cornerRadius = 10
        planCollectionView.delegate = self
        planCollectionView.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadProduct(notifiaction: )), name: .loadProduct, object: nil)
//        applyGradientToButton()
    }
    
    // MARK: COLLECTION VIEW
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProScreenCollectionViewCell", for: indexPath) as! ProScreenCollectionViewCell
        
        cell.planDuration.text = plans[indexPath.row]
        cell.planType.text = planType[indexPath.row]
        
        if let prod = getSelectedPro(id: productList[indexPath.item]) {
//            cell.planDetailLbl.attributedText = nil
            cell.planPricing.text = prod.localizedPrice ?? ""
//            cell.planDetailLbl.text = "\((prod.priceLocale.currencySymbol ?? "") + " " + String(format: "%.2f", self.setOffPrice(price: prod.price.doubleValue, days: offDays[indexPath.item]))) \(planDetail[indexPath.item])"
            
            if indexPath.item == 3 {
                let lifetimePrice = (prod.priceLocale.currencySymbol ?? "") + " " + String(format: "%.2f", (prod.price.doubleValue * 2))
//                cell.planDetailLbl.text = lifetimePrice
                let fontSize: CGFloat
                if UIDevice.current.userInterfaceIdiom == .phone {
                    fontSize = 16
                } else {
                    fontSize = 25
                }
                let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: lifetimePrice, attributes: [
                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize),
                    NSAttributedString.Key.strikethroughStyle: 2,
                    NSAttributedString.Key.strikethroughColor: UIColor.red
                ])
//                cell.planDetailLbl.attributedText = attributeString
            }
        } else {
//            cell.planDetailLbl.attributedText = nil
            cell.planPricing.text = "$ " + String(amount[indexPath.item])
//            cell.planDetailLbl.text = "\("$" + " " + String(format: "%.2f", self.setOffPrice(price: amount[indexPath.item], days: offDays[indexPath.item]))) \(planDetail[indexPath.item])"
            
            if indexPath.item == 3 {
                let lifetimePrice = "$" + " " + String(format: "%.2f", (amount[indexPath.item] * 2))
//                cell.planDetailLbl.text = lifetimePrice
                let fontSize: CGFloat
                if UIDevice.current.userInterfaceIdiom == .phone {
                    fontSize = 16
                } else {
                    fontSize = 25
                }
                let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: lifetimePrice, attributes: [
                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize),
                    NSAttributedString.Key.strikethroughStyle: 2,
                    NSAttributedString.Key.strikethroughColor: UIColor.red
                ])
            }
        }
        
        if indexPath.item == 1 {
            cell.trialview.isHidden = false
        } else {
            cell.trialview.isHidden = true
        }
        
        // Apply gradient to selected cell (background and border)
        if selectedProduct == indexPath.item {
            cell.layer.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.2745098039, blue: 0.4549019608, alpha: 1)
            cell.planDuration.textColor = UIColor.white
            cell.planType.textColor = UIColor.white
            cell.planPricing.textColor = UIColor.white
        } else {
            cell.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            cell.layer.borderColor = #colorLiteral(red: 0.9490196078, green: 0.2745098039, blue: 0.4549019608, alpha: 1)
            cell.planDuration.textColor = #colorLiteral(red: 0.9490196078, green: 0.2745098039, blue: 0.4549019608, alpha: 1)
            cell.planType.textColor = #colorLiteral(red: 0.9490196078, green: 0.2745098039, blue: 0.4549019608, alpha: 1)
            cell.planPricing.textColor = #colorLiteral(red: 0.9490196078, green: 0.2745098039, blue: 0.4549019608, alpha: 1)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (collectionView.frame.height / 4) - 10
        return CGSize(width: collectionView.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == planCollectionView {
            continueBtn.isEnabled = true
            selectedProduct = indexPath.item
            var size = 0
            if UIDevice.current.userInterfaceIdiom == .phone {
                size = 18
            } else{
                size = 22
            }
            if indexPath.item == 1{
                changeButton()
            } else if indexPath.item == 0{
                let str = NSAttributedString(string: "SUBSCRIBE", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: CGFloat(size))])
                continueBtn.setAttributedTitle(str, for: .normal)
            } else if indexPath.item == 2{
                let str = NSAttributedString(string: "SUBSCRIBE NOW", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: CGFloat(size))])
                continueBtn.setAttributedTitle(str, for: .normal)
            } else {
                let str = NSAttributedString(string: "CONTINUE", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: CGFloat(size))])
                continueBtn.setAttributedTitle(str, for: .normal)
            }
            planCollectionView.reloadData()
            
        }
    }
    
    
    // MARK: ACTION FUNCTIONS
    
    @IBAction func restorebtn(_ sender: Any) {
        SVProgressHUD.show(withStatus: "Please wait...")
        
        SwiftyStoreKit.restorePurchases { results in
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
                
                if results.restoredPurchases.count > 0 {
                  // If lifetime id found, make user pro
                    let filterLifeTimeIDs = results.restoredPurchases.filter { purchase in
                        lifeTimeProduct.contains(purchase.productId)
                    }
                    
                    if filterLifeTimeIDs.isEmpty {
                        userDefaults.set(false, forKey: IS_LIFETIME_USER)
                    } else {
                        NotificationCenter.default.post(name: .purchaseCheck, object: nil)
                        self.dismiss(animated: true)
                        userDefaults.set(true, forKey: IS_LIFETIME_USER)
                    }
                }
            }
        }
    }

    @IBAction func freeBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func continueBtn(_ sender: Any) {
        buyProduct(productId: productList[selectedProduct])
    }
    
    @IBAction func privacyPolicyBtn(_ sender: Any) {
        if let url = URL(string: privacyPolicyLink) {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func termsBtn(_ sender: Any) {
        if let url = URL(string: termsOfUsesLink) {
            UIApplication.shared.open(url)
        }
    }
    
    
    // MARK: OTHER FUNCTIONS
    
    @objc func loadProduct(notifiaction:Notification){
        changeButton()
        planCollectionView.reloadData()
    }
    
    func changeButton() {
        let isIpad = UIDevice.current.userInterfaceIdiom == .pad
        let titleFontSize: CGFloat = isIpad ? 28 : 20
        let subTextFontSize: CGFloat = isIpad ? 22 : 14
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        if let prod = getSelectedPro(id: monthlySub) {
            let amount = prod.localizedPrice ?? ""
            continueBtn.setTitle("", for: .normal)
            
            let str = NSMutableAttributedString()
            let attributeString = NSAttributedString(string: "Try Free For 3 Days", attributes: [
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: titleFontSize),
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.paragraphStyle: paragraphStyle
            ])
            let newLineStr = NSAttributedString(string: "\n")
            let freestring = NSAttributedString(string: "THEN \(amount) PER MONTH", attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: subTextFontSize),
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.paragraphStyle: paragraphStyle
            ])
            
            str.append(attributeString)
            str.append(newLineStr)
            str.append(freestring)
            continueBtn.setAttributedTitle(str, for: .normal)
            
        } else {
            continueBtn.setTitle("", for: .normal)
            
            let str = NSMutableAttributedString()
            let attributeString = NSAttributedString(string: "Try Free For 3 Days", attributes: [
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: titleFontSize),
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.paragraphStyle: paragraphStyle
            ])
            let newLineStr = NSAttributedString(string: "\n")
            let freestring = NSAttributedString(string: "THEN $9.99 PER MONTH", attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: subTextFontSize),
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.paragraphStyle: paragraphStyle
            ])
            
            str.append(attributeString)
            str.append(newLineStr)
            str.append(freestring)
            continueBtn.setAttributedTitle(str, for: .normal)
        }
    }
    
    func findValues(){
        let oneweek = 7
        let oneMonth = 4
        let oneYear = 12
        
        let oneWeekValue = amount[0] / Double(oneweek)
        let roundoneWeekValue = round(100*oneWeekValue)/100
        planAmount.append(roundoneWeekValue)
        
        let oneMonthValue = amount[1] / Double(oneMonth)
        
        let roundoneMonthValue = round(100*oneMonthValue)/100
        
        let oneYearValue = amount[2] / Double(oneYear)
        let roundoneYearValue = round(100*oneYearValue)/100
        
        planAmount.append(roundoneYearValue)
    }
    
    func setOffPrice(price: Double, days: Int) -> Double {
        let oneYearValue = price / Double(days)
        return oneYearValue
    }
    
//    func applyGradientToButton() {
//        if continueBtn.isEnabled {
//            applyGradient(to: continueBtn, colors: [UIColor(hex: "CB22F1"), UIColor(hex: "F83177")])
//            continueBtn.backgroundColor = .clear // Ensure gradient shows
//        } else {
//            continueBtn.backgroundColor = .gray // Default color when disabled
//            continueBtn.layer.sublayers?.filter { $0 is CAGradientLayer }.forEach { $0.removeFromSuperlayer() }
//        }
//    }
        
        // Apply gradient border to cell
//    func applyGradientBorder(to cell: PremiumCell, colors: [UIColor]) {
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.frame = cell.bounds
//        gradientLayer.colors = colors.map { $0.cgColor }
//        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
//        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
//        
//        // Create a shape layer for the border
//        let shapeLayer = CAShapeLayer()
//        shapeLayer.lineWidth = 3
//        shapeLayer.path = UIBezierPath(rect: cell.bounds.insetBy(dx: shapeLayer.lineWidth / 2, dy: shapeLayer.lineWidth / 2)).cgPath
//        shapeLayer.fillColor = UIColor.clear.cgColor
//        gradientLayer.mask = shapeLayer
//        
//        // Add gradient border layer
//        cell.layer.addSublayer(gradientLayer)
//        cell.layer.borderWidth = 0 // Ensure no solid border interferes
//    }
}

// MARK: EXTENSIONS

extension ProScreenVC {
    func buyProduct(productId: String) -> Void {
        SVProgressHUD.show(withStatus: "Please wait...")
        
        guard let product = getSelectedPro(id: productId) else {
            print("Product not found")
            SVProgressHUD.dismiss()
            return
        }
        
        SwiftyStoreKit.purchaseProduct(product, quantity: 1, atomically: true) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    SVProgressHUD.dismiss()
                    if productId == lifeTimeProduct {
                        userDefaults.set(true, forKey: IS_LIFETIME_USER)
                    } else {
                        userDefaults.set(true, forKey: IS_SUBSCRIBED_USER)
                    }
                    NotificationCenter.default.post(name: .purchaseCheck, object: nil)
                    self.dismiss(animated: true, completion: nil)
                }
            case .error(_):
                SVProgressHUD.dismiss()
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: .purchaseCheck, object: nil)
                }
            case .restored(_):
                return
            }
        }
    }
}

func getSelectedPro(id:String)->SKProduct?{
    if let products = appDelegate.products {
        for product in products{
            if product.productIdentifier == id{
                return product
        }
      }
    }
    return nil
}



//
//extension UIView {
//    func applyGradient() {
//        let gradient = CAGradientLayer()
//        gradient.colors = [UIColor.red.cgColor,
//                           UIColor.green.cgColor,
//                           UIColor.black.cgColor]   // your colors go here
//        gradient.locations = [0.0, 0.5, 1.0]
//        gradient.frame = self.bounds
//        self.layer.insertSublayer(gradient, at: 0)
//    }
//}
