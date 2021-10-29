//
//  ActorMoviesCellCollectionViewModel.swift
//  Movieooze
//
//  Created by Artem Shcherban on 16.09.2021.
//

import Foundation

class ActorMoviesCellCollectionViewModel {
   private var actorMovie: MovieWithActor!
    
    var title : String {
        actorMovie.title ?? ""
    }
    
    var posterPath : String {
        actorMovie.poster_path ?? ""
    }

    init(actorMovie: MovieWithActor) {
        self.actorMovie = actorMovie
    }
}
