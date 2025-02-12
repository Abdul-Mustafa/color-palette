import UIKit


class ViewController: UIViewController {
    
    
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


extension ViewController : SubViewDelegate {
    func didTapOnMe(name: String, showMe updateMe: String) {
       
        print(name,updateMe)
        
    }
}
