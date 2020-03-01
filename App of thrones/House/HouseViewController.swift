//
//  HouseViewController.swift
//  App of thrones
//
//  Created by Antonio Miguel Roldan de la Rosa on 13/02/2020.
//  Copyright © 2020 Antonio Roldan de la Rosa. All rights reserved.
//

import UIKit

class HouseViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var houses: [House] = []
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib.init(nibName: "HouseTableViewCell", bundle: nil)
        self.setUpHouseData()
        self.setUpNotifications()
        tableView.register(nib, forCellReuseIdentifier: "HouseTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setUpNotifications(){
        let favouritesChanged = Notification.Name(rawValue: "DidFavouritesChange")
        NotificationCenter.default.addObserver(self, selector: #selector(self.didFavouritesChange), name: favouritesChanged, object: nil)
    }
    
    @objc func didFavouritesChange(){
        tableView.reloadData()
    }
    
    func setUpHouseData(){
        guard let pathURL = Bundle.main.url(forResource: "houses", withExtension: "json") else { fatalError("Could not load houses data")}
        do {
            let data = try Data.init(contentsOf: pathURL)
                   let decoder = JSONDecoder()
                   houses = try decoder.decode([House].self, from: data)
                   tableView.reloadData()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    // MARK: -UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 148
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let houseDetailVc = HouseDetailViewController()
        houseDetailVc.house = self.houses[indexPath.row]
        self.navigationController?.pushViewController(houseDetailVc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: -UITableViewDatasource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.houses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: "HouseTableViewCell", for: indexPath) as? HouseTableViewCell {
            cell.setHouse(house: houses[indexPath.row])
            cell.reloadData = {
                tableView.reloadData()
            }
            return cell
        }
        fatalError("Could not create Episode cell")
    }

}
