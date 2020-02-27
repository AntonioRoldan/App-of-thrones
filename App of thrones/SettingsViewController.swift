//
//  SettingsViewController.swift
//  App of thrones
//
//  Created by Antonio Miguel Roldan de la Rosa on 22/02/2020.
//  Copyright © 2020 Antonio Roldan de la Rosa. All rights reserved.
//

import UIKit

class SettingsViewController : UIViewController {
    
    @IBAction func clearFavourites(_ sender: Any) {
        DataController.shared.clearFavourites()
        let noteName = Notification.Name(rawValue: "DidFavouritesChange")
        NotificationCenter.default.post(name: noteName, object: nil)
    }
    
    @IBAction func clearRatings(_ sender: Any) {
        DataController.shared.clearRatings()
        let removeRatingsName = Notification.Name(rawValue: "DidRateChange")
        NotificationCenter.default.post(name: removeRatingsName, object: nil)
    }
}
