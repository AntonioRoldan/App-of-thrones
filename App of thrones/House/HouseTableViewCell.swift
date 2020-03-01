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
    @IBOutlet weak var favButton: UIButton!
    var isFavourite : Bool = false
    var house : House?
    var reloadData : (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        houseImage.layer.cornerRadius = 4
        houseImage.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        houseImage.layer.borderWidth = 1.0
    }
    
    //MARK: IBActions
    
    @IBAction func pressFav(_ sender: Any) {
        guard let house = self.house else { fatalError("Could not unwrap house in house table view cell")}
        if(self.isFavourite){
            DataController.shared.removeFavourite(house)
        } else {
            DataController.shared.addFavourite(house)
        }
        self.reloadData?()
    }
    
    func setHouse(house: House){
        self.house = house
        if(DataController.shared.isFavourite(house)){
            favButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            self.isFavourite = true
        } else {
            favButton.setImage(UIImage(systemName: "heart"), for: .normal)
            self.isFavourite = false
        }
        houseImage.image = UIImage(named: house.imageName ?? " ")
        title.text = house.name
        slogan.text = house.words
        seat.text = house.seat
    }
}
