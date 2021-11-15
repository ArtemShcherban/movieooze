//
//  RealmManagerTVShow.swift
//  Movieooze
//
//  Created by Artem Shcherban on 09.10.2021.
//

import Foundation
import RealmSwift

struct RealmManagerTVShow {
    static let shared = RealmManagerTVShow()
    
    let realm = try? Realm()
    
    // MARK: - Создание и запись экземпляра реалм
    
    func createAndSaveTVShowForFavorites (tvShow: TVShowDetails) {
        let tvShowForFavorites = TVShowForFavoritesRealm()
        tvShowForFavorites.backdrop_path = tvShow.backdrop_path ?? ""
        tvShowForFavorites.first_air_date = tvShow.first_air_date ?? ""
        tvShowForFavorites.homepage = tvShow.homepage ?? ""
        tvShowForFavorites.id = tvShow.id ?? 0
        tvShowForFavorites.in_production = tvShow.in_production ?? false
        tvShowForFavorites.last_air_date = tvShow.last_air_date ?? ""
        tvShowForFavorites.name = tvShow.name ?? ""
        tvShowForFavorites.number_of_episodes = tvShow.number_of_episodes ?? 0
        tvShowForFavorites.number_of_seasons = tvShow.number_of_seasons ?? 0
        tvShowForFavorites.origin_country = getOriginCountry(tvShow: tvShow)
        tvShowForFavorites.original_language = tvShow.original_language ?? ""
        tvShowForFavorites.original_name = tvShow.original_name ?? ""
        tvShowForFavorites.overview = tvShow.overview ?? ""
        tvShowForFavorites.popularity = tvShow.popularity ?? 0.0
        tvShowForFavorites.poster_path = tvShow.poster_path ?? ""
        tvShowForFavorites.status = tvShow.status ?? ""
        tvShowForFavorites.tagline = tvShow.tagline ?? ""
        tvShowForFavorites.type = tvShow.type ?? ""
        tvShowForFavorites.vote_average = tvShow.vote_average ?? 0.0
        tvShowForFavorites.vote_count = tvShow.vote_count ?? 0
        getGenres(tvShowForFavorites: tvShowForFavorites, tvShow: tvShow)
        
        try? realm?.write {
            realm?.add(tvShowForFavorites)
        }
    }
        
        func getOriginCountry(tvShow: TVShowDetails) -> String {
            if tvShow.origin_country?.count ?? 0 > 0 {
                let country = tvShow.origin_country?[0] ?? ""
                return country
            } else {
                return ""
            }
        }
        
    func getGenres(tvShowForFavorites: TVShowForFavoritesRealm, tvShow: TVShowDetails) {
            if tvShow.genres?.count ?? 0 > 0 && tvShow.genres?.count ?? 0 >= 2 {
                tvShowForFavorites.genreIdFirst = tvShow.genres?[0].id ?? 0
                tvShowForFavorites.genreIdSecond = tvShow.genres?[1].id ?? 0
            } else if tvShow.genres?.count ?? 0 == 1 {
                tvShowForFavorites.genreIdFirst = tvShow.genres?[0].id ?? 0
                tvShowForFavorites.genreIdSecond = 0
            } else {
                tvShowForFavorites.genreIdFirst = 0
                tvShowForFavorites.genreIdSecond = 0
            }
        }
    
    // MARK: - Чтение
    
    func readFromRealmTVShowForFavorites(completion: ([TVShow]) ->()) {
        var   arrayOfTVShowsFromRealm: [TVShowForFavoritesRealm] = []
        guard let tvShowForFavoritesRealm = realm?.objects(TVShowForFavoritesRealm.self) else { return }
        for eachTVShow in tvShowForFavoritesRealm {
            arrayOfTVShowsFromRealm.append(eachTVShow)
        }
        completion(convertTVShowForFavoritesToTVShow(TVShowsFromRealm: arrayOfTVShowsFromRealm))
    }
    
    func convertTVShowForFavoritesToTVShow(TVShowsFromRealm: [TVShowForFavoritesRealm]) -> [TVShow] {
        var tvShows = [TVShow]()
        for eachTVShow in TVShowsFromRealm {
            let tvShow = TVShow(from: eachTVShow)
            tvShows.append(tvShow)
        }
        return tvShows
    }
    
    // MARK: - Удаление объекта из Realm
    
    func deleteTVShowForFavoritesFromRealmByID(tvShowID: Int) {
        if let tvShowForFavoritesInRealm = realm?.objects(TVShowForFavoritesRealm.self).filter("id = \(tvShowID)") {
            try? realm?.write {
                realm?.delete(tvShowForFavoritesInRealm)
            }
        }
    }
    
    func deleteAllDataFromRealmTVShowForFavorites() {
        if let tvShowsForFavoritesInRealm = realm?.objects(TVShowForFavoritesRealm.self) {
            try? realm?.write {
                realm?.delete(tvShowsForFavoritesInRealm)
            }
        }
    }
    // MARK: - Поиск объекта по ID в Realm
    
    func searchTVShowForFavoritesIDInRealm(tvShowID: Int) -> Bool {
        let resultSearchInRealm = realm?.objects(TVShowForFavoritesRealm.self).filter("id = \(tvShowID)")
        if resultSearchInRealm == nil {
            return false
        } else if resultSearchInRealm?.count == 0 {
            return false
        } else {
            return true
        }
    }
    
    }

