//
//  SimilarMoviesCellCollectionViewModel.swift
//  Movieooze
//
//  Created by Artem Shcherban on 13.09.2021.
//

import Foundation

class SimilarMoviesCellCollectionViewModel {
 private var movie: SimilarMovie!
    
    var title: String {
        movie.title ?? ""
    }
    
    var posterPath : String {
        movie.poster_path ?? ""
    }
    
    init(movie: SimilarMovie) {
        self.movie = movie
    }
}
