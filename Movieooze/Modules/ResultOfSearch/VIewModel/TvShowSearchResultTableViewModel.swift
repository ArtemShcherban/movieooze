//
//  TvShowSearchResultTableViewModel.swift
//  Movieooze
//
//  Created by Artem Shcherban on 04.12.2021.
//

import Foundation

class TvShowSearchResultTableViewModel {
    
    var arrayOfTvShowSearchResult: [TVShow] = []
    
    func getTvShowSearchResult(searchNetworkViewModel: SearchNetworkViewModel) {
        let tvShowSearchResult = searchNetworkViewModel.arrayOfTvShows
        for eachTvShow in tvShowSearchResult {
            let tvShow = TVShow(from: eachTvShow)
            arrayOfTvShowSearchResult.append(tvShow)
        }
    }
    
    func numberOfRows() -> Int {
        return arrayOfTvShowSearchResult.count
    }
    
    func createCellViewModel(indexPath: IndexPath) -> TvShowCellViewModel {
        let tvShow = arrayOfTvShowSearchResult[indexPath.row]
        return TvShowCellViewModel(tvShow: tvShow)
    }
}
