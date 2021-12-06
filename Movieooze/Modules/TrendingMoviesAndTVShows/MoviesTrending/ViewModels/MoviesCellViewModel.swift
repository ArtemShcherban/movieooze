//
//  MoviesCellViewModel.swift
//  Movieooze
//
//  Created by Artem Shcherban on 03.12.2021.
//

import Foundation

class MoviesCellViewModel {
    
 private var movie: Movie

    var title: String {
        return movie.title ?? ""
    }
    var overview: String {
        return movie.overview ?? ""
    }
    var adult: Bool {
        return movie.adult ?? false
    }
    var video: Bool {
        return movie.video ?? false
    }
    var backdropPath: String {
        return movie.backdropPath ?? ""
    }
    var genreIds: [Int] {
        return movie.genreIds ?? []
    }
    var movieGenres: String {
        return ListOfGenres.genresOfMoviesAndTVShows(genreIds: genreIds)
    }

    var mediaType: String {
        return movie.mediaType ?? ""
    }
    var originalLanguage: String {
        return movie.originalLanguage ?? ""
    }
    var originalTitle: String {
        return movie.originalTitle ?? ""
    }
    var posterPath: String {
        return movie.posterPath ?? ""
    }
    var releaseDate: String {
        return DateFormat.dateFormatYear(date: movie.releaseDate  ?? "")
    }
    var id: Int {
        return movie.id ?? 0
    }
    var popularity: Double {
        return movie.popularity ?? 0.0
    }
    var voteAverage: Double{
        return movie.voteAverage ?? 0.0
    }
    var voteCount: Int{
        return movie.voteCount ?? 0
    }

    init(movie: Movie) {
        self.movie = movie
    }
}
