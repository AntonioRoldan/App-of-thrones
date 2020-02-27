//
//  HouseTableViewCell.swift
//  App of thrones
//
//  Created by Antonio Miguel Roldan de la Rosa on 18/02/2020.
//  Copyright © 2020 Antonio Roldan de la Rosa. All rights reserved.
//

import UIKit

class HouseTableViewCell : UITableViewCell {
    
    
    
    @IBOutlet weak var houseImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var slogan: UILabel!
    @IBOutlet weak var seat: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        houseImage.layer.cornerRadius = 4
        houseImage.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        houseImage.layer.borderWidth = 1.0
    }
    func setHouse(house: House){
        houseImage.image = UIImage(named: house.imageName ?? " ")
        title.text = house.name
        slogan.text = house.words
        seat.text = house.seat
    }
}
