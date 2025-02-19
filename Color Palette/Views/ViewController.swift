



import UIKit

class ViewController: UIViewController {
    
    
    
    
    var colorPalettes: [ColorPalette]?


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
           
        }
        
       
        

      
    }
    
    func loadColorPalettes() -> [ColorPalette]? {
        
        guard let path = Bundle.main.path(forResource: "palettes", ofType: "json") else { return nil }

        do {
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: path))
            let decoder = JSONDecoder()
            let  decodedData = try decoder.decode(ColorPalettesData.self, from: jsonData)
            let namedColorPalettes = decodedData.palettes.filter { $0.type == "Named Colors" }
           
            return namedColorPalettes
            
            
        } catch {
         
            return nil
        }
    }
    
}



   
extension ViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colorPalettes?.count ?? 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        
        let colorPalette = colorPalettes?[indexPath.row]
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
        
        // Pass the color palette data to the cell's collection view
        if let colorPalettes = colorPalettes {
            cell.configureCell(with: colorPalettes[indexPath.row].colors)
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}

    
    
    
    extension ViewController { //Here I register the Xib File
        func topBarFunction() {
            if let refrenceForViewTop = Bundle.main.loadNibNamed("TopBar", owner: self, options: nil)?[0] as? TopBar {
                topBarContainer.addSubview(refrenceForViewTop)
                refrenceForViewTop.frame.size.height = topBarContainer.frame.size.height
                refrenceForViewTop.frame.size.width = topBarContainer.frame.size.width
                topBar = refrenceForViewTop
                topBar?.title.text = "Home"
            }
        }
    }
    
    
    

