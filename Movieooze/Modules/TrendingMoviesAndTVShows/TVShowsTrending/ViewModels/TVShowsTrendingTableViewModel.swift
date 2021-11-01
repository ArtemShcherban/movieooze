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
    
    func tvShowsGenresRequest(completion: () -> ()) {
        TVShowsTrendingNetworkService.alamofireGenresListRequest { dataFromTMBD in
            ListOfGenres.addTvShowsGenresToArray(array: dataFromTMBD.genres ?? [])
        }
    }
    
    func numberOfRows() -> Int {
        return arrayOfTVShows.count
    }
    
    func createCellViewModel(indexPath: IndexPath) -> TVShowTrendingCellViewModel{
        let tvShow = arrayOfTVShows[indexPath.row]
        return TVShowTrendingCellViewModel(tvShow: tvShow)
    }
}
