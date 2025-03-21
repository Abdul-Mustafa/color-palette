

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
    
    // Sample data with a flag to track visibility
    var tableData: [CellType] = [
        .type1(name: "king-hat", label1: "Unlock", label2: "All Features", buttonTitle: "arrow"),
//        .type2(name: "profile", label: "Profile", buttonTitle: "arrow"),
        .type2(name: "world", label: "Language", buttonTitle: "arrow"),
//        .type2(name: "phone", label: "Vibration", buttonTitle: "arrow"),
        .type3(label: "More Apps"),
        .type4(name: "privacy", label: "Privacy Policy"),
        .type4(name: "receipt", label: "Terms of Uses"),
        .type4(name: "privacy", label: "Rate Us")
    ]
    
    // Track which cells have their action button hidden
    var hiddenButtonIndices: Set<Int> = []
    
    // Updated grouped data to match the new tableData
    let groupedData: [[Int]] = [
        [0],           // First cell (type1) - standalone
        [1],           // Second group (type2) - now only 1 cell ("Language")
        [2],           // Third group (type3) - 1 cell
        [3, 4, 5]      // Fourth group (type4) - 3 cells
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationController()
        setupSearchController()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
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
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let dataIndex = groupedData[indexPath.section][indexPath.row]
//        let data = tableData[dataIndex]
//        
//        let cell: UITableViewCell
//        
//        switch data {
//        case .type1(let name, let label1, let label2, let buttonTitle):
//            let typeCell = tableView.dequeueReusableCell(withIdentifier: "FirstPrototypeCell", for: indexPath) as! FirstPrototypeCell
//            typeCell.leftImageView.image = UIImage(named: name)
//            typeCell.topLabel.text = label1
//            typeCell.bottomLabel.text = label2
//            typeCell.actionButton.setImage(hiddenButtonIndices.contains(dataIndex) ? nil : UIImage(named: buttonTitle), for: .normal)
//            typeCell.actionButton.tag = dataIndex
//            typeCell.layer.borderWidth = 2
//            typeCell.layer.borderColor = UIColor.red.cgColor
//            typeCell.actionButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
//            
//            typeCell.contentView.layer.cornerRadius = 15
//            typeCell.contentView.clipsToBounds = true
//            typeCell.contentView.backgroundColor = .white
//            
//            cell = typeCell
//            
////        case .type2(let name, let label, let buttonTitle):
////            let typeCell = tableView.dequeueReusableCell(withIdentifier: "SecondPrototypeCell", for: indexPath) as! SecondPrototypeCell
////            typeCell.leftImageView.image = UIImage(named: name)
////            typeCell.titleLabel.text = label
////            typeCell.actionButton.setImage(hiddenButtonIndices.contains(dataIndex) ? nil : UIImage(named: buttonTitle), for: .normal)
////            typeCell.actionButton.tag = dataIndex
////            typeCell.actionButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
////            
////            typeCell.contentView.clipsToBounds = true
////            if indexPath.row == 0 {
////                typeCell.contentView.layer.cornerRadius = 15
////                typeCell.contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
////            } else if indexPath.row == groupedData[indexPath.section].count - 1 {
////                typeCell.contentView.layer.cornerRadius = 15
////                typeCell.contentView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
////            } else {
////                typeCell.contentView.layer.cornerRadius = 0
////            }
////            
////            typeCell.contentView.backgroundColor = customCellColor
////            
////            cell = typeCell
//        case .type2(let name, let label, let buttonTitle):
//            let typeCell = tableView.dequeueReusableCell(withIdentifier: "SecondPrototypeCell", for: indexPath) as! SecondPrototypeCell
//            typeCell.leftImageView.image = UIImage(named: name)
//            typeCell.titleLabel.text = label
//            typeCell.actionButton.setImage(hiddenButtonIndices.contains(dataIndex) ? nil : UIImage(named: buttonTitle), for: .normal)
//            typeCell.actionButton.tag = dataIndex
//            typeCell.actionButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
//            
//            typeCell.contentView.clipsToBounds = true
//            let rowCount = groupedData[indexPath.section].count
//            if rowCount == 1 {
//                // Single-row section: round all corners
//                typeCell.contentView.layer.cornerRadius = 15
//                typeCell.contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
//            } else if indexPath.row == 0 {
//                typeCell.contentView.layer.cornerRadius = 15
//                typeCell.contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
//            } else if indexPath.row == rowCount - 1 {
//                typeCell.contentView.layer.cornerRadius = 15
//                typeCell.contentView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
//            } else {
//                typeCell.contentView.layer.cornerRadius = 0
//            }
//            
//            typeCell.contentView.backgroundColor = customCellColor
//            cell = typeCell
//            
//        case .type3(let label):
//            let typeCell = tableView.dequeueReusableCell(withIdentifier: "ThirdPrototypeCell", for: indexPath) as! ThirdPrototypeCell
//            typeCell.titleLabel.text = label
//            
//            typeCell.contentView.layer.cornerRadius = 15
//            typeCell.contentView.clipsToBounds = true
//            typeCell.contentView.backgroundColor = customCellColor
//            
//            cell = typeCell
//            
//        case .type4(let name, let label):
//            let typeCell = tableView.dequeueReusableCell(withIdentifier: "FourthPrototypeCell", for: indexPath) as! FourthPrototypeCell
//            typeCell.leftImageView.image = UIImage(named: name)
//            typeCell.titleLabel.text = label
//            
//            typeCell.contentView.clipsToBounds = true
//            if indexPath.row == 0 {
//                typeCell.contentView.layer.cornerRadius = 15
//                typeCell.contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
//            } else if indexPath.row == groupedData[indexPath.section].count - 1 {
//                typeCell.contentView.layer.cornerRadius = 15
//                typeCell.contentView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
//            } else {
//                typeCell.contentView.layer.cornerRadius = 0
//            }
//            
//            typeCell.contentView.backgroundColor = customCellColor
//            
//            cell = typeCell
//        }
//        
//        cell.backgroundColor = .white
//        return cell
//    }
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
            typeCell.actionButton.setImage(hiddenButtonIndices.contains(dataIndex) ? nil : UIImage(named: buttonTitle), for: .normal)
            typeCell.actionButton.tag = dataIndex
            typeCell.layer.borderWidth = 2
            typeCell.layer.borderColor = UIColor.red.cgColor
            typeCell.actionButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            
            typeCell.contentView.layer.cornerRadius = 15
            typeCell.contentView.clipsToBounds = true
            typeCell.contentView.backgroundColor = .white
            
            cell = typeCell
            
        case .type2(let name, let label, let buttonTitle):
            let typeCell = tableView.dequeueReusableCell(withIdentifier: "SecondPrototypeCell", for: indexPath) as! SecondPrototypeCell
            typeCell.leftImageView.image = UIImage(named: name)
            typeCell.titleLabel.text = label
            typeCell.actionButton.setImage(hiddenButtonIndices.contains(dataIndex) ? nil : UIImage(named: buttonTitle), for: .normal)
            typeCell.actionButton.tag = dataIndex
            typeCell.actionButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            
            typeCell.contentView.clipsToBounds = true
            let rowCount = groupedData[indexPath.section].count
            if rowCount == 1 {
                typeCell.contentView.layer.cornerRadius = 15
                typeCell.contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            } else if indexPath.row == 0 {
                typeCell.contentView.layer.cornerRadius = 15
                typeCell.contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            } else if indexPath.row == rowCount - 1 {
                typeCell.contentView.layer.cornerRadius = 15
                typeCell.contentView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            } else {
                typeCell.contentView.layer.cornerRadius = 0
            }
            
            typeCell.contentView.backgroundColor = customCellColor
            
            cell = typeCell
            
        case .type3(let label):
            let typeCell = tableView.dequeueReusableCell(withIdentifier: "ThirdPrototypeCell", for: indexPath) as! ThirdPrototypeCell
            typeCell.titleLabel.text = label
            
            typeCell.contentView.layer.cornerRadius = 15
            typeCell.contentView.clipsToBounds = true
            typeCell.contentView.backgroundColor = customCellColor
            
            cell = typeCell
            
        case .type4(let name, let label):
            let typeCell = tableView.dequeueReusableCell(withIdentifier: "FourthPrototypeCell", for: indexPath) as! FourthPrototypeCell
            typeCell.leftImageView.image = UIImage(named: name)
            typeCell.titleLabel.text = label
            
            typeCell.contentView.clipsToBounds = true
            if indexPath.row == 0 {
                typeCell.contentView.layer.cornerRadius = 15
                typeCell.contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            } else if indexPath.row == groupedData[indexPath.section].count - 1 {
                typeCell.contentView.layer.cornerRadius = 15
                typeCell.contentView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            } else {
                typeCell.contentView.layer.cornerRadius = 0
            }
            
            typeCell.contentView.backgroundColor = customCellColor
            
            cell = typeCell
        }
        
        cell.backgroundColor = .white
        cell.selectionStyle = .none // Add this line to disable the gray highlight
        
        return cell
    }
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let dataIndex = groupedData[indexPath.section][indexPath.row]
        let data = tableData[dataIndex]
        
        switch data {
        case .type1: return  100
        case .type2: return  60
        case .type3: return  60
        case .type4: return  60
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 1 : 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .clear
        return footerView
    }
    
    // Handle cell selection to hide the action button icon
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let dataIndex = groupedData[indexPath.section][indexPath.row]
        
        // Only affect cells with action buttons (type1 and type2)
        switch tableData[dataIndex] {
        case .type1, .type2:
            if hiddenButtonIndices.contains(dataIndex) {
                hiddenButtonIndices.remove(dataIndex) // Show the icon again if it was hidden
            } else {
                hiddenButtonIndices.insert(dataIndex) // Hide the icon
            }
            tableView.reloadRows(at: [indexPath], with: .automatic)
        default:
            break
        }
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
