//
//  TVShowRealm.swift
//  Movieooze
//
//  Created by Artem Shcherban on 09.10.2021.
//

import Foundation
import RealmSwift

class TVShowForFavoritesRealm: Object {
    @objc dynamic var backdrop_path = ""
    @objc dynamic var first_air_date = ""
    @objc dynamic var genreIdFirst = 0
    @objc dynamic var genreIdSecond = 0
    @objc dynamic var homepage = ""
    @objc dynamic var id = 0
    @objc dynamic var in_production = false
    @objc dynamic var last_air_date = ""
    @objc dynamic var name = ""
    @objc dynamic var number_of_episodes = 0
    @objc dynamic var number_of_seasons = 0
    @objc dynamic var origin_country = ""
    @objc dynamic var original_language = ""
    @objc dynamic var original_name = ""
    @objc dynamic var overview = ""
    @objc dynamic var popularity = 0.0
    @objc dynamic var poster_path = ""
    @objc dynamic var status = ""
    @objc dynamic var tagline = ""
    @objc dynamic var type = ""
    @objc dynamic var vote_average = 0.0
    @objc dynamic var vote_count = 0
    
}

//    @objc dynamic var created_by : [Created_by] = []
//    @objc dynamic var episode_run_time : [Int]?
//    @objc dynamic var languages : [String]?
//    @objc dynamic var last_episode_to_air : Last_episode_to_air?
//    @objc dynamic var next_episode_to_air : Next_episode_to_air?
//    @objc dynamic var networks : [Networks]?
//    @objc dynamic var origin_country : [String]?
//    @objc dynamic var production_companies : [ProductionCompanies]?
//    @objc dynamic var production_countries : [ProductionCountries]?
//    @objc dynamic var seasons : [Seasons]?
//    @objc dynamic var spoken_languages : [Spoken_languages]?
//    @objc dynamic var credits : Credits?
