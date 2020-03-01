//
//  House.swift
//  App of thrones
//
//  Created by Antonio Miguel Roldan de la Rosa on 18/02/2020.
//  Copyright © 2020 Antonio Roldan de la Rosa. All rights reserved.
//

import Foundation

class House : Codable, CustomStringConvertible, Equatable, Identifiable {
    var description: String {
        return "House name: \(self.name ?? "") House words: \(self.words ?? "") House seat \(self.seat ?? "")"
    }
    
    static func == (lhs: House, rhs: House) -> Bool {
        return lhs.imageName == rhs.imageName && lhs.name == rhs.name && lhs.words == rhs.words && lhs.seat == rhs.seat
    }
    var id: Int
    var imageName: String?
    var name: String?
    var words: String?
    var seat: String? //El area en el que se mueve la casa
    init(id: Int, imageName: String?, name: String?, words: String?, seat: String?) {
        self.id = id
        self.imageName = imageName
        self.name = name
        self.words = words
        self.seat = seat
    }
}
