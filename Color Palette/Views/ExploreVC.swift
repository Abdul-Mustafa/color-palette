

import UIKit


class ExploreVC: UIViewController {
    
    


    @IBOutlet weak var SubView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        setupSearchController()
        // update xib inside viewTop
   

    

        

    }

}




// MARK: - Navigation Controller Setup
extension ExploreVC {
    func setupNavigationController() {
        
        
        let titleLabel = UILabel()
        titleLabel.text = "Home"
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
extension ExploreVC: UISearchResultsUpdating {
    func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Colors"
        searchController.searchBar.searchTextField.backgroundColor = UIColor.white
    
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text, !text.isEmpty else {
            return
        }
        print("Search Query: \(text)")
    }
}

