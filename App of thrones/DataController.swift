//
//  DataController.swift
//  App of thrones
//
//  Created by Antonio Miguel Roldan de la Rosa on 17/02/2020.
//  Copyright © 2020 Antonio Roldan de la Rosa. All rights reserved.
//

import Foundation

protocol FavouriteDelegate : class {
     func didFavouriteChange()
}

protocol Identifiable {
    var id: Int { get }
}

class DataController {
    static var shared = DataController()
    private init() {}
    
    private var rating: [Rating] = []
    
    private var favourites: [Int] = []

    
    func isFavourite<T: Identifiable>(_ value: T) -> Bool {
        return favourites.contains(value.id)
    }
    
    func addFavourite<T: Identifiable>(_ value: T){
        if !self.isFavourite(value) {
            favourites.append(value.id)
        }
    }
    
    func removeFavourite<T: Identifiable>(_ value: T) {
        favourites.removeAll(where: {
            $0 == value.id
        })
    }
    
    func clearFavourites(){
        favourites.removeAll()
    }
    
    func clearRatings(){
        rating.removeAll()
    }
    
    func removeRateEpisode(_ episode: Episode) {
        if let index = self.rating.firstIndex(where: { (rating) -> Bool in
            return episode.id == rating.id
        }) {
            self.rating.remove(at: index)
        }
    }
    
    func ratingForEpisode(_ episode: Episode) -> Rating? {
        let filtered = rating.filter {
            return $0.id == episode.id
        }
        return filtered.first
    }
    
    func rateEpisode(_ episode: Episode, value: Double){
        if self.ratingForEpisode(episode) == nil {
            let rateValue = Rating.init(id: episode.id, rate: Rate.rated(value: value))
            rating.append(rateValue)
        }
    }
}

