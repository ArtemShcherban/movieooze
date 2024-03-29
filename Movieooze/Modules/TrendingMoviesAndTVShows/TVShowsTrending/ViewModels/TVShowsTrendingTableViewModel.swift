//
//  TVShowsTrendingTableViewModel.swift
//  Movieooze
//
//  Created by Artem Shcherban on 20.09.2021.
//

import Foundation

class TVShowsTrendingTableViewModel {
    var arrayOfTVShows: [TVShow] = []
    
    func tvShowsTrendingRequest(completion: @escaping(() -> ())) {
        TVShowsTrendingNetworkService.alamofireTVShowsListRequest { dataFromTMBD in
            self.arrayOfTVShows = dataFromTMBD.results ?? []
            completion()
        }
    }
    
    func tvShowsGenresRequest(completion: @escaping(() -> ())) {
        TVShowsTrendingNetworkService.alamofireGenresListRequest { dataFromTMBD in
            ListOfGenres.addTvShowsGenresToArray(array: dataFromTMBD.genres ?? [])
            completion()
        }
    }
    
    func numberOfRows() -> Int {
        return arrayOfTVShows.count
    }
    
    func createCellViewModel(indexPath: IndexPath) -> TvShowCellViewModel{
        let tvShow = arrayOfTVShows[indexPath.row]
        return TvShowCellViewModel(tvShow: tvShow)
    }
}
