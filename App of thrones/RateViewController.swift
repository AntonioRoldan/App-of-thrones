//
//  RateViewController.swift
//  App of thrones
//
//  Created by Antonio Miguel Roldan de la Rosa on 11/02/2020.
//  Copyright © 2020 Antonio Roldan de la Rosa. All rights reserved.
//

import UIKit

class RateViewController: UIViewController {

    @IBOutlet weak var star01: UIImageView!
    @IBOutlet weak var star02: UIImageView!
    @IBOutlet weak var star03: UIImageView!
    @IBOutlet weak var star04: UIImageView!
    @IBOutlet weak var star05: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
        
    private var episode: Episode?
    
    var imageName : String?
        
    convenience init (withEpisode episode: Episode) {
        self.init()
        self.episode = episode
        self.title = episode.name
        self.imageName = episode.image
    }
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var rateLabel: UILabel!
    
    @IBAction func sliderFire(_ sender: Any) {
        let valueDouble = Double(rateSlider.value)
        self.setRating(valueDouble)
    }
    @IBOutlet weak var rateSlider: UISlider!
    
    @IBOutlet weak var acceptButton: UIButton!
    
    func setRating(_ rating: Double) {
        rateLabel.text = String(Int(rating))
        self.setStarImage(star01, rating: rating, minValue: 0)
        self.setStarImage(star02, rating: rating, minValue: 2)
        self.setStarImage(star03, rating: rating, minValue: 4)
        self.setStarImage(star04, rating: rating, minValue: 6)
        self.setStarImage(star05, rating: rating, minValue: 8)
    }
    
    func setStarImage(_ imageView: UIImageView, rating: Double, minValue: Double){
        if rating >= minValue + 1.0 && rating < minValue + 2.0 {
            imageView.image = UIImage.init(systemName: "star.lefthalf.fill")
        } else if rating >= minValue{
            imageView.image = UIImage.init(systemName: "star.fill")
        } else {
            imageView.image = UIImage.init(systemName: "star")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        acceptButton.layer.cornerRadius = 4.0
        imageView.image = UIImage(named: self.imageName ?? "")
    }
    
    @IBAction func accept(_ sender: Any) {
        rateLabel.text = "Rate!"
        let rate = Double(Int(rateSlider.value))
        if let episode = self.episode { DataController.shared.rateEpisode(episode, value: rate)
            self.navigationController?.dismiss(animated: true, completion: nil)
        }
        let noteName = Notification.Name(rawValue: "DidRateChange")
        NotificationCenter.default.post(name: noteName, object: nil)
    }
}
