//////
//////  CollectionVC.swift
//////  Color Palette
//////
//////  Created by mac on 12/02/2025.
//////
////
////
////import UIKit
////
////
////class CollectionVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
////    
////    var favNamedColorPalettes: [FavNamedColorPalettes] = []
////
////
////    @IBOutlet weak var SubView: UIView!
////    
////    @IBOutlet weak var tableViewInCollectonVC: UITableView!
////    override func viewDidLoad() {
////        super.viewDidLoad()
////        tableViewInCollectonVC.delegate = self
////        tableViewInCollectonVC.dataSource = self
////        setupNavigationController()
////        setupSearchController()
////        fetchFavorites()
////       print(favNamedColorPalettes)
////    }
////    func fetchFavorites() {
////           favNamedColorPalettes = CoreDataManager.shared.fetchFavorites()
////        tableViewInCollectonVC.reloadData()
////       }
////    // MARK: - TableView DataSource
////    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
////        return favNamedColorPalettes.count
////    }
////    
////    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////        let cell = tableView.dequeueReusableCell(withIdentifier: "TopTableViewCellInCollectionVC", for: indexPath) as! TopTableViewCellInCollectionVC
////        let palette = favNamedColorPalettes[indexPath.row]
////        if let colorArray = palette.colors as? [String], let firstColor = colorArray.first {
////            cell.colorTitleInTopView.text = palette.name
////            cell.colorTitleInTopView.textColor = UIColor(hex: firstColor)
////            cell.colorTitleInColorSideBar.text = palette.name
////            cell.colorTitleInColorSideBar.textColor = .white
////            cell.hexaCodeInColorSideBar.text = firstColor
////            cell.hexaCodeInColorSideBar.textColor = .white
////            cell.ellipsisButtonInColorSideBar.tintColor = .white
////            cell.colorSideBarContainer.backgroundColor = UIColor(hex: firstColor)
////            cell.heartButtonInTopView.tintColor = UIColor(hex: firstColor)
////            cell.underLine.backgroundColor = UIColor(hex: firstColor)
////          //  cell.configureCell(with: palette.colors ?? [])
////        }
////        return cell
////    }
////    
////    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
////        
////            return tableView.frame.width * 0.8
////        
////    }
////    
////}
////
////
////
////// MARK: - Navigation Controller Setup
////extension CollectionVC {
////    func setupNavigationController() {
////        
////        
////        let titleLabel = UILabel()
////        titleLabel.text = "Home"
////        titleLabel.textColor = .white
////        titleLabel.font = UIFont.boldSystemFont(ofSize: 40)
////        titleLabel.textAlignment = .center
////        titleLabel.sizeToFit()
////
////
////        navigationItem.titleView = titleLabel
////
////        let boldConfig = UIImage.SymbolConfiguration(weight: .bold)
////        let listImage = UIImage(systemName: "list.bullet", withConfiguration: boldConfig)
////        
////        let listButton = UIBarButtonItem(
////            image: listImage,
////            style: .plain,
////            target: self,
////            action: #selector(listButtonTapped)
////        )
////
////        listButton.tintColor = .white
////        navigationItem.rightBarButtonItem = listButton
////    }
////
////
////    @objc func listButtonTapped() {
////        print("List button tapped")
////    }
////}
////
////// MARK: - Search Controller Setup
////extension CollectionVC: UISearchResultsUpdating {
////    func setupSearchController() {
////        let searchController = UISearchController(searchResultsController: nil)
////        searchController.searchResultsUpdater = self
////        searchController.obscuresBackgroundDuringPresentation = false
////        searchController.searchBar.placeholder = "Search Colors"
////        searchController.searchBar.searchTextField.backgroundColor = UIColor.white
////    
////        navigationItem.searchController = searchController
////        definesPresentationContext = true
////    }
////
////    func updateSearchResults(for searchController: UISearchController) {
////        guard let text = searchController.searchBar.text, !text.isEmpty else {
////            return
////        }
////        print("Search Query: \(text)")
////    }
////}
////
////
////
//
//import UIKit
//
//class CollectionVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
//    
//    var favNamedColorPalettes: [FavNamedColorPalettes] = []
//    @IBOutlet weak var SubView: UIView!
//    @IBOutlet weak var tableViewInCollectonVC: UITableView!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        tableViewInCollectonVC.delegate = self
//        tableViewInCollectonVC.dataSource = self
//        setupNavigationController()
//        setupSearchController()
//        fetchFavorites()
//        
//        // Add observer for palette changes
//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(refreshFavorites),
//            name: CoreDataManager.paletteDidChangeNotification,
//            object: nil
//        )
//    }
//    
//    func fetchFavorites() {
//        favNamedColorPalettes = CoreDataManager.shared.fetchFavorites()
//        tableViewInCollectonVC.reloadData()
//        print("Fetched favorites: \(favNamedColorPalettes.map { $0.name ?? "nil" })")
//    }
//    
//    @objc func refreshFavorites() {
//        fetchFavorites()
//        print("Favorites refreshed in CollectionVC")
//    }
//    
//    deinit {
//        NotificationCenter.default.removeObserver(self)
//    }
//    
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
//            // Uncomment if configureCell is implemented
//            cell.configureCell(with: colorArray)
//            let favAction = UIAction(title: "Fav", image: UIImage(systemName: "heart")) { _ in
//                //print("Fav tapped for \(colorArray.name ?? "unknown")")
//            }
//            let lockAction = UIAction(title: "Lock", image: UIImage(systemName: "lock")) { _ in
//                //print("Lock tapped for \(colorArray?.name ?? "unknown")")
//            }
//            let copyAction = UIAction(title: "Copy", image: UIImage(systemName: "doc.on.doc")) { _ in
//               // print("Copied \(colorArray?.name ?? "unknown")")
//            }
//            let shareAction = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { _ in
//            }
//            cell.ellipsisButtonInColorSideBar.menu = UIMenu(children: [favAction, lockAction, copyAction, shareAction])
//            cell.ellipsisButtonInColorSideBar.showsMenuAsPrimaryAction = true
//            print(colorArray)
//        }
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return tableView.frame.width * 0.8
//    }
//}
//
//// MARK: - Navigation Controller Setup
//extension CollectionVC {
//    func setupNavigationController() {
//        let titleLabel = UILabel()
//        titleLabel.text = "Favorites" // Changed to "Favorites" for clarity
//        titleLabel.textColor = .white
//        titleLabel.font = UIFont.boldSystemFont(ofSize: 40)
//        titleLabel.textAlignment = .center
//        titleLabel.sizeToFit()
//        navigationItem.titleView = titleLabel
//
//        let boldConfig = UIImage.SymbolConfiguration(weight: .bold)
//        let listImage = UIImage(systemName: "list.bullet", withConfiguration: boldConfig)
//        let listButton = UIBarButtonItem(
//            image: listImage,
//            style: .plain,
//            target: self,
//            action: #selector(listButtonTapped)
//        )
//        listButton.tintColor = .white
//        navigationItem.rightBarButtonItem = listButton
//    }
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
//        searchController.searchBar.placeholder = "Search Favorites"
//        searchController.searchBar.searchTextField.backgroundColor = UIColor.white
//        navigationItem.searchController = searchController
//        definesPresentationContext = true
//    }
//
//    func updateSearchResults(for searchController: UISearchController) {
//        guard let text = searchController.searchBar.text, !text.isEmpty else {
//            fetchFavorites() // Reset to full list when search is cleared
//            return
//        }
//        print("Search Query: \(text)")
//        // Add filtering logic if desired
//    }
//}

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
            cell.heartButtonInTopView.setImage(UIImage(systemName: "heart.fill"), for: .normal) // Always filled since it's a favorite
            cell.underLine.backgroundColor = UIColor(hex: firstColor)
            cell.configureCell(with: colorArray)
            
            let favAction = UIAction(title: "Fav", image: UIImage(systemName: "heart")) { _ in
                print("Fav tapped for \(palette.name ?? "unknown")")
            }
            let lockAction = UIAction(title: "Lock", image: UIImage(systemName: "lock")) { _ in
                print("Lock tapped for \(palette.name ?? "unknown")")
            }
            let copyAction = UIAction(title: "Copy", image: UIImage(systemName: "doc.on.doc")) { _ in
                print("Copied \(palette.name ?? "unknown")")
            }
            let shareAction = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { _ in
            }
            cell.ellipsisButtonInColorSideBar.menu = UIMenu(children: [favAction, lockAction, copyAction, shareAction])
            cell.ellipsisButtonInColorSideBar.showsMenuAsPrimaryAction = true
            
            // Updated buttonAction for deletion
            cell.buttonAction = {
                let selectedPalette = self.favNamedColorPalettes[indexPath.row]
                let alert = UIAlertController(
                    title: "Unsave Color",
                    message: "Do you want to unsave this color?",
                    preferredStyle: .alert
                )
                let unsaveAction = UIAlertAction(title: "Yes", style: .destructive) { _ in
                    // Convert FavNamedColorPalettes to ColorPalette for deletePalette
                    let colorPalette = ColorPalette(name: selectedPalette.name ?? "", colors: (selectedPalette.colors as? [String]) ?? [])
                    CoreDataManager.shared.deletePalette(colorPalette)
                    self.favNamedColorPalettes = CoreDataManager.shared.fetchFavorites()
                    DispatchQueue.main.async {
                        if let updatedCell = self.tableViewInCollectonVC.cellForRow(at: indexPath) as? TopTableViewCellInCollectionVC {
                            updatedCell.heartButtonInTopView.setImage(UIImage(systemName: "heart"), for: .normal)
                        }
                        // Reload the table to reflect the deletion
                        self.tableViewInCollectonVC.reloadData()
                    }
                }
                let cancelAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
                alert.addAction(unsaveAction)
                alert.addAction(cancelAction)
                self.present(alert, animated: true, completion: nil)
            }
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
        titleLabel.text = "Favorites"
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
            fetchFavorites()
            return
        }
        print("Search Query: \(text)")
        // Add filtering logic if desired
    }
}
