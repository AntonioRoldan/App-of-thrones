//
//  Cast.swift
//  App of thrones
//
//  Created by Antonio Miguel Roldan de la Rosa on 18/02/2020.
//  Copyright © 2020 Antonio Roldan de la Rosa. All rights reserved.
//

import Foundation

class Cast : Identifiable, Codable, CustomStringConvertible, Equatable {
    static func == (lhs: Cast, rhs: Cast) -> Bool {
        return lhs.avatar == rhs.avatar && lhs.fullname == rhs.fullname && lhs.role == rhs.role && lhs.episodes == rhs.episodes && lhs.birth == rhs.birth && lhs.placeBirth == rhs.placeBirth
    }
    
    var description: String {
        return "Cast with name \(self.fullname ?? "") and role name: \(self.role ?? "") appears in \(self.episodes ?? 0) episodes. Born on \(self.birth ?? "") in \(self.placeBirth ?? "")"
    }
    
    var id: Int
    var avatar: String?
    var fullname: String?
    var role: String?
    var episodes: Int?
    var birth: String?
    var placeBirth: String?
    init(id: Int, avatar: String?, fullname: String?, role: String?, episodes: Int?, birth: String?, placeBirth: String?){
        self.id = id
        self.avatar = avatar
        self.fullname = fullname
        self.role = role
        self.episodes = episodes
        self.birth = birth
        self.placeBirth = placeBirth
    }
}
