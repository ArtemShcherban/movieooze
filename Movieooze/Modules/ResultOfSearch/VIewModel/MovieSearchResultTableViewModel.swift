//
//  MovieSearchResultTableViewViewModel.swift
//  Movieooze
//
//  Created by Artem Shcherban on 03.12.2021.
//

import Foundation

class MovieSearchResultTableViewModel {
    
    var arrayOfMovieSearchResult: [Movie] = []
    
    func getMovieSearchResult(searchNetworkViewModel: SearchNetworkViewModel) {
        let  movieSearchResult = searchNetworkViewModel.arrayOFMovies
        for eachMovie in movieSearchResult {
            let movie = Movie(from: eachMovie)
            arrayOfMovieSearchResult.append(movie)
        }
    }
        func numberOfRows() -> Int {
            return arrayOfMovieSearchResult.count
        }
        
        func createCellViewModel(indexPath: IndexPath) -> MoviesCellViewModel {
            let movie = arrayOfMovieSearchResult[indexPath.row]
            return MoviesCellViewModel(movie: movie)
        }
    }

