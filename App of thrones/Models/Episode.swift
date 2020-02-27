//
//  Episode.swift
//  App of thrones
//
//  Created by Antonio Miguel Roldan de la Rosa on 13/02/2020.
//  Copyright © 2020 Antonio Roldan de la Rosa. All rights reserved.
//

import Foundation

class Episode : Identifiable, Codable, CustomStringConvertible, Equatable {
    static func == (lhs: Episode, rhs: Episode) -> Bool {
        return lhs.name == rhs.name && lhs.date == rhs.date && lhs.image == rhs.image && lhs.episode == rhs.episode && lhs.season == rhs.season && lhs.overview == rhs.overview
    }
    
    var description: String {
        return "Episode name: \(self.name ?? ""), episode date: \(self.date ?? "") episode image: \(self.image ?? "") episode number: \(self.episode ?? 0), episode season: \(self.season) episode overview: \(self.overview ?? "")"
    }
    
    
    var id: Int
    var name: String?
    var date: String?
    var image: String?
    var episode: Int?
    var season: Int
    var overview: String? = nil
    
    init(id: Int, name: String?, date: String?, image: String, episode: Int?, season: Int, overview: String) {
        self.id = id
        self.name = name
        self.date = date
        self.image = image
        self.episode = episode
        self.season = season
        self.overview = overview
    }
}

