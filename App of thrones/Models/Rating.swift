//
//  Rating.swift
//  App of thrones
//
//  Created by Antonio Miguel Roldan de la Rosa on 18/02/2020.
//  Copyright © 2020 Antonio Roldan de la Rosa. All rights reserved.
//

import Foundation

enum Rate {
    case unrated
    case rated(value: Double)
}

extension Rate : Equatable {
    static func ==(lhs: Rate, rhs: Rate) -> Bool {
        switch (lhs, rhs) {
        case (let .rated(rating1), let .rated(rating2)):
            return rating1 == rating2

        case (.unrated, .unrated):
            return true
        default:
            return false
        }
    }
}

struct Rating : CustomStringConvertible, Equatable {
    var description: String {
        switch self.rate {
        case .unrated:
            return "No rating"
        case .rated(let value):
            return "Rating of \(value)"
        }
    }
    
    static func ==(lhs: Rating, rhs: Rating) -> Bool {
        return lhs.rate == rhs.rate
    }
    
    var id: Int
    var rate: Rate
}
