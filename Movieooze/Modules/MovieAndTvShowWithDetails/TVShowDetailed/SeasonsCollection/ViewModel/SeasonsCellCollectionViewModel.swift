//
//  SeasonsCellCollectionViewModel.swift
//  Movieooze
//
//  Created by Artem Shcherban on 30.09.2021.
//

import Foundation

class SeasonsCellCollectionViewModel {
    var season: Seasons!
    
    var air_date : String {
        season.air_date ?? ""
    }
    var episode_count : Int {
        season.episode_count ?? 0
    }
    var id : Int {
        season.id ?? 0
    }
    var name : String {
        season.name ?? ""
    }
    var overview : String {
        season.overview ?? ""
    }
    var poster_path : String {
        season.poster_path ?? ""
    }
    var season_number : Int {
        season.season_number ?? 0
    }
    init(season: Seasons) {
        self.season = season
    }
}
