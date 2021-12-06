//
//  FavoriteMoviesTableViewViewModel.swift
//  Movieooze
//
//  Created by Artem Shcherban on 12.09.2021.
//

import Foundation

class FavoriteMoviesTableViewViewModel {
    
    var arrayOfMoviesForFavorites : [Movie] = []
    
    func getMoviesFromRealm(completion: @escaping(() -> ())) {
        RealmManager.shared.readFromRealmMovieForFavorites(completion: { movies in arrayOfMoviesForFavorites = movies
        })
        completion()
    }

    
    func numberOfRows() -> Int {
        return arrayOfMoviesForFavorites.count
    }
    
    func createCellViewModel(indexPath: IndexPath) -> MoviesCellViewModel{
        let movie = arrayOfMoviesForFavorites[indexPath.row]
        return MoviesCellViewModel(movie: movie)
    }
    
    func createCellViewModel(indexPath: IndexPath, filteredArray: [Movie]) -> MoviesCellViewModel{
        let movie = filteredArray[indexPath.row]
        return MoviesCellViewModel(movie: movie)
    }
}

