//
//  MoviesTrendingTableViewViewModel.swift
//  Movieooze
//
//  Created by Artem Shcherban on 11.09.2021.
//

import Foundation

class MoviesTrendingTableViewViewModel {
    
    
    var arrayOfMovies: [Movie] = []

    
    func moviesTrendingRequest(completion: @escaping(() -> ())) {
        
        MoviesTrendingNetworkService.alamofireMoviesListRequest { dataFromTMBD in
            self.arrayOfMovies = dataFromTMBD.results ?? []
            completion()
        }
    }
    
    func moviesGenresRequest(completion: @escaping(() -> ())) {
        MoviesTrendingNetworkService.alamofireGenresListRequest { dataFromTMBD in
            ListOfGenres.arrayOFGenres = dataFromTMBD.genres ?? []
            completion()
        }
    }
    
    func numberOfRows() -> Int {
        return arrayOfMovies.count
    }
    
    func createCellViewModel(indexPath: IndexPath) -> MoviesTrendingCellViewModel{
        let movie = arrayOfMovies[indexPath.row]
        return MoviesTrendingCellViewModel(movie: movie)
    }
}

