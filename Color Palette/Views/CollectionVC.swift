////
////  CollectionVC.swift
////  Color Palette
////
////  Created by mac on 12/02/2025.
////
//
//
//import UIKit
//
//
//class CollectionVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
//    
//    var favNamedColorPalettes: [FavNamedColorPalettes] = []
//
//
//    @IBOutlet weak var SubView: UIView!
//    
//    @IBOutlet weak var tableViewInCollectonVC: UITableView!
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        tableViewInCollectonVC.delegate = self
//        tableViewInCollectonVC.dataSource = self
//        setupNavigationController()
//        setupSearchController()
//        fetchFavorites()
//       print(favNamedColorPalettes)
//    }
//    func fetchFavorites() {
//           favNamedColorPalettes = CoreDataManager.shared.fetchFavorites()
//        tableViewInCollectonVC.reloadData()
//       }
//    // MARK: - TableView DataSource
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return favNamedColorPalettes.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "TopTableViewCellInCollectionVC", for: indexPath) as! TopTableViewCellInCollectionVC
//        let palette = favNamedColorPalettes[indexPath.row]
//        if let colorArray = palette.colors as? [String], let firstColor = colorArray.first {
//            cell.colorTitleInTopView.text = palette.name
//            cell.colorTitleInTopView.textColor = UIColor(hex: firstColor)
//            cell.colorTitleInColorSideBar.text = palette.name
//            cell.colorTitleInColorSideBar.textColor = .white
//            cell.hexaCodeInColorSideBar.text = firstColor
//            cell.hexaCodeInColorSideBar.textColor = .white
//            cell.ellipsisButtonInColorSideBar.tintColor = .white
//            cell.colorSideBarContainer.backgroundColor = UIColor(hex: firstColor)
//            cell.heartButtonInTopView.tintColor = UIColor(hex: firstColor)
//            cell.underLine.backgroundColor = UIColor(hex: firstColor)
//          //  cell.configureCell(with: palette.colors ?? [])
//        }
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        
//            return tableView.frame.width * 0.8
//        
//    }
//    
//}
//
//
//
//// MARK: - Navigation Controller Setup
//extension CollectionVC {
//    func setupNavigationController() {
//        
//        
//        let titleLabel = UILabel()
//        titleLabel.text = "Home"
//        titleLabel.textColor = .white
//        titleLabel.font = UIFont.boldSystemFont(ofSize: 40)
//        titleLabel.textAlignment = .center
//        titleLabel.sizeToFit()
//
//
//        navigationItem.titleView = titleLabel
//
//        let boldConfig = UIImage.SymbolConfiguration(weight: .bold)
//        let listImage = UIImage(systemName: "list.bullet", withConfiguration: boldConfig)
//        
//        let listButton = UIBarButtonItem(
//            image: listImage,
//            style: .plain,
//            target: self,
//            action: #selector(listButtonTapped)
//        )
//
//        listButton.tintColor = .white
//        navigationItem.rightBarButtonItem = listButton
//    }
//
//
//    @objc func listButtonTapped() {
//        print("List button tapped")
//    }
//}
//
//// MARK: - Search Controller Setup
//extension CollectionVC: UISearchResultsUpdating {
//    func setupSearchController() {
//        let searchController = UISearchController(searchResultsController: nil)
//        searchController.searchResultsUpdater = self
//        searchController.obscuresBackgroundDuringPresentation = false
//        searchController.searchBar.placeholder = "Search Colors"
//        searchController.searchBar.searchTextField.backgroundColor = UIColor.white
//    
//        navigationItem.searchController = searchController
//        definesPresentationContext = true
//    }
//
//    func updateSearchResults(for searchController: UISearchController) {
//        guard let text = searchController.searchBar.text, !text.isEmpty else {
//            return
//        }
//        print("Search Query: \(text)")
//    }
//}
//
//
//

import UIKit

class CollectionVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var favNamedColorPalettes: [FavNamedColorPalettes] = []
    @IBOutlet weak var SubView: UIView!
    @IBOutlet weak var tableViewInCollectonVC: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewInCollectonVC.delegate = self
        tableViewInCollectonVC.dataSource = self
        setupNavigationController()
        setupSearchController()
        fetchFavorites()
        
        // Add observer for palette changes
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(refreshFavorites),
            name: CoreDataManager.paletteDidChangeNotification,
            object: nil
        )
    }
    
    func fetchFavorites() {
        favNamedColorPalettes = CoreDataManager.shared.fetchFavorites()
        tableViewInCollectonVC.reloadData()
        print("Fetched favorites: \(favNamedColorPalettes.map { $0.name ?? "nil" })")
    }
    
    @objc func refreshFavorites() {
        fetchFavorites()
        print("Favorites refreshed in CollectionVC")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favNamedColorPalettes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopTableViewCellInCollectionVC", for: indexPath) as! TopTableViewCellInCollectionVC
        let palette = favNamedColorPalettes[indexPath.row]
        if let colorArray = palette.colors as? [String], let firstColor = colorArray.first {
            cell.colorTitleInTopView.text = palette.name
            cell.colorTitleInTopView.textColor = UIColor(hex: firstColor)
            cell.colorTitleInColorSideBar.text = palette.name
            cell.colorTitleInColorSideBar.textColor = .white
            cell.hexaCodeInColorSideBar.text = firstColor
            cell.hexaCodeInColorSideBar.textColor = .white
            cell.ellipsisButtonInColorSideBar.tintColor = .white
            cell.colorSideBarContainer.backgroundColor = UIColor(hex: firstColor)
            cell.heartButtonInTopView.tintColor = UIColor(hex: firstColor)
            cell.underLine.backgroundColor = UIColor(hex: firstColor)
            // Uncomment if configureCell is implemented
            cell.configureCell(with: colorArray)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.width * 0.8
    }
}

// MARK: - Navigation Controller Setup
extension CollectionVC {
    func setupNavigationController() {
        let titleLabel = UILabel()
        titleLabel.text = "Favorites" // Changed to "Favorites" for clarity
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
extension CollectionVC: UISearchResultsUpdating {
    func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Favorites"
        searchController.searchBar.searchTextField.backgroundColor = UIColor.white
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text, !text.isEmpty else {
            fetchFavorites() // Reset to full list when search is cleared
            return
        }
        print("Search Query: \(text)")
        // Add filtering logic if desired
    }
}
