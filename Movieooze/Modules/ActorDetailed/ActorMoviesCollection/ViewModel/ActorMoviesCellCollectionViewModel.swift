//
//  ActorMoviesCellCollectionViewModel.swift
//  Movieooze
//
//  Created by Artem Shcherban on 16.09.2021.
//

import Foundation

class ActorMoviesCellCollectionViewModel {
   private var movie: MovieWithActor!
    
    var title : String {
        movie.title ?? ""
    }
    
    var posterPath : String {
        movie.poster_path ?? ""
    }

    init(movie: MovieWithActor) {
        self.movie = movie
    }
}
