//
//  FavouritesViewController.swift
//  App of thrones
//
//  Created by Antonio Miguel Roldan de la Rosa on 27/02/2020.
//  Copyright © 2020 Antonio Roldan de la Rosa. All rights reserved.
//

import UIKit

class FavouritesViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    var favouriteEpisodes : [Episode] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        self.setUpUI()
        self.setUpNotifications()
        self.setUpData()
    }
    
    //MARK: IB Actions
    
    deinit {
        let favouriteName = Notification.Name(rawValue: "DidFavouritesChange")
        NotificationCenter.default.removeObserver(self, name: favouriteName, object: nil)
        let rateChange = Notification.Name(rawValue: "DidRateChange")
        NotificationCenter.default.removeObserver(self, name: rateChange, object: nil)
        let removeRatingsName = Notification.Name(rawValue: "RemoveRatingsName")
        NotificationCenter.default.removeObserver(self, name: removeRatingsName, object: nil)
    }
    
    func setUpNotifications() {
        let favouriteName = Notification.Name(rawValue: "DidFavouritesChange")
        NotificationCenter.default.addObserver(self, selector: #selector(self.setUpData), name: favouriteName, object: nil)
        let rateChange = Notification.Name(rawValue: "DidRateChange")
        NotificationCenter.default.addObserver(self, selector: #selector(self.didRateChange), name:rateChange, object: nil)
    }
    
    @objc func didRateChange(){
        tableView.reloadData()
    }
    
    func setUpDataForSeason(_ seasonNumber: Int) -> [Episode] {
        var favouritesFromSeason : [Episode] = []
        guard let pathURL = Bundle.main.url(forResource: "season_\(seasonNumber)", withExtension: "json") else { fatalError("Could not load data for episodes in favourites view controller")}
        do {
            let data = try Data.init(contentsOf: pathURL)
            let decoder = JSONDecoder()
            favouritesFromSeason = try decoder.decode([Episode].self, from: data)
            favouritesFromSeason = favouritesFromSeason.filter {
                   (episode) -> Bool in
        DataController.shared.isFavourite(episode)
            }
            return favouritesFromSeason
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    @objc func setUpData(){
        favouriteEpisodes.removeAll()
        for season in 1...8 {
            favouriteEpisodes += setUpDataForSeason(season)
        }
        tableView.reloadData()
    }
    
    func setUpUI() {
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib.init(nibName: "EpisodeTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "EpisodeTableViewCell")
    }
    
    //MARK: Table view delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episodeDetailVc = EpisodeDetailViewController()
        episodeDetailVc.episode = favouriteEpisodes[indexPath.row]
        navigationController?.pushViewController(episodeDetailVc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 148
    }
    
    //MARK: Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favouriteEpisodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeTableViewCell", for: indexPath) as? EpisodeTableViewCell else { fatalError("Could not load table view cell in favourites view controller")}
        cell.setEpisode(favouriteEpisodes[indexPath.row])
        cell.rateBlock = {
            let rateViewController = RateViewController.init(withEpisode: self.favouriteEpisodes[indexPath.row])
            let navigationController = UINavigationController.init(rootViewController: rateViewController)
            self.present(navigationController, animated: true, completion: nil)
        }
        return cell
    }
}
