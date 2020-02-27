//
//  CastTableViewCell.swift
//  App of thrones
//
//  Created by Antonio Miguel Roldan de la Rosa on 17/02/2020.
//  Copyright © 2020 Antonio Roldan de la Rosa. All rights reserved.
//

import UIKit

class CastTableViewCell : UITableViewCell {
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var role: UILabel!
    @IBOutlet weak var episodes: UILabel!
    var reloadData: (() -> Void)?
    var isFavourite: Bool = false
    var cast: Cast? {
        didSet {
            avatar.image = UIImage(named: cast?.avatar ?? "")
            name.text = cast?.fullname
            role.text = cast?.role
            episodes.text = "\(cast?.episodes ?? 0) episodes"
        }
    }
    
    @IBAction func toggleFavourite(_ sender: Any) {
        guard let cast = self.cast else {
            fatalError("Cast being passed to CastTableViewCell is nil")
        }
        self.isFavourite ?             DataController.shared.removeFavourite(cast) : DataController.shared.addFavourite(cast)
        self.reloadData?()
    }
    override func awakeFromNib() {
        avatar.layer.cornerRadius = 8
        avatar.layer.borderWidth = 1.0
        avatar.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
    }
    func setCast(cast: Cast){
        self.cast = cast
        if DataController.shared.isFavourite(cast){
            self.isFavourite = true
            likeButton.setImage(UIImage.init(systemName: "heart.fill"), for: .normal)
        } else {
            self.isFavourite = false
            likeButton.setImage(UIImage.init(systemName: "heart"), for: .normal)
        }
    }
}
