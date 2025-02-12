//
//  ExploreVC.swift
//  Color Palette
//
//  Created by mac on 08/02/2025.
//

import UIKit

//class ExploreVC: UIViewController {
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        let nib = UINib(nibName: "TopBarClass", bundle: nil)
//        if let customView = nib.instantiate(withOwner: self, options: nil).first as? UIView {
//            customView.frame = self.view.bounds
//            self.view.addSubview(customView)
//            // Do any additional setup after loading the view.
//        }
//        
//        
//        /*
//         // MARK: - Navigation
//         
//         // In a storyboard-based application, you will often want to do a little preparation before navigation
//         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//         // Get the new view controller using segue.destination.
//         // Pass the selected object to the new view controller.
//         }
//         */
//        
//    }
//}



import UIKit


class ExploreVC: UIViewController {
    
    
   var referenceForTopBar : TopBar?

    @IBOutlet weak var SubView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // update xib inside viewTop
        if let refrenceForViewTop = Bundle.main.loadNibNamed("TopBar", owner: self
                                                             , options: nil)?.first as? TopBar {
        
            SubView.addSubview(refrenceForViewTop)
            
            refrenceForViewTop.frame.size.height = SubView.frame.size.height
            refrenceForViewTop.frame.size.width = SubView.frame.size.width
          referenceForTopBar = refrenceForViewTop
        }


        

    }

}


extension ExploreVC : SubViewDelegate {
    func didTapOnMe(name: String, showMe updateMe: String) {
       
        print(name,updateMe)
        
    }
}
