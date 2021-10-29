//
//  SimilarTvShowsViewModel.swift
//  Movieooze
//
//  Created by Artem Shcherban on 18.10.2021.
//

import Foundation

class SimilarTvShowsCollectionViewModel {
    var arrayOfSimilarTvShows: [SimilarTvShow] = []
    
    func similarTvShowsRequest(tvShowID: Int, completion: @escaping(() -> ())) {
        SimilarTvShowsCollectionNetworkService.alamofireSimilarTvShowsRequest(tvShowID: tvShowID) { similarTvShowsData in
            self.arrayOfSimilarTvShows = similarTvShowsData.results ?? []
            completion()
        }
    }
    
    func numberOfRows() -> Int {
        return arrayOfSimilarTvShows.count
    }
    
    func createCellViewModel(indexPath: IndexPath) -> SimilarTvShowsCellCollectionViewModel {
        let tvShow = arrayOfSimilarTvShows[indexPath.row]
        return SimilarTvShowsCellCollectionViewModel(tvShow: tvShow)
    }
}
