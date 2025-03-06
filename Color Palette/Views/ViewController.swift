////
////import UIKit
////import CoreData
////
////class ViewController: UIViewController {
////    
////    var colorPalettes: [String : [ColorPalette]] = [:]
////    var namedColors:[ColorPalette]?
////    var randomColors:[ColorPalette]?
////
////    var favNamedColorPalettes: [FavNamedColorPalettes] = []
////
////    func isFavorite(colorPalette: ColorPalette?) -> Bool {
////        guard let colorName = colorPalette?.name else { return false }
////        
////        return favNamedColorPalettes.contains { $0.name == colorName }
////        
////    }
////  
////    
////    @IBOutlet weak var topBarContainer: UIView!
////    @IBOutlet weak var tableviewAtHome: UITableView!
////    
////    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
////        super.viewWillTransition(to: size, with: coordinator)
////        
////
////    }
////    override func viewDidLoad() {
////        super.viewDidLoad()
////        //   tableviewAtHome.frame.size = fixedScreenSize
////        tableviewAtHome.dataSource = self
////        tableviewAtHome.delegate = self
////        tableviewAtHome.showsVerticalScrollIndicator = false
////        tableviewAtHome.showsHorizontalScrollIndicator = false
////        setupNavigationController()
////        setupSearchController()
////        
////        let manager = ColorPaletteManager.shared
////        
////        // Get all palettes
////        let allPalettes = manager.getAllPalettes()
////        let namedColorsFromDataManager = manager.getPalettes(forCategory: "Named Colors")
////        let randomColorsFromDataManager = manager.getPalettes(forCategory: "Random Color")
////        namedColors = namedColorsFromDataManager
////        randomColors = randomColorsFromDataManager
////        colorPalettes = allPalettes
////        //fetchFavorites()
////        favNamedColorPalettes = CoreDataManager.shared.fetchFavorites()
////       
////    }
////    
////
////    
////
////}
////
//// // MARK: - TableView Delegate & DataSource
////extension ViewController: UITableViewDataSource, UITableViewDelegate  {
////    
////    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
////        let totalRows = (namedColors?.count ?? 0) + (randomColors?.count ?? 0)
////        
////        return totalRows
////    }
////
////    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////        
////
////        if indexPath.row < namedColors?.count ?? 0 {
////            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
////            let colorPalette = namedColors?[indexPath.row]
////            
////            cell.colorTitleInTopView.text = colorPalette?.name
////            cell.colorTitleInTopView.textColor = UIColor(hex: colorPalette?.colors.first ?? "#FFFFFF")
////            cell.colorTitleInColorSideBar.text = colorPalette?.name
////            cell.colorTitleInColorSideBar.textColor = .white
////            cell.hexaCodeInColorSideBar.text = colorPalette?.colors.first
////            cell.hexaCodeInColorSideBar.textColor = .white
////            cell.ellipsisButtonInColorSideBar.tintColor = .white
////            cell.colorSideBarContainer.backgroundColor = UIColor(hex: colorPalette?.colors.first ?? "#FFFFFF")
////            cell.heartButtonInTopView.tintColor = UIColor(hex: colorPalette?.colors.first ?? "#FFFFFF")
////            cell.heartButtonInTopView.setImage(
////                isFavorite(colorPalette: colorPalette) ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart"),
////                for: .normal
////            )
////            cell.underLine.backgroundColor = UIColor(hex: colorPalette?.colors.first ?? "#FFFFFF")
////            cell.configureCell(with: colorPalette?.colors ?? [])
////            
////            let favAction = UIAction(title: "Fav", image: UIImage(systemName: "heart")) { _ in
////                print("Fav tapped for (colorName)")
////            }
////            
////            let lockAction = UIAction(title: "Lock", image: UIImage(systemName: "lock")) { _ in
////                print("Lock tapped for (colorName)")
////            }
////            
////            let copyAction = UIAction(title: "Copy", image: UIImage(systemName: "doc.on.doc")) { _ in
////               // UIPasteboard.general.string = colorName
////                print("Copied (colorName)")
////            }
////            
////            let shareAction = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { _ in
////
////            }
////            
////            // Assign the menu to the button
////            cell.ellipsisButtonInColorSideBar.menu = UIMenu(children: [favAction, lockAction, copyAction, shareAction])
////            cell.ellipsisButtonInColorSideBar.showsMenuAsPrimaryAction = true
//////            cell.buttonAction = {
//////                if let namedColors = self.namedColors, indexPath.row < namedColors.count {
//////                    CoreDataManager.shared.savePalette(namedColors[indexPath.row])
//////                    DispatchQueue.main.async {
//////                              self.tableviewAtHome.reloadRows(at: [indexPath], with: .automatic)
//////                          }
//////                    
////////                                        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
////////                                        deleteAllData(in: context)
//////                fetchSavedData()
//////                 
//////
//////                }
//////                               
//////            }
//////            cell.buttonAction = {
//////                if let namedColors = self.namedColors, indexPath.row < namedColors.count {
//////                    let selectedColor = namedColors[indexPath.row]
//////                    
//////                    CoreDataManager.shared.savePalette(selectedColor) // Save the palette
//////                    self.favNamedColorPalettes = CoreDataManager.shared.fetchFavorites() // Refresh favorite list
//////                  
//////                       
//////            DispatchQueue.main.async {
//////                if let updatedCell = self.tableviewAtHome.cellForRow(at: indexPath) as? HomeTableViewCell {
//////                   let isFav = self.isFavorite(colorPalette: selectedColor)
//////                   let heartImage = isFav ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
//////                    print(updatedCell.heartButtonInTopView.image(for: .normal))
//////                        updatedCell.heartButtonInTopView.setImage(heartImage, for: .normal)
////////                    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
////////                        deleteAllData(in: context)
//////                        }
//////                    }
//////                }
//////            }
////            cell.buttonAction = {
////                if let namedColors = self.namedColors, indexPath.row < namedColors.count {
////                    let selectedColor = namedColors[indexPath.row]
////                    let isFav = self.isFavorite(colorPalette: selectedColor)
////
////                    if isFav { // If it's already a favorite
////                        let alert = UIAlertController(
////                            title: "Unsave Color",
////                            message: "Do you want to unsave this color?",
////                            preferredStyle: .alert
////                        )
////                        
////                        let unsaveAction = UIAlertAction(title: "Yes", style: .destructive) { _ in
////                            CoreDataManager.shared.deletePalette(selectedColor) // Now works!
////                            self.favNamedColorPalettes = CoreDataManager.shared.fetchFavorites()
////                            
////                            DispatchQueue.main.async {
////                                if let updatedCell = self.tableviewAtHome.cellForRow(at: indexPath) as? HomeTableViewCell {
////                                    updatedCell.heartButtonInTopView.setImage(UIImage(systemName: "heart"), for: .normal)
////                                }
////                            }
////                        }
////                        
////                        let cancelAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
////                        
////                        alert.addAction(unsaveAction)
////                        alert.addAction(cancelAction)
////                        
////                        self.present(alert, animated: true, completion: nil)
////                    } else { // If it's not a favorite
////                        CoreDataManager.shared.savePalette(selectedColor)
////                        self.favNamedColorPalettes = CoreDataManager.shared.fetchFavorites()
////                        
////                        DispatchQueue.main.async {
////                            if let updatedCell = self.tableviewAtHome.cellForRow(at: indexPath) as? HomeTableViewCell {
////                                updatedCell.heartButtonInTopView.setImage(UIImage(systemName: "heart.fill"), for: .normal)
////                            }
////                        }
////                    }
////                }
////            }
////           
////            return cell
////        } else {
////            let randomIndex = indexPath.row - (namedColors?.count ?? 0)
////            
////            let bottomCell = tableView.dequeueReusableCell(withIdentifier: "BottomTableViewCell", for: indexPath) as! BottomTableViewCell
////            let randomColorName = randomColors?[randomIndex].name
////          
////            bottomCell.titleInBottomViewTableCell.text = randomColorName ?? "Color"
////            let randomColors = randomColors?[randomIndex].colors ?? ["Color"]
////            bottomCell.configureCell(with: randomColors)
////            return bottomCell
////        }
////    }
////
////    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
////        if indexPath.row < namedColors?.count ?? 0  {
////            return tableView.frame.width * 0.8
////        } else {
////            return tableView.frame.width * 0.4
////            
////        }
////    }
////    
////    
////    
////}
////
////
////
////
////// MARK: - Navigation Controller Setup
////extension ViewController {
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
////extension ViewController: UISearchResultsUpdating {
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
////    
////}
////
//import UIKit
//import CoreData
//
//class ViewController: UIViewController {
//    
//    var colorPalettes: [String : [ColorPalette]] = [:]
//    var namedColors: [ColorPalette]?
//    var randomColors: [ColorPalette]?
//    var favNamedColorPalettes: [FavNamedColorPalettes] = []
//
//    func isFavorite(colorPalette: ColorPalette?) -> Bool {
//        guard let colorName = colorPalette?.name else { return false }
//        return favNamedColorPalettes.contains { $0.name == colorName }
//    }
//    
//    @IBOutlet weak var topBarContainer: UIView!
//    @IBOutlet weak var tableviewAtHome: UITableView!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        tableviewAtHome.dataSource = self
//        tableviewAtHome.delegate = self
//        tableviewAtHome.showsVerticalScrollIndicator = false
//        tableviewAtHome.showsHorizontalScrollIndicator = false
//        setupNavigationController()
//        setupSearchController()
//        
//        let manager = ColorPaletteManager.shared
//        let allPalettes = manager.getAllPalettes()
//        let namedColorsFromDataManager = manager.getPalettes(forCategory: "Named Colors")
//        let randomColorsFromDataManager = manager.getPalettes(forCategory: "Random Color")
//        namedColors = namedColorsFromDataManager
//        randomColors = randomColorsFromDataManager
//        colorPalettes = allPalettes
//        favNamedColorPalettes = CoreDataManager.shared.fetchFavorites()
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
//    @objc func refreshFavorites() {
//        favNamedColorPalettes = CoreDataManager.shared.fetchFavorites()
//        tableviewAtHome.reloadData()
//        print("Favorites refreshed in ViewController")
//    }
//    
//    deinit {
//        NotificationCenter.default.removeObserver(self)
//    }
//    
//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        super.viewWillTransition(to: size, with: coordinator)
//    }
//}
//
//// MARK: - TableView Delegate & DataSource
//extension ViewController: UITableViewDataSource, UITableViewDelegate {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let totalRows = (namedColors?.count ?? 0) + (randomColors?.count ?? 0)
//        return totalRows
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.row < namedColors?.count ?? 0 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
//            let colorPalette = namedColors?[indexPath.row]
//            
//            cell.colorTitleInTopView.text = colorPalette?.name
//            cell.colorTitleInTopView.textColor = UIColor(hex: colorPalette?.colors.first ?? "#FFFFFF")
//            cell.colorTitleInColorSideBar.text = colorPalette?.name
//            cell.colorTitleInColorSideBar.textColor = .white
//            cell.hexaCodeInColorSideBar.text = colorPalette?.colors.first
//            cell.hexaCodeInColorSideBar.textColor = .white
//            cell.ellipsisButtonInColorSideBar.tintColor = .white
//            cell.colorSideBarContainer.backgroundColor = UIColor(hex: colorPalette?.colors.first ?? "#FFFFFF")
//            cell.heartButtonInTopView.tintColor = UIColor(hex: colorPalette?.colors.first ?? "#FFFFFF")
//            cell.heartButtonInTopView.setImage(
//                isFavorite(colorPalette: colorPalette) ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart"),
//                for: .normal
//            )
//            cell.underLine.backgroundColor = UIColor(hex: colorPalette?.colors.first ?? "#FFFFFF")
//            cell.configureCell(with: colorPalette?.colors ?? [])
//            
//            let favAction = UIAction(title: "Fav", image: UIImage(systemName: "heart")) { _ in
//                print("Fav tapped for \(colorPalette?.name ?? "unknown")")
//            }
//            let lockAction = UIAction(title: "Lock", image: UIImage(systemName: "lock")) { _ in
//                print("Lock tapped for \(colorPalette?.name ?? "unknown")")
//            }
//            let copyAction = UIAction(title: "Copy", image: UIImage(systemName: "doc.on.doc")) { _ in
//                print("Copied \(colorPalette?.name ?? "unknown")")
//            }
//            let shareAction = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { _ in
//            }
//            cell.ellipsisButtonInColorSideBar.menu = UIMenu(children: [favAction, lockAction, copyAction, shareAction])
//            cell.ellipsisButtonInColorSideBar.showsMenuAsPrimaryAction = true
//            
//            cell.buttonAction = {
//                if let namedColors = self.namedColors, indexPath.row < namedColors.count {
//                    let selectedColor = namedColors[indexPath.row]
//                    let isFav = self.isFavorite(colorPalette: selectedColor)
//
//                    if isFav {
//                        let alert = UIAlertController(
//                            title: "Unsave Color",
//                            message: "Do you want to unsave this color?",
//                            preferredStyle: .alert
//                        )
//                        let unsaveAction = UIAlertAction(title: "Yes", style: .destructive) { _ in
//                            CoreDataManager.shared.deletePalette(selectedColor)
//                            self.favNamedColorPalettes = CoreDataManager.shared.fetchFavorites()
//                            DispatchQueue.main.async {
//                                if let updatedCell = self.tableviewAtHome.cellForRow(at: indexPath) as? HomeTableViewCell {
//                                    updatedCell.heartButtonInTopView.setImage(UIImage(systemName: "heart"), for: .normal)
//                                }
//                            }
//                        }
//                        let cancelAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
//                        alert.addAction(unsaveAction)
//                        alert.addAction(cancelAction)
//                        self.present(alert, animated: true, completion: nil)
//                    } else {
//                        CoreDataManager.shared.savePalette(selectedColor)
//                        self.favNamedColorPalettes = CoreDataManager.shared.fetchFavorites()
//                        DispatchQueue.main.async {
//                            if let updatedCell = self.tableviewAtHome.cellForRow(at: indexPath) as? HomeTableViewCell {
//                                updatedCell.heartButtonInTopView.setImage(UIImage(systemName: "heart.fill"), for: .normal)
//                            }
//                        }
//                    }
//                }
//            }
//            return cell
//        } else {
//            let randomIndex = indexPath.row - (namedColors?.count ?? 0)
//            let bottomCell = tableView.dequeueReusableCell(withIdentifier: "BottomTableViewCell", for: indexPath) as! BottomTableViewCell
//            let randomColorName = randomColors?[randomIndex].name
//            bottomCell.titleInBottomViewTableCell.text = randomColorName ?? "Color"
//            let randomColors = randomColors?[randomIndex].colors ?? ["Color"]
//            bottomCell.configureCell(with: randomColors)
//            return bottomCell
//        }
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.row < namedColors?.count ?? 0 {
//            return tableView.frame.width * 0.8
//        } else {
//            return tableView.frame.width * 0.4
//        }
//    }
//}
//
//// MARK: - Navigation Controller Setup
//extension ViewController {
//    func setupNavigationController() {
//        let titleLabel = UILabel()
//        titleLabel.text = "Home"
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
//extension ViewController: UISearchResultsUpdating {
//    func setupSearchController() {
//        let searchController = UISearchController(searchResultsController: nil)
//        searchController.searchResultsUpdater = self
//        searchController.obscuresBackgroundDuringPresentation = false
//        searchController.searchBar.placeholder = "Search Colors"
//        searchController.searchBar.searchTextField.backgroundColor = UIColor.white
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
import UIKit
import CoreData

class ViewController: UIViewController {
    
    var colorPalettes: [String : [ColorPalette]] = [:]
    var namedColors: [ColorPalette]?
    var randomColors: [ColorPalette]?
    var favNamedColorPalettes: [FavNamedColorPalettes] = []

    func isFavorite(colorPalette: ColorPalette?) -> Bool {
        guard let colorName = colorPalette?.name else { return false }
        return favNamedColorPalettes.contains { $0.name == colorName }
    }
    
    func isSingleColorSaved(colorPalette: ColorPalette?) -> Bool {
        guard let colorName = colorPalette?.name else { return false }
        return CoreDataManager.shared.isSingleColorSaved(name: colorName)
    }
    
    @IBOutlet weak var topBarContainer: UIView!
    @IBOutlet weak var tableviewAtHome: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableviewAtHome.dataSource = self
        tableviewAtHome.delegate = self
        tableviewAtHome.showsVerticalScrollIndicator = false
        tableviewAtHome.showsHorizontalScrollIndicator = false
        setupNavigationController()
        setupSearchController()
        
        let manager = ColorPaletteManager.shared
        let allPalettes = manager.getAllPalettes()
        let namedColorsFromDataManager = manager.getPalettes(forCategory: "Named Colors")
        let randomColorsFromDataManager = manager.getPalettes(forCategory: "Random Color")
        namedColors = namedColorsFromDataManager
        randomColors = randomColorsFromDataManager
        colorPalettes = allPalettes
        favNamedColorPalettes = CoreDataManager.shared.fetchFavorites()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(refreshFavorites),
            name: CoreDataManager.paletteDidChangeNotification,
            object: nil
        )
    }
    
    @objc func refreshFavorites() {
        favNamedColorPalettes = CoreDataManager.shared.fetchFavorites()
        tableviewAtHome.reloadData()
        print("Favorites refreshed in ViewController")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }
}

// MARK: - TableView Delegate & DataSource
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let totalRows = (namedColors?.count ?? 0) + (randomColors?.count ?? 0)
        return totalRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < namedColors?.count ?? 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
            let colorPalette = namedColors?[indexPath.row]
            
            cell.colorTitleInTopView.text = colorPalette?.name
            cell.colorTitleInTopView.textColor = UIColor(hex: colorPalette?.colors.first ?? "#FFFFFF")
            cell.colorTitleInColorSideBar.text = colorPalette?.name
            cell.colorTitleInColorSideBar.textColor = .white
            cell.hexaCodeInColorSideBar.text = colorPalette?.colors.first
            cell.hexaCodeInColorSideBar.textColor = .white
            cell.ellipsisButtonInColorSideBar.tintColor = .white
            cell.colorSideBarContainer.backgroundColor = UIColor(hex: colorPalette?.colors.first ?? "#FFFFFF")
            cell.heartButtonInTopView.tintColor = UIColor(hex: colorPalette?.colors.first ?? "#FFFFFF")
            cell.heartButtonInTopView.setImage(
                isFavorite(colorPalette: colorPalette) ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart"),
                for: .normal
            )
            cell.underLine.backgroundColor = UIColor(hex: colorPalette?.colors.first ?? "#FFFFFF")
            cell.configureCell(with: colorPalette?.colors ?? [])
            
            // Updated favAction for SingleColor entity
            let favAction = UIAction(title: "Fav", image: UIImage(systemName: isSingleColorSaved(colorPalette: colorPalette) ? "heart.fill" : "heart")) { [weak self] _ in
                guard let self = self, let colorPalette = colorPalette else { return }
                let isSaved = self.isSingleColorSaved(colorPalette: colorPalette)
                
                if isSaved {
                    let alert = UIAlertController(
                        title: "Unsave Color",
                        message: "Do you want to unsave this color?",
                        preferredStyle: .alert
                    )
                    let unsaveAction = UIAlertAction(title: "Yes", style: .destructive) { _ in
                        CoreDataManager.shared.deleteSingleColor(name: colorPalette.name)
                        DispatchQueue.main.async {
                            if let updatedCell = self.tableviewAtHome.cellForRow(at: indexPath) as? HomeTableViewCell {
                                updatedCell.ellipsisButtonInColorSideBar.menu = UIMenu(children: [
                                    UIAction(title: "Fav", image: UIImage(systemName: "heart")) { _ in
                                        CoreDataManager.shared.saveSingleColor(name: colorPalette.name)
                                        self.refreshFavorites()
                                    },
                                    UIAction(title: "Lock", image: UIImage(systemName: "lock")) { _ in
                                        print("Lock tapped for \(colorPalette.name)")
                                    },
                                    UIAction(title: "Copy", image: UIImage(systemName: "doc.on.doc")) { _ in
                                        print("Copied \(colorPalette.name)")
                                    },
                                    UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { _ in }
                                ])
                            }
                        }
                    }
                    let cancelAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
                    alert.addAction(unsaveAction)
                    alert.addAction(cancelAction)
                    self.present(alert, animated: true, completion: nil)
                } else {
                    CoreDataManager.shared.saveSingleColor(name: colorPalette.name)
                    DispatchQueue.main.async {
                        if let updatedCell = self.tableviewAtHome.cellForRow(at: indexPath) as? HomeTableViewCell {
                            updatedCell.ellipsisButtonInColorSideBar.menu = UIMenu(children: [
                                UIAction(title: "Fav", image: UIImage(systemName: "heart.fill")) { _ in
                                    CoreDataManager.shared.deleteSingleColor(name: colorPalette.name)
                                    self.refreshFavorites()
                                },
                                UIAction(title: "Lock", image: UIImage(systemName: "lock")) { _ in
                                    print("Lock tapped for \(colorPalette.name)")
                                },
                                UIAction(title: "Copy", image: UIImage(systemName: "doc.on.doc")) { _ in
                                    print("Copied \(colorPalette.name)")
                                },
                                UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { _ in }
                            ])
                        }
                    }
                }
            }
            
            let lockAction = UIAction(title: "Lock", image: UIImage(systemName: "lock")) { _ in
                print("Lock tapped for \(colorPalette?.name ?? "unknown")")
            }
            let copyAction = UIAction(title: "Copy", image: UIImage(systemName: "doc.on.doc")) { _ in
                print("Copied \(colorPalette?.name ?? "unknown")")
            }
            let shareAction = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { _ in }
            
            cell.ellipsisButtonInColorSideBar.menu = UIMenu(children: [favAction, lockAction, copyAction, shareAction])
            cell.ellipsisButtonInColorSideBar.showsMenuAsPrimaryAction = true
            
            // Keep the original cell.buttonAction as is (for heart button on top)
            cell.buttonAction = {
                if let namedColors = self.namedColors, indexPath.row < namedColors.count {
                    let selectedColor = namedColors[indexPath.row]
                    let isFav = self.isFavorite(colorPalette: selectedColor)

                    if isFav {
                        let alert = UIAlertController(
                            title: "Unsave Color",
                            message: "Do you want to unsave this color?",
                            preferredStyle: .alert
                        )
                        let unsaveAction = UIAlertAction(title: "Yes", style: .destructive) { _ in
                            CoreDataManager.shared.deletePalette(selectedColor)
                            self.favNamedColorPalettes = CoreDataManager.shared.fetchFavorites()
                            DispatchQueue.main.async {
                                if let updatedCell = self.tableviewAtHome.cellForRow(at: indexPath) as? HomeTableViewCell {
                                    updatedCell.heartButtonInTopView.setImage(UIImage(systemName: "heart"), for: .normal)
                                }
                            }
                        }
                        let cancelAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
                        alert.addAction(unsaveAction)
                        alert.addAction(cancelAction)
                        self.present(alert, animated: true, completion: nil)
                    } else {
                        CoreDataManager.shared.savePalette(selectedColor)
                        self.favNamedColorPalettes = CoreDataManager.shared.fetchFavorites()
                        DispatchQueue.main.async {
                            if let updatedCell = self.tableviewAtHome.cellForRow(at: indexPath) as? HomeTableViewCell {
                                updatedCell.heartButtonInTopView.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                            }
                        }
                    }
                }
            }
            return cell
        } else {
            let randomIndex = indexPath.row - (namedColors?.count ?? 0)
            let bottomCell = tableView.dequeueReusableCell(withIdentifier: "BottomTableViewCell", for: indexPath) as! BottomTableViewCell
            let randomColorName = randomColors?[randomIndex].name
            bottomCell.titleInBottomViewTableCell.text = randomColorName ?? "Color"
            let randomColors = randomColors?[randomIndex].colors ?? ["Color"]
            bottomCell.configureCell(with: randomColors)
            return bottomCell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row < namedColors?.count ?? 0 {
            return tableView.frame.width * 0.8
        } else {
            return tableView.frame.width * 0.4
        }
    }
}

// MARK: - Navigation Controller Setup
extension ViewController {
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
extension ViewController: UISearchResultsUpdating {
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
