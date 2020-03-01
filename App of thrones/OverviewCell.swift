//
//  OverviewCell.swift
//  App of thrones
//
//  Created by Antonio Miguel Roldan de la Rosa on 26/02/2020.
//  Copyright © 2020 Antonio Roldan de la Rosa. All rights reserved.
//

import UIKit

class OverviewCell: UITableViewCell {
    
    
    @IBOutlet weak var overview: UILabel!
    
    var overviewCellData : cellTypeModel? {
        didSet{
            guard let overviewCellData = overviewCellData as? OverviewCellData else { fatalError("Could not load overview cell data")}
            overview.text = overviewCellData.overview
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }    
}
