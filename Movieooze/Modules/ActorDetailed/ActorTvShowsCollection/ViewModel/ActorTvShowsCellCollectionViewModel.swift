//
//  ActorTvShowsCellCollectionViewModel.swift
//  Movieooze
//
//  Created by Artem Shcherban on 19.10.2021.
//

import Foundation

class ActorTvShowsCellCollectionViewModel {
    private var actorTvShow: TvShowWithActor!
    
    var nameOfTvShow: String {
        actorTvShow.name ?? ""
    }
    
    var posterPath: String {
        actorTvShow.poster_path ?? ""
    }
    
    init(actorTvShow: TvShowWithActor) {
        self.actorTvShow = actorTvShow
    }
}
