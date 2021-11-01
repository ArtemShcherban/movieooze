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

