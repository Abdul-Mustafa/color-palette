
import UIKit

class ViewController: UIViewController {
//  var colorPalettes: [ColorPalette]?
    var colorPalettes: [String : [ColorPalette]] = [:]
    var namedColors:[ColorPalette]?
    var randomColors:[ColorPalette]?
   // var fixedScreenSize: CGSize = UIScreen.main.bounds.size
//    private var namedColorPalettes: [ColorPalette]? {
//        return colorPalettes?.filter { $0.type == "Named Colors" }
//    }
//    
//    private var randomColorPalettes: [ColorPalette]? {
//        return colorPalettes?.filter { $0.type == "Random Color" }
//    }
    
  
     
  
    
    @IBOutlet weak var topBarContainer: UIView!
    @IBOutlet weak var tableviewAtHome: UITableView!
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
//        coordinator.animate(alongsideTransition: nil) { _ in
//        self.tableviewAtHome.frame.size = self.fixedScreenSize
//        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
     //   tableviewAtHome.frame.size = fixedScreenSize
        tableviewAtHome.dataSource = self
        tableviewAtHome.delegate = self
        tableviewAtHome.showsVerticalScrollIndicator = false
        tableviewAtHome.showsHorizontalScrollIndicator = false
        setupNavigationController()
        setupSearchController()
        let manager = ColorPaletteManager.shared

              // Get all palettes
              let allPalettes = manager.getAllPalettes()
        let namedColorsFromDataManager = manager.getPalettes(forCategory: "Named Colors")
        let randomColorsFromDataManager = manager.getPalettes(forCategory: "Random Color")
            namedColors = namedColorsFromDataManager
            randomColors = randomColorsFromDataManager
                colorPalettes = allPalettes
       // print("This is the array \(namedColors)")
      //  print("These are random colors \(randomColors)")
//        if let colorPalettesData = loadColorPalettes() {
//            colorPalettes = colorPalettesData
//            DispatchQueue.main.async {
//                self.tableviewAtHome.reloadData()
//            }
//        }
        
    }
    
//    func loadColorPalettes() -> [ColorPalette]? {
//        guard let path = Bundle.main.path(forResource: "palettes", ofType: "json") else { return nil }
//
//        do {
//            let jsonData = try Data(contentsOf: URL(fileURLWithPath: path))
//            let decoder = JSONDecoder()
//            let decodedData = try decoder.decode(ColorPalettesData.self, from: jsonData)
//            
//            return decodedData.palettes
//        } catch {
//            print("Error decoding JSON: \(error.localizedDescription)")
//            return nil
//        }
//    }
    

    

}

 // MARK: - TableView Delegate & DataSource
extension ViewController: UITableViewDataSource, UITableViewDelegate  {
    
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
            cell.underLine.backgroundColor = UIColor(hex: colorPalette?.colors.first ?? "#FFFFFF")
            cell.configureCell(with: colorPalette?.colors ?? [])
            
            let favAction = UIAction(title: "Fav", image: UIImage(systemName: "heart")) { _ in
                print("Fav tapped for (colorName)")
            }
            
            let lockAction = UIAction(title: "Lock", image: UIImage(systemName: "lock")) { _ in
                print("Lock tapped for (colorName)")
            }
            
            let copyAction = UIAction(title: "Copy", image: UIImage(systemName: "doc.on.doc")) { _ in
               // UIPasteboard.general.string = colorName
                print("Copied (colorName)")
            }
            
            let shareAction = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { _ in
//                let activityVC = UIActivityViewController(activityItems: [colorName], applicationActivities: nil)
//                if let viewController = collectionView.window?.rootViewController {
//                    viewController.present(activityVC, animated: true)
                //}
            }
            
            // Assign the menu to the button
            cell.ellipsisButtonInColorSideBar.menu = UIMenu(children: [favAction, lockAction, copyAction, shareAction])
            cell.ellipsisButtonInColorSideBar.showsMenuAsPrimaryAction = true
            cell.buttonAction = {
                if let namedColors = self.namedColors, indexPath.row < namedColors.count {
                    CoreDataManager.shared.savePalette(namedColors[indexPath.row])
                    
//                    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//                    deleteAllData(in: context)
                fetchSavedData()
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
        if indexPath.row < namedColors?.count ?? 0  {
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

