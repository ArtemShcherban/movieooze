//
//  SearchNetworkViewModel.swift
//  Movieooze
//
//  Created by Artem Shcherban on 17.11.2021.
//

import Foundation

class SearchNetworkViewModel {
   
    var results: MultiSearch! = nil
    var array: [MultiSearchResults] = []
    
    var movieSearchResult: MovieSearch! = nil
    var arrayOFMovies: [MovieSearchResult] = []
    
    var personSearchResult: PersonSearch! = nil
    var arrayOfPersons: [PersonSearchResults] = []
    
    var tvShowSearchResult: TvShowSearch! = nil
    var arrayOfTvShows: [TvShowSearchResults] = []
    
    var numberOfResults = 0
    
    func getResultOfSearch(search: String, completion: @escaping(() -> ())) {
     
        Constants.Network.startTime = DispatchTime.now()
        var finishTasks = 0
        
        SearchNetworkService.alamofireMovieSearchRequest(search: search) { resultOfSearch in
            self.movieSearchResult = resultOfSearch.self
            self.arrayOFMovies = self.movieSearchResult.results ?? []
            
            self.numberOfResults += self.arrayOFMovies.count
            finishTasks += 1
            if finishTasks == 3 {
                completion()
            }
        }
        
        SearchNetworkService.alamofirePersonSearchRequest(search: search) { resultOfSearch in
           
            self.personSearchResult = resultOfSearch.self
            self.arrayOfPersons = self.personSearchResult.results ?? []
            
            self.numberOfResults += self.arrayOfPersons.count
            finishTasks += 1
            if finishTasks == 3 {
                completion()
            }
        }
        
        SearchNetworkService.alamofireTvShowSearchRequest(search: search) { resultOfSearch in
           
            self.tvShowSearchResult = resultOfSearch.self
            self.arrayOfTvShows = self.tvShowSearchResult.results ?? []
            
            self.numberOfResults += self.arrayOfTvShows.count
            finishTasks += 1
            if finishTasks == 3 {
                completion()
            }
        }
 
    }
    
    func indexOfViewController() -> Int {
       var index = 0
        if self.arrayOFMovies.count >= self.arrayOfTvShows.count && self.arrayOFMovies.count >= self.arrayOfPersons.count {
            index = 0
        
        }else if self.arrayOfTvShows.count > self.arrayOFMovies.count && self.arrayOfTvShows.count >= self.arrayOfPersons.count {
            index = 1
        
        }else if self.arrayOfPersons.count > self.arrayOFMovies.count && self.arrayOfPersons.count > self.arrayOfTvShows.count {
            index = 2
        }

        return index
    }
    
}
