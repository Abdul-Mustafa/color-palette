
import UIKit

// First, let's create a reusable helper for corner radius
extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

enum CellType {
    case type1(name: String, label1: String, label2: String, buttonTitle: String)
    case type2(name: String, label: String, buttonTitle: String)
    case type3(label: String)
    case type4(name: String, label: String)
}

class MoreVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var isRotated: Bool = false
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var SubView: UIView!
    
    // Custom cell background color
    let customCellColor = UIColor(red: 246/255, green: 248/255, blue: 226/255, alpha: 1.0) // #F6F8E2
    
    // Sample data
    let tableData: [CellType] = [
        .type1(name: "king-hat", label1: "Unlock", label2: "All Features", buttonTitle: "arrow"),
        .type2(name: "profile", label: "Profile", buttonTitle: "arrow"),
        .type2(name: "world", label: "Language", buttonTitle: "arrow"),
        .type2(name: "phone", label: "Vibration", buttonTitle: "arrow"),
        .type3(label: "Share the App"),
        .type4(name: "privacy", label: "Privacy Policy"),
        .type4(name: "receipt", label: "Terms of Uses"),
        .type4(name: "privacy", label: "Rate Us")
    ]
    
    // Group cells to apply styling
    let groupedData: [[Int]] = [
        [0],           // First cell (type1) - standalone
        [1, 2, 3],     // Second group (type2) - 3 cells
        [4],           // Third group (type3) - 1 cell
        [5, 6, 7]      // Fourth group (type4) - 3 cells
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        setupTableView()
        setupNavigationController()
        setupSearchController()
        
        isRotated = UIDevice.current.orientation.isLandscape
        print(isRotated)
    }

    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.estimatedSectionHeaderHeight = 0
           tableView.estimatedSectionFooterHeight = 0
        // Add padding around the table view
   //     tableView.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        
        // Hide scroll indicators (remove scroll bar)
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return groupedData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupedData[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataIndex = groupedData[indexPath.section][indexPath.row]
        let data = tableData[dataIndex]
        
        let cell: UITableViewCell
        
        switch data {
        case .type1(let name, let label1, let label2, let buttonTitle):
            let typeCell = tableView.dequeueReusableCell(withIdentifier: "FirstPrototypeCell", for: indexPath) as! FirstPrototypeCell
            typeCell.leftImageView.image = UIImage(named: name)
            typeCell.topLabel.text = label1
            typeCell.bottomLabel.text = label2
            typeCell.actionButton.setImage(UIImage(named: buttonTitle), for: .normal)
            typeCell.actionButton.tag = dataIndex
            typeCell.layer.borderWidth = 2
            typeCell.layer.borderColor = UIColor.red.cgColor
            typeCell.actionButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            
            // Apply all corners radius for standalone cell
            typeCell.contentView.layer.cornerRadius = 15
            typeCell.contentView.clipsToBounds = true
            
            // First cell gets white background (not the custom color)
            typeCell.contentView.backgroundColor = .white
            
            cell = typeCell
            
        case .type2(let name, let label, let buttonTitle):
            let typeCell = tableView.dequeueReusableCell(withIdentifier: "SecondPrototypeCell", for: indexPath) as! SecondPrototypeCell
            typeCell.leftImageView.image = UIImage(named: name)
            typeCell.titleLabel.text = label
            typeCell.actionButton.setImage(UIImage(named: buttonTitle), for: .normal)
            typeCell.actionButton.tag = dataIndex
            typeCell.actionButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            
            // Apply corner radius based on position in section
            typeCell.contentView.clipsToBounds = true
            
            if indexPath.row == 0 {
                // First cell in section - round top corners
                typeCell.contentView.layer.cornerRadius = 15
                typeCell.contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            } else if indexPath.row == groupedData[indexPath.section].count - 1 {
                // Last cell in section - round bottom corners
                typeCell.contentView.layer.cornerRadius = 15
                typeCell.contentView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            } else {
                // Middle cells - no corner radius
                typeCell.contentView.layer.cornerRadius = 0
            }
            
            // Apply custom background color to this cell
            typeCell.contentView.backgroundColor = customCellColor
            
            cell = typeCell
            
        case .type3(let label):
            let typeCell = tableView.dequeueReusableCell(withIdentifier: "ThirdPrototypeCell", for: indexPath) as! ThirdPrototypeCell
            typeCell.titleLabel.text = label
            
            // Apply all corners radius for standalone cell
            typeCell.contentView.layer.cornerRadius = 15
            typeCell.contentView.clipsToBounds = true
            
            // Apply custom background color to this cell
            typeCell.contentView.backgroundColor = customCellColor
            
            cell = typeCell
            
        case .type4(let name, let label):
            let typeCell = tableView.dequeueReusableCell(withIdentifier: "FourthPrototypeCell", for: indexPath) as! FourthPrototypeCell
            typeCell.leftImageView.image = UIImage(named: name)
            typeCell.titleLabel.text = label
            
            // Apply corner radius based on position in section
            typeCell.contentView.clipsToBounds = true
            
            if indexPath.row == 0 {
                // First cell in section - round top corners
                typeCell.contentView.layer.cornerRadius = 15
                typeCell.contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            } else if indexPath.row == groupedData[indexPath.section].count - 1 {
                // Last cell in section - round bottom corners
                typeCell.contentView.layer.cornerRadius = 15
                typeCell.contentView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            } else {
                // Middle cells - no corner radius
                typeCell.contentView.layer.cornerRadius = 0
            }
            
            // Apply custom background color to this cell
            typeCell.contentView.backgroundColor = customCellColor
            
            cell = typeCell
        }
        
        // Apply a background color and shadow effect
        cell.backgroundColor = .white
        
        // Add inset to all cells for margin effect
//        let margins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
//        cell.contentView.frame = cell.contentView.frame.inset(by: margins)
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let dataIndex = groupedData[indexPath.section][indexPath.row]
        let data = tableData[dataIndex]
        
        switch data {
            
        case .type1: return  isRotated ? 100 : UIScreen.main.bounds.height / 10
        case .type2: return isRotated ? 60 : UIScreen.main.bounds.height/15
        case .type3: return isRotated ? 60 : UIScreen.main.bounds.height/15
        case .type4: return isRotated ? 60 :UIScreen.main.bounds.height/15 
        }
    }
    
   //  Add spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 1 : 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1 // Minimal footer height
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .clear
        return footerView
    }
    
    // MARK: - Button Action
    
    @objc func buttonTapped(_ sender: UIButton) {
        let index = sender.tag
        switch tableData[index] {
        case .type1(_, _, _, let buttonTitle):
            print("Button tapped in Type1 cell: \(buttonTitle)")
        case .type2(_, _, let buttonTitle):
            print("Button tapped in Type2 cell: \(buttonTitle)")
        default:
            break
        }
    }
}

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
extension MoreVC: UISearchResultsUpdating {
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
