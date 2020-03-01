//
//  EpisodeDetailViewController.swift
//  App of thrones
//
//  Created by Antonio Miguel Roldan de la Rosa on 26/02/2020.
//  Copyright © 2020 Antonio Roldan de la Rosa. All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var cellsArray : [cellTypeModel] = []

    var episode : Episode?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpNotifications()
        self.setUpUI()
        self.setUpCellData()
    }
    
    deinit {
        let removeRatingsName = Notification.Name(rawValue: "RemoveRatingsName")
        NotificationCenter.default.removeObserver(self, name: removeRatingsName, object: nil)
        let rateNoteName = Notification.Name(rawValue: "DidRateChange")
        NotificationCenter.default.removeObserver(self, name: rateNoteName, object: nil)
    }
    
    func setUpNotifications(){
        let rateNoteName = Notification.Name(rawValue: "DidRateChange")
        NotificationCenter.default.addObserver(self, selector: #selector(self.didTableDataChange), name: rateNoteName, object: nil)
        let removeRatingsName = Notification.Name(rawValue: "RemoveRatingsName")
             NotificationCenter.default.addObserver(self, selector: #selector(self.didTableDataChange), name: removeRatingsName, object: nil)
    }
    
    @objc func didTableDataChange(){
        tableView.reloadData()
    }
    
    func setUpUI() {
        self.title = "Episode detail"
        let avatarNib = UINib.init(nibName: "AvatarCell", bundle: nil)
        tableView.register(avatarNib, forCellReuseIdentifier: "AvatarCell")
        let ratingNib = UINib.init(nibName: "RatingCell", bundle: nil)
        tableView.register(ratingNib, forCellReuseIdentifier: "RatingCell")
        let infoNib = UINib.init(nibName: "InfoCell", bundle: nil)
        tableView.register(infoNib, forCellReuseIdentifier: "InfoCell")
        let overviewNib = UINib.init(nibName: "OverviewCell", bundle: nil)
        tableView.register(overviewNib, forCellReuseIdentifier: "OverviewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setUpCellData() {
        guard let episode = self.episode, let overview = episode.overview else {
                          fatalError("Episode was not passed to view controller")
                      }
        let avatarCell : AvatarCellData = AvatarCellData.init(avatarName: episode.image)
        let ratingCell : RatingCellData = RatingCellData.init( episode: episode)
        let infoCellNameAndDate : InfoCellData = InfoCellData.init(header: "Name and date", labels: [episode.name, episode.date])
        let infoCellSeasonAndEpisode : InfoCellData = InfoCellData.init(header: "Season and episode", labels: [String(episode.season), String(episode.episode ?? 0)])
        let overviewCell : OverviewCellData = OverviewCellData.init(overview: overview)
        cellsArray.append(avatarCell)
        cellsArray.append(ratingCell)
        cellsArray.append(infoCellNameAndDate)
        cellsArray.append(infoCellSeasonAndEpisode)
        cellsArray.append(overviewCell)
    }
    
    // MARK: TableView delegate methods
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch cellsArray[indexPath.row].cellType {
            case .avatar:
                return 370
            case .rating:
                return 60
            case .infoCell:
                return 60
            case .overview:
                return 100
        }
    }
    
    //MARK: TableView data source methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch cellsArray[indexPath.row].cellType {
            case .avatar:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "AvatarCell", for: indexPath) as? AvatarCell else { fatalError("Could not load cell") }
                cell.avatarCellData = cellsArray[indexPath.row]
                return cell
            case .rating:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "RatingCell", for: indexPath) as? RatingCell, let episode = self.episode else { fatalError("Could not load cell") }
                cell.ratingCellData = cellsArray[indexPath.row]
                cell.rateTransition = {
                    let rateViewController = RateViewController.init(withEpisode: episode)
                    let navigationController = UINavigationController.init(rootViewController: rateViewController)
                    self.present(navigationController, animated: true, completion: nil)
                }
                return cell
            case .infoCell:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell", for: indexPath) as? InfoCell else { fatalError("Could not load cell") }
                cell.infoCellData = cellsArray[indexPath.row]
                return cell
            case .overview:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "OverviewCell", for: indexPath) as? OverviewCell else { fatalError("Could not load cell") }
                cell.overviewCellData = cellsArray[indexPath.row]
                return cell
        }
    }
    
}
