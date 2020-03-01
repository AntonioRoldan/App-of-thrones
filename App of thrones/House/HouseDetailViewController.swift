//
//  HouseDetailViewController.swift
//  App of thrones
//
//  Created by Antonio Miguel Roldan de la Rosa on 01/03/2020.
//  Copyright © 2020 Antonio Roldan de la Rosa. All rights reserved.
//

import UIKit

class HouseDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var cellsArray : [cellTypeModel] = []
    @IBOutlet weak var tableView: UITableView!
    var house : House?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.setUpCellsData()
    }
    
    func setUpUI(){
        self.title = "House detail"
        let avatarNib = UINib.init(nibName: "AvatarCell", bundle: nil)
        tableView.register(avatarNib, forCellReuseIdentifier: "AvatarCell")
        let infoNib = UINib.init(nibName: "InfoCell", bundle: nil)
        tableView.register(infoNib, forCellReuseIdentifier: "InfoCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setUpCellsData(){
        guard let house = self.house else { fatalError("Could not unwrap house in house detail view controller") }
        let avatarCell : AvatarCellData = AvatarCellData.init(avatarName: house.imageName)
        let infoCellNameAndWords: InfoCellData = InfoCellData.init(header: "Name and words", labels: [house.name ?? "", house.words ?? ""])
        let infoCellSeat: InfoCellData = InfoCellData.init(header: "Seat", labels: [house.seat ?? ""])
        cellsArray.append(avatarCell)
        cellsArray.append(contentsOf: [infoCellNameAndWords, infoCellSeat])
    }
    //MARK: Table view delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(cellsArray[indexPath.row].cellType == .avatar) {
            return 370
        }
        return 60
    }
    
    //MARK: Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch cellsArray[indexPath.row].cellType {
        case .avatar:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AvatarCell", for: indexPath) as? AvatarCell else { fatalError("Could not load cell") }
            cell.avatarCellData = cellsArray[indexPath.row]
            return cell
        case .infoCell:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell", for: indexPath) as? InfoCell else { fatalError("Could not load cell") }
            cell.infoCellData = cellsArray[indexPath.row]
            return cell
        default:
            return UITableViewCell()
        }
    }
}
