
import UIKit

class ViewController: UIViewController {
    var colorPalettes: [ColorPalette]?
    
    private var namedColorPalettes: [ColorPalette]? {
        return colorPalettes?.filter { $0.type == "Named Colors" }
    }
    
    private var randomColorPalettes: [ColorPalette]? {
        return colorPalettes?.filter { $0.type == "Random Color" }
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
        
      
        
        if let colorPalettesData = loadColorPalettes() {
            colorPalettes = colorPalettesData
            DispatchQueue.main.async {
                self.tableviewAtHome.reloadData()
            }
        }
    }
    
    func loadColorPalettes() -> [ColorPalette]? {
        guard let path = Bundle.main.path(forResource: "palettes", ofType: "json") else { return nil }

        do {
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: path))
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(ColorPalettesData.self, from: jsonData)
            
            return decodedData.palettes
        } catch {
            print("Error decoding JSON: \(error.localizedDescription)")
            return nil
        }
    }
}

// MARK: - TableView Delegate & DataSource
extension ViewController: UITableViewDataSource, UITableViewDelegate  {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (namedColorPalettes?.count ?? 0) + (randomColorPalettes?.count ?? 0)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let namedCount = namedColorPalettes?.count ?? 0

        if indexPath.row < namedCount {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
            let colorPalette = namedColorPalettes?[indexPath.row]
            
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
            
            return cell
        } else {
            let randomIndex = indexPath.row - namedCount
            let bottomCell = tableView.dequeueReusableCell(withIdentifier: "BottomTableViewCell", for: indexPath) as! BottomTableViewCell
            let randomColorName = randomColorPalettes?[randomIndex].name
            bottomCell.titleInBottomViewTableCell.text = randomColorName ?? "Color"
            let randomColors = randomColorPalettes?[randomIndex].colors ?? ["Color"]
            bottomCell.configureCell(with: randomColors)
            return bottomCell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row < (namedColorPalettes?.count ?? 0) {
            return 300
        } else {
            return 200
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

