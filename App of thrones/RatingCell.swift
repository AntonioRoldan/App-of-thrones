//
//  RatingCell.swift
//  App of thrones
//
//  Created by Antonio Miguel Roldan de la Rosa on 26/02/2020.
//  Copyright © 2020 Antonio Roldan de la Rosa. All rights reserved.
//

import UIKit

class RatingCell: UITableViewCell {
    
    
    @IBOutlet weak var star01: UIImageView!
    
    
    @IBOutlet weak var star02: UIImageView!
    
    @IBOutlet weak var star03: UIImageView!
    
    @IBOutlet weak var star04: UIImageView!
    
    @IBOutlet weak var star05: UIImageView!
    @IBOutlet weak var rateButton: UIButton!
    
    var rateTransition : (() -> ())?
    
    var episode : Episode? {
        didSet{
            if let episode = episode, let rating = DataController.shared.ratingForEpisode(episode){
                       switch rating.rate {
                       case .rated(let value):
                           self.setRating(value)
                       case .unrated:
                           self.modeRate()
                       }
                   } else {
                       self.modeRate()
                   }
        }
    }
    
    var ratingCellData : cellTypeModel? {
        didSet{
            guard let ratingCellData = ratingCellData as? ratingCellData else {fatalError("Could not load rating cell data")}
            episode = ratingCellData.episode
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        rateButton.layer.cornerRadius = 8
    }
    @IBAction func rateButton(_ sender: Any) {
        self.rateTransition?()
    }
    
    func modeRate() {
        rateButton.isHidden = false
        star01.isHidden = true
        star02.isHidden = true
        star03.isHidden = true
        star04.isHidden = true
        star05.isHidden = true
    }
    func modeStar() {
        rateButton.isHidden = true
               star01.isHidden = false
               star02.isHidden = false
               star03.isHidden = false
               star04.isHidden = false
               star05.isHidden = false
    }
    
    func setRating(_ rating: Double){
        self.modeStar()
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
}
