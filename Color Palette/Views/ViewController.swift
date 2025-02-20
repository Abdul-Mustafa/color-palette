//
//
//
//
//import UIKit
//
//class ViewController: UIViewController {
//    
//    
//    
//    
//    var colorPalettes: [ColorPalette]?
//    private var namedColorPalettes: [ColorPalette]? {
//           return colorPalettes?.filter { $0.type == "Named Colors" }
//       }
//       
//       // Add a computed property for Random Colors
//       private var randomColorPalettes: [ColorPalette]? {
//           return colorPalettes?.filter { $0.type == "Random Color" }
//       }
//
//
//    var topBar: TopBar?
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
//
//       
//        topBarFunction()
//        if let colorPalettesData = loadColorPalettes() {
//            colorPalettes = colorPalettesData
//           
//        }
//        
//       
//        
//
//      
//    }
//    
//    func loadColorPalettes() -> [ColorPalette]? {
//        
//        guard let path = Bundle.main.path(forResource: "palettes", ofType: "json") else { return nil }
//
//        do {
//            let jsonData = try Data(contentsOf: URL(fileURLWithPath: path))
//            let decoder = JSONDecoder()
//            let  decodedData = try decoder.decode(ColorPalettesData.self, from: jsonData)
//            
//            
//            return decodedData.palettes
//            
//            
//        } catch {
//         
//            return nil
//        }
//    }
//    
//}
//
//
//
//   
//extension ViewController: UITableViewDataSource, UITableViewDelegate {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
////
//        
//        return (namedColorPalettes?.count ?? 0) + (randomColorPalettes?.count ?? 0)
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        if indexPath.row == (namedColorPalettes?.count ?? 0) {
//            
//            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
//            print(namedColorPalettes)
//            let colorPalette = namedColorPalettes?[indexPath.row]
//            cell.colorTitleInTopView.text = colorPalette?.name
//            cell.colorTitleInTopView.textColor = UIColor(hex: colorPalette?.colors.first ?? "#FFFFFF")
//            cell.colorTitleInColorSideBar.text = colorPalette?.name
//            cell.colorTitleInColorSideBar.textColor = .white
//            cell.hexaCodeInColorSideBar.text = colorPalette?.colors.first
//            cell.hexaCodeInColorSideBar.textColor = .white
//            cell.ellipsisButtonInColorSideBar.tintColor = .white
//            cell.colorSideBarContainer.backgroundColor = UIColor(hex: colorPalette?.colors.first ?? "#FFFFFF")
//            cell.heartButtonInTopView.tintColor = UIColor(hex: colorPalette?.colors.first ?? "#FFFFFF")
//            cell.underLine.backgroundColor = UIColor(hex: colorPalette?.colors.first ?? "#FFFFFF")
//            
//            // Pass the color palette data to the cell's collection view
//            if let colorPalettes = colorPalettes {
//                cell.configureCell(with: colorPalettes[indexPath.row].colors)
//            }
//            
//            return cell}
//        else {
//            let bottomCell = tableView.dequeueReusableCell(withIdentifier: "BottomTableViewCell", for: indexPath) as! BottomTableViewCell
//            bottomCell.titleInBottomViewTableCell.text = "Color"
//            return bottomCell
//        }
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.row < (colorPalettes?.count ?? 0) {
//            return 300 // HomeTableViewCell height
//        } else {
//            return 200 // BottomTableViewCell height
//        }
//    }
//}
//
//    
//    
//    
//    extension ViewController { //Here I register the Xib File
//        func topBarFunction() {
//            if let refrenceForViewTop = Bundle.main.loadNibNamed("TopBar", owner: self, options: nil)?[0] as? TopBar {
//                topBarContainer.addSubview(refrenceForViewTop)
//                refrenceForViewTop.frame.size.height = topBarContainer.frame.size.height
//                refrenceForViewTop.frame.size.width = topBarContainer.frame.size.width
//                topBar = refrenceForViewTop
//                topBar?.title.text = "Home"
//            }
//        }
//    }
//    
//    
//    
//
import UIKit

class ViewController: UIViewController {
    var colorPalettes: [ColorPalette]?
    
    private var namedColorPalettes: [ColorPalette]? {
        return colorPalettes?.filter { $0.type == "Named Colors" }
    }
    
    private var randomColorPalettes: [ColorPalette]? {
        return colorPalettes?.filter { $0.type == "Random Color" }
    }

    var topBar: TopBar?
    
    @IBOutlet weak var topBarContainer: UIView!
    @IBOutlet weak var tableviewAtHome: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableviewAtHome.dataSource = self
        tableviewAtHome.delegate = self
        tableviewAtHome.showsVerticalScrollIndicator = false
        tableviewAtHome.showsHorizontalScrollIndicator = false

       topBarFunction()
        
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

 //MARK: - TopBar Function
extension ViewController {
    func topBarFunction() {
        if let refrenceForViewTop = Bundle.main.loadNibNamed("TopBar", owner: self, options: nil)?[0] as? TopBar {
            topBarContainer.addSubview(refrenceForViewTop)
            refrenceForViewTop.frame = topBarContainer.bounds
            topBar = refrenceForViewTop
            topBar?.title.text = "Home"
        }
    }
}
