//
//  CastDetailCellModels.swift
//  App of thrones
//
//  Created by Antonio Miguel Roldan de la Rosa on 25/02/2020.
//  Copyright © 2020 Antonio Roldan de la Rosa. All rights reserved.
//

import Foundation

enum cellType {
    case avatar
    case infoCell
    case rating
    case overview
}

protocol cellTypeModel {
    var cellType: cellType {get}
}



struct avatarCellData : cellTypeModel {
    var cellType : cellType = .avatar
    let avatarName: String?
}

struct infoCellData : cellTypeModel {
    var cellType: cellType = .infoCell
    let header : String
    var labels : [String?] = []
}

struct ratingCellData: cellTypeModel {
    var cellType : cellType = .rating
    var episode : Episode
}

struct overviewCellData: cellTypeModel {
    var cellType: cellType = .overview
    let overview: String
}
