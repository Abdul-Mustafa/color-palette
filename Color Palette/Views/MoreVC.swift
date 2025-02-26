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
    

    @IBOutlet weak var SubView: UIView!
    
    @IBOutlet weak var navigationArrow: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        setupSearchController()
        // update xib inside viewTop
       
            
           
            
            premiumLabel.layer.borderWidth = 2.0
            premiumLabel.layer.borderColor = UIColor(hex: "#F24674").cgColor
            premiumLabel.layer.cornerRadius = 10
            navigationArrow.transform = CGAffineTransform(rotationAngle: .pi / 2)
            
            firstViewFunctinality()
            SecondViewFunctinality()
            thirdViewFunctinality()
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









// MARK: - Navigation Controller Setup
extension MoreVC {
    func setupNavigationController() {
        
        
        let titleLabel = UILabel()
        titleLabel.text = "Settings"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 40)
        titleLabel.textAlignment = .center
        titleLabel.sizeToFit()


        navigationItem.titleView = titleLabel

        let boldConfig = UIImage.SymbolConfiguration(weight: .bold)
        let listImage = UIImage(systemName: "list.bullet", withConfiguration: boldConfig)
        
        let listButton = UIBarButtonItem(
            image: listImage,
            style: .plain,
            target: self,
            action: #selector(listButtonTapped)
        )

        listButton.tintColor = .white
        navigationItem.rightBarButtonItem = listButton
    }


    @objc func listButtonTapped() {
        print("List button tapped")
    }
}

// MARK: - Search Controller Setup
extension MoreVC:  UISearchResultsUpdating {
    func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Colors"
        searchController.searchBar.searchTextField.backgroundColor = UIColor.white
    
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    public func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text, !text.isEmpty else {
            return
        }
        print("Search Query: \(text)")
    }
}

