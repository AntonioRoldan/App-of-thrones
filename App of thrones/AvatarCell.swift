//
//  CastAvatarCell.swift
//  App of thrones
//
//  Created by Antonio Miguel Roldan de la Rosa on 25/02/2020.
//  Copyright © 2020 Antonio Roldan de la Rosa. All rights reserved.
//

import UIKit

class AvatarCell : UITableViewCell {
    
    @IBOutlet weak var avatar: UIImageView!
    
    var avatarCellData : cellTypeModel? {
        didSet {
            guard let avatarCellData = avatarCellData as? AvatarCellData, let avatarName = avatarCellData.avatarName else {
                fatalError("Could not get avatar name")
            }
            avatar.image = UIImage(named: avatarName)
        }
    }
    
    override func awakeFromNib() {
        avatar.layer.cornerRadius = 4.0
    }
}
