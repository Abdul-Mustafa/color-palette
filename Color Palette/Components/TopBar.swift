//
//  TopBar.swift
//  Color Palette
//
//  Created by mac on 11/02/2025.
//


import UIKit

@objc protocol SubViewDelegate {
    func didTapOnMe( name : String , showMe : String)
}

class TopBar: UIView {

    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var topOptionButton: UIButton!
    var subViewDelegate : SubViewDelegate!
    
    override func awakeFromNib() {
        
   
    }
    
    @IBAction func topOptionButtonAction(_ sender: Any) {
      
    }
    
    func subViewXibInit(imageName: String, text: String, buttonName: String){
    
    }
    
}
