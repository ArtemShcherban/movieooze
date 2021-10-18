//
//  SimilarMoviesCollectionViewModel.swift
//  Movieooze
//
//  Created by Artem Shcherban on 13.09.2021.
//

import Foundation

class SimilarMoviesCollectionViewModel {
    
    var arrayOfSimilarMovies: [SimilarMovie] = []
    
    func similarMovieRequest(movieID: Int, completion: @escaping(() -> ())) {
        SimilarMoviesCollectionNetworkService.alamofireSimilarMoviesRequest(movieID: movieID) { similarMoviesData in
            self.arrayOfSimilarMovies = similarMoviesData.results ?? []
            completion()
        }
    }
    
    func numberOfRows() -> Int {
        return arrayOfSimilarMovies.count
    }
    
    func createCellViewModel(indexPath: IndexPath) -> SimilarMoviesCellCollectionViewModel {
        let movie = arrayOfSimilarMovies[indexPath.row]
        return SimilarMoviesCellCollectionViewModel(movie: movie)
    }
}
