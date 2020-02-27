
import UIKit

class CastDetailViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    var cellsArray : [cellTypeModel] = []
    @IBOutlet weak var tableView: UITableView!
    var cast: Cast?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.setUpCellsData()
    }
    
    // MARK: Setup functions
    
    func setUpUI() {
        self.title = "Cast detail"
        let avatarNib = UINib.init(nibName: "AvatarCell", bundle: nil)
        tableView.register(avatarNib, forCellReuseIdentifier: "AvatarCell")
        let infoNib = UINib.init(nibName: "InfoCell", bundle: nil)
        tableView.register(infoNib, forCellReuseIdentifier: "InfoCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setUpCellsData() {
        guard let cast = self.cast else {
                   fatalError("Cast was not passed to view controller")
               }
        let avatarCell : avatarCellData = avatarCellData.init(avatarName: cast.avatar)
        let infoCellRole : infoCellData = infoCellData.init(header: "Role information", labels: [cast.fullname, cast.role, String(cast.episodes ?? 0)])
    
        let infoCellBirth : infoCellData = infoCellData.init(header: "Birth information", labels: [cast.birth, cast.placeBirth])
        cellsArray.append(avatarCell)
        cellsArray.append(infoCellRole)
        cellsArray.append(infoCellBirth)
    }
    
    // MARK: TableView delegate methods
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(cellsArray[indexPath.row].cellType == .avatar) {
            return 370
        }
        return 60
    }
    
    //MARK: TableView data source methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(cellsArray[indexPath.row].cellType == .avatar){
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AvatarCell", for: indexPath) as? AvatarCell else { fatalError("Could not load cell") }
            cell.avatarCellData = cellsArray[indexPath.row]
            return cell
        } else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell", for: indexPath) as? InfoCell else { fatalError("Could not load cell") }
            cell.infoCellData = cellsArray[indexPath.row]
            return cell
        }
    }
}
