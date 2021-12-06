//
//  FavoriteTVShowTableViewViewModel.swift
//  Movieooze
//
//  Created by Artem Shcherban on 09.10.2021.
//

import Foundation

class FavoriteTVShowTableViewViewModel {
    
    var arrayOfTVShowsForFavorites : [TVShow] = []
    
    func getTVShowsFromRealm(completion: @escaping(() -> ())) {
        RealmManagerTVShow.shared.readFromRealmTVShowForFavorites(completion: { tvShows in arrayOfTVShowsForFavorites = tvShows
        })
        completion()
    }
    
    func numberOfRows() -> Int {
        return arrayOfTVShowsForFavorites.count
    }
    
    func createCellViewModel(indexPath: IndexPath) -> TvShowCellViewModel{
        let tvShow = arrayOfTVShowsForFavorites[indexPath.row]
        return TvShowCellViewModel(tvShow: tvShow)
    }
    
    func createCellViewModel(indexPath: IndexPath, filteredArray: [TVShow]) -> TvShowCellViewModel{
        let tvShow = filteredArray[indexPath.row]
        return TvShowCellViewModel(tvShow: tvShow)
    }
}
