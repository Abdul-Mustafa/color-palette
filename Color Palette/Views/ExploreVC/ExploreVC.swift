

import UIKit


class ExploreVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colorPalettesKeys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExploreTableViewCell", for: indexPath) as! ExploreTableViewCell
        cell.colorNameAtTop.text = colorPalettesKeys[indexPath.row]
        cell.configureCell(with: colorPalettes?[colorPalettesKeys[indexPath.row]])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         // Height depends on row
        return tableView.frame.width * 0.5
        }
    
    var colorPalettes: [String : [ColorPalette]]?
    var colorPalettesKeys: [String] = []
    @IBOutlet weak var SubView: UIView!
    
    @IBOutlet weak var tableViewInExploreVC: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        setupSearchController()
        tableViewInExploreVC.dataSource = self
        tableViewInExploreVC.delegate = self
        
        let manager = ColorPaletteManager.shared

              // Get all palettes
        let allPalettes = manager.getAllPalettes()
        colorPalettes = allPalettes
        
        colorPalettesKeys = Array(allPalettes.keys)
        
        

    }

}




// MARK: - Navigation Controller Setup
extension ExploreVC {
    func setupNavigationController() {
        
        
        let titleLabel = UILabel()
        titleLabel.text = "Explore"
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

