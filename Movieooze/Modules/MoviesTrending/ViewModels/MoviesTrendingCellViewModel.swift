//
//  MoviesTrendingCellViewModel.swift
//  Movieooze
//
//  Created by Artem Shcherban on 11.09.2021.
//

import Foundation

class MoviesTrendingCellViewModel {
    
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
        return ListOfGenres.genresOfMovies(genreIds: genreIds)
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
    
//    func numberOfGenres() -> String{
//        if genreIds.count >= 2 {
//        let genres = ("\(dicGenres[genreIds[0]]?.name ?? "")" + ", " + "\(dicGenres[genreIds[1]]?.name ?? "")")
//            return genres
//        } else {
//         let genre = ("\(dicGenres[genreIds[0]]?.name ?? "")")
//            return genre
//        }
//    }
    
//    func genresOfMovies() -> String{
//        if genreIds.isEmpty == true {
//            
//        } else if genreIds.count >= 2 {
//            let genrFirst = arrayOFGenres.filter({$0.id == genreIds[0]}).first
//            let genrSecond = arrayOFGenres.filter({$0.id == genreIds[1]}).first
//            let genres = "\(genrFirst?.name ?? ""), \(genrSecond?.name ?? "")"
//            return genres
//            
//        } else {
//            let genreFirst = arrayOFGenres.filter({$0.id == genreIds[0]}).first
//            let genre = "\(genreFirst?.name ?? "")"
//            return genre
//        }
//        return ""
//    }

    init(movie: Movie) {
        self.movie = movie
    }
}
