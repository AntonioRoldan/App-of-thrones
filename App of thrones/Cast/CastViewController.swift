//
//  CastViewController.swift
//  App of thrones
//
//  Created by Antonio Miguel Roldan de la Rosa on 13/02/2020.
//  Copyright © 2020 Antonio Roldan de la Rosa. All rights reserved.
//

import UIKit

class CastViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var casts: [Cast] = []
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setUpNotifications()
        self.setupData()
    }
    
    func setupData(){
        if let pathURL = Bundle.main.url(forResource: "cast", withExtension: "json"){
            do {
                let data = try Data.init(contentsOf: pathURL)
                       let decoder = JSONDecoder()
                       casts = try decoder.decode([Cast].self, from: data)
                 tableView.reloadData()
            }
            catch {
                fatalError(error.localizedDescription)
            }
        } else {
            fatalError("Could not build url path")
        }
    }
    
    func setupUI() {
        let nib = UINib.init(nibName: "CastTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CastTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setUpNotifications() {
        let noteName = Notification.Name(rawValue: "DidFavouritesChange")
    NotificationCenter.default.addObserver(self, selector: #selector(self.didFavouriteChange), name: noteName, object: nil)
    }
    
    @objc func didFavouriteChange() {
        tableView.reloadData()
    }
    
    // MARK: -UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 148
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVc = CastDetailViewController()
        detailVc.cast = casts[indexPath.row]
        self.navigationController?.pushViewController(detailVc, animated: true)
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: -UITableViewDatasource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.casts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CastTableViewCell", for: indexPath) as? CastTableViewCell {
            cell.setCast(cast: casts[indexPath.row])
            cell.reloadData = {
                tableView.reloadData()
            }
            return cell
        }
        fatalError("Could not create Episode cell")
    }
}
