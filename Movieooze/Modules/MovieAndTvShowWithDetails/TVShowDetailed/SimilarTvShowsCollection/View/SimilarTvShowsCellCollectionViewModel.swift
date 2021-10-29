//
//  SimilarTvShowsCellCollectionViewModel.swift
//  Movieooze
//
//  Created by Artem Shcherban on 18.10.2021.
//

import Foundation

class SimilarTvShowsCellCollectionViewModel {
    
    private var tvShow: SimilarTvShow!
       
       var title: String {
        tvShow.name ?? ""
       }
       
       var posterPath : String {
           tvShow.poster_path ?? ""
       }
       
       init(tvShow: SimilarTvShow) {
           self.tvShow = tvShow
       }
}
