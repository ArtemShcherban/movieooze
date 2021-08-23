//
//  MovieRealm.swift
//  Movieooze
//
//  Created by Artem Shcherban on 12.08.2021.
//

import Foundation
import RealmSwift


class FavoriteMovieRealm: Object {
    @objc dynamic var genreIdFirst = 0
    @objc dynamic var genreIdSecond = 0
    @objc dynamic var id = 0
    @objc dynamic var originalLanguage = ""
    @objc dynamic var originalTitle = ""
    @objc dynamic var posterPath = ""
    @objc dynamic var video = false
    @objc dynamic var voteAverage = 0.0
    @objc dynamic var overview = ""
    @objc dynamic var releaseDate = ""
    @objc dynamic var voteCount = 0
    @objc dynamic var adult = false
    @objc dynamic var backdropPath = ""
    @objc dynamic var title = ""
    @objc dynamic var popularity = 0.0
    @objc dynamic var mediaType = ""
}



