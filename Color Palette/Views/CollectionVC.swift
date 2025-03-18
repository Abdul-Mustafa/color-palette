
import UIKit

class CollectionVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var singleColorsInCorData: [SingleColor] = []
    var favNamedColorPalettes: [FavNamedColorPalettes] = []
    private var copiedPalette: String? // Track which palette was copied
    
    @IBOutlet weak var SubView: UIView!
    @IBOutlet weak var tableViewInCollectonVC: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewInCollectonVC.delegate = self
        tableViewInCollectonVC.dataSource = self
        tableViewInCollectonVC.showsVerticalScrollIndicator = false
        tableViewInCollectonVC.showsHorizontalScrollIndicator = false
        setupNavigationController()
        setupSearchController()
        fetchFavorites()
        fetchSingleColor()
        
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
    }
    
    func fetchSingleColor() {
        singleColorsInCorData = CoreDataManager.shared.fetchSingleColors()
        tableViewInCollectonVC.reloadData()
    }
    
    @objc func refreshFavorites() {
        fetchFavorites()
        fetchSingleColor()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favNamedColorPalettes.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < favNamedColorPalettes.count {
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
                cell.heartButtonInTopView.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                cell.underLine.backgroundColor = UIColor(hex: firstColor)
                cell.configureCell(with: colorArray)
                
//                let isCopied = palette.name == copiedPalette
//                
//                let favAction = UIAction(title: "Fav", image: UIImage(systemName: "heart")) { _ in
//                    print("Fav tapped for \(palette.name ?? "unknown")")
//                }
//                let lockAction = UIAction(title: "Lock", image: UIImage(systemName: "lock")) { _ in
//                    print("Lock tapped for \(palette.name ?? "unknown")")
//                }
//                let copyAction = UIAction(
//                    title: "Copy",
//                    image: UIImage(systemName: isCopied ? "doc.on.doc.fill" : "doc.on.doc")
//                ) { [weak self] _ in
//                    guard let self = self else { return }
//                    UIPasteboard.general.string = palette.name
//                    self.copiedPalette = palette.name
//                    print("Copied \(palette.name ?? "unknown")")
//                    DispatchQueue.main.async {
//                       
//                        self.tableViewInCollectonVC.reloadData() // Update icons
//                    }
//                }
//                let shareAction = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { _ in
//                    let activityVC = UIActivityViewController(activityItems: [palette.name ?? ""], applicationActivities: nil)
//                    self.present(activityVC, animated: true)
//                }
//                cell.ellipsisButtonInColorSideBar.menu = UIMenu(children: [favAction, lockAction, copyAction, shareAction])
//                cell.ellipsisButtonInColorSideBar.showsMenuAsPrimaryAction = true
//                
                cell.buttonAction = { [weak self] in
                    guard let self = self else { return }
                    let selectedPalette = self.favNamedColorPalettes[indexPath.row]
                    let alert = UIAlertController(
                        title: "Unsave Color",
                        message: "Do you want to unsave this color?",
                        preferredStyle: .alert
                    )
                    let unsaveAction = UIAlertAction(title: "Yes", style: .destructive) { _ in
                        let colorPalette = ColorPalette(name: selectedPalette.name ?? "", colors: (selectedPalette.colors as? [String]) ?? [])
                        CoreDataManager.shared.deletePalette(colorPalette)
                        self.fetchFavorites()
                    }
                    let cancelAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
                    alert.addAction(unsaveAction)
                    alert.addAction(cancelAction)
                    self.present(alert, animated: true, completion: nil)
                }
                let colorName = firstColor
                let isSaved = CoreDataManager.shared.isSingleColorSaved(name: colorName)
                let isCopied = UIPasteboard.general.string == colorName

                let favAction = UIAction(title: "Fav", image: UIImage(systemName: isSaved ? "heart.fill" : "heart")) { [weak self] _ in
                    print("before the guard")
                    guard let self = self else { return }
                    print("after the guard")
                    if isSaved {
                        let alert = UIAlertController(
                            title: "Unsave Color",
                            message: "Do you want to unsave this color?",
                            preferredStyle: .alert
                        )
                        let unsaveAction = UIAlertAction(title: "Yes", style: .destructive) { _ in
                            CoreDataManager.shared.deleteSingleColor(name: colorName)
                            DispatchQueue.main.async {
                                self.tableViewInCollectonVC.reloadData()
                            }
                        }
                        let cancelAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
                        alert.addAction(unsaveAction)
                        alert.addAction(cancelAction)
                        self.present(alert, animated: true, completion: nil)
                    } else {
                        CoreDataManager.shared.saveSingleColor(name: colorName)
                        DispatchQueue.main.async {
                            self.tableViewInCollectonVC.reloadData()
                        }
                    }
                }

                let lockAction = UIAction(title: "Lock", image: UIImage(systemName: "lock")) { _ in
                    print("Lock tapped for \(colorName)")
                }

                let copyAction = UIAction(title: "Copy", image: UIImage(systemName: isCopied ? "doc.on.doc.fill" : "doc.on.doc")) { [weak self] _ in
                    guard let self = self else { return }
                    UIPasteboard.general.string = colorName
                    self.copiedPalette = colorName
                    DispatchQueue.main.async {
                        self.tableViewInCollectonVC.reloadData()
                    }
                }

                let shareAction = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { _ in
                    let activityVC = UIActivityViewController(activityItems: [colorName], applicationActivities: nil)
                    if let viewController = self.tableViewInCollectonVC.window?.rootViewController {
                        viewController.present(activityVC, animated: true)
                    }
                }

                cell.ellipsisButtonInColorSideBar.menu = UIMenu(children: [favAction, lockAction, copyAction, shareAction])
                cell.ellipsisButtonInColorSideBar.showsMenuAsPrimaryAction = true
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BottomTableViewCellInCollectionVC", for: indexPath) as! BottomTableViewCellInCollectionVC
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row < favNamedColorPalettes.count {
            return tableView.frame.width * 0.8
        } else {
            if let cell = tableView.cellForRow(at: indexPath) as? BottomTableViewCellInCollectionVC {
                let contentHeight = cell.collectionViewContentHeight
                return max(contentHeight, tableView.frame.width)
            } else {
                return tableView.frame.width
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableViewInCollectonVC.reloadData()
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
    }

//    @objc func listButtonTapped() {
//        print("List button tapped")
//    }
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
            fetchSingleColor()
            return
        }
        print("Search Query: \(text)")
        favNamedColorPalettes = CoreDataManager.shared.fetchFavorites().filter {
            $0.name?.lowercased().contains(text.lowercased()) ?? false
        }
        singleColorsInCorData = CoreDataManager.shared.fetchSingleColors().filter {
            $0.name?.lowercased().contains(text.lowercased()) ?? false
        }
        tableViewInCollectonVC.reloadData()
    }
}
