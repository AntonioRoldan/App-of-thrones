//
//  EpisodeViewController.swift
//  App of thrones
//
//  Created by Antonio Miguel Roldan de la Rosa on 13/02/2020.
//  Copyright © 2020 Antonio Roldan de la Rosa. All rights reserved.
//

import UIKit

protocol RateTableViewDelegate : class {
    func didRateChange()
}

class EpisodeViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
     var episodes: [Episode] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib.init(nibName: "EpisodeTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "EpisodeTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        self.setupNotifications()
        self.setupData(1)
    }
    
    deinit {
        let noteName = Notification.Name(rawValue: "DidFavouritesChange")
        NotificationCenter.default.removeObserver(self, name: noteName, object: nil)
        let rateNoteName = Notification.Name(rawValue: "DidRateChange")
        NotificationCenter.default.removeObserver(self, name: rateNoteName, object: nil)
        
        let removeRatingsName = Notification.Name(rawValue: "RemoveRatingsName")
        NotificationCenter.default.removeObserver(self, name: removeRatingsName, object: nil)
    }
    
    func setupData(_ seasonNumber: Int) {
        if let pathURL = Bundle.main.url(forResource: "season_\(seasonNumber)", withExtension: "json") {
            do {
                let data = try Data.init(contentsOf: pathURL)
                       let decoder = JSONDecoder()
                       episodes = try decoder.decode([Episode].self, from: data)
                       tableView.reloadData()
            } catch {
                fatalError(error.localizedDescription)
            }
        } else {
            fatalError("Could not load path url")
        }
    }
    
    func setupNotifications(){
        let noteName = Notification.Name(rawValue: "DidFavouritesChange")
        NotificationCenter.default.addObserver(self, selector: #selector(self.didTableDataChange), name: noteName, object: nil)
        let rateNoteName = Notification.Name(rawValue: "DidRateChange")
        NotificationCenter.default.addObserver(self, selector: #selector(self.didTableDataChange), name: rateNoteName, object: nil)
    }
    
    @objc func didTableDataChange() {
        tableView.reloadData()
    }
    
    @IBAction func setSeason(_ sender: UISegmentedControl) {
        let seasonNumber = sender.selectedSegmentIndex + 1
        self.setupData(seasonNumber)
    }
    
    // MARK: -UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 148
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVc = EpisodeDetailViewController()
        detailVc.episode = episodes[indexPath.row]
        self.navigationController?.pushViewController(detailVc, animated: true)
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: -UITableViewDatasource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: "EpisodeTableViewCell", for: indexPath) as? EpisodeTableViewCell {
            cell.setEpisode(episodes[indexPath.row])
            cell.rateBlock = {
                let rateViewController = RateViewController.init(withEpisode: self.episodes[indexPath.row])
                let navigationController = UINavigationController.init(rootViewController: rateViewController)
                self.present(navigationController, animated: true, completion: nil)
            }
            return cell
        }
        fatalError("Could not create Episode cell")
    }
}

