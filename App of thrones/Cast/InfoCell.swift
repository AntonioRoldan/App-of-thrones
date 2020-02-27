//
//  CastInfoCell.swift
//  App of thrones
//
//  Created by Antonio Miguel Roldan de la Rosa on 25/02/2020.
//  Copyright © 2020 Antonio Roldan de la Rosa. All rights reserved.
//

import UIKit

class InfoCell : UITableViewCell {
    
    @IBOutlet weak var header: UILabel!
    
    @IBOutlet weak var infoLabelOne: UILabel!
    
    @IBOutlet weak var infoLabelTwo: UILabel!
    
    var infoCellData : cellTypeModel? {
        didSet {
            guard let infoCellData = infoCellData as? infoCellData else { fatalError("Could not load info cell data") }
            switch infoCellData.header {
            case "Role information":
                infoLabelOne.text = "Name: \(infoCellData.labels[0] ?? "" ), Role name: \(infoCellData.labels[1] ?? "")"
                infoLabelTwo.text = "Appears in \(infoCellData.labels[2] ?? "0") episodes"
                header.text = infoCellData.header
                break
            case "Birth information":
                infoLabelOne.text = "Date of birth: \(infoCellData.labels[0] ?? "")"
                infoLabelTwo.text = "Place of birth: \(infoCellData.labels[1] ?? "")"
                header.text = infoCellData.header
                break
            case "Name and date":
                infoLabelOne.text = "Name: \(infoCellData.labels[0] ?? "")"
                infoLabelTwo.text = "Date: \(infoCellData.labels[1] ?? "")"
                header.text = infoCellData.header
                break
            case "Season and episode":
                infoLabelOne.text = "Season: \(infoCellData.labels[0] ?? "")"
                infoLabelTwo.text = "Episode: \(infoCellData.labels[1] ?? "")"
                header.text = infoCellData.header
                break 
            default:
                break
            }
        }
    }
    
    
    override func awakeFromNib() {
        print("Cell was initialised")
    }
}
