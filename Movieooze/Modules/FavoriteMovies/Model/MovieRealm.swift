//
//  MovieRealm.swift
//  Movieooze
//
//  Created by Artem Shcherban on 12.08.2021.
//

import Foundation
import RealmSwift

class MovieForFavoritesRealm: Object {
    @objc dynamic var adult = false
    @objc dynamic var backdropPath = ""
    @objc dynamic var budget = 0
    @objc dynamic var genreIDFirst = 0
    @objc dynamic var genreIDSecond = 0
    @objc dynamic var homepage = ""
    @objc dynamic var id = 0
    @objc dynamic var imdbId = ""
    @objc dynamic var originalLanguage = ""
    @objc dynamic var originalTitle = ""
    @objc dynamic var overview = ""
    @objc dynamic var popularity = 0.0
    @objc dynamic var posterPath = ""
    @objc dynamic var releaseDate = ""
    @objc dynamic var revenue = 0
    @objc dynamic var runtime = 0
    @objc dynamic var status = ""
    @objc dynamic var tagline = ""
    @objc dynamic var title = ""
    @objc dynamic var video = false
    @objc dynamic var voteAverage = 0.0
    @objc dynamic var voteCount = 0
}
