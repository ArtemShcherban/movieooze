//
//  TVShowTrendingCellViewModel.swift
//  Movieooze
//
//  Created by Artem Shcherban on 21.09.2021.
//

import Foundation

class TVShowTrendingCellViewModel {
    
   private var tvShow: TVShow
    
    var name : String {
        return tvShow.name ?? ""
    }
    var original_name : String {
        return tvShow.original_name ?? ""
    }
    var origin_country : [String] {
        return tvShow.origin_country ?? []
    }
    var vote_count : Int {
        return tvShow.vote_count ?? 0
    }
    var backdrop_path : String {
        return tvShow.backdrop_path ?? ""
    }
    var vote_average : Double {
        return tvShow.vote_average ?? 0.0
    }
    var genre_ids : [Int] {
        return tvShow.genre_ids ?? []
    }
    var tvShowGenre : String {
        ListOfGenres.genresOfMoviesAndTVShows(genreIds: genre_ids)
    }
    var id : Int {
        return tvShow.id ?? 0
    }
    var original_language : String {
        return tvShow.original_language ?? ""
    }
    var overview : String {
        return tvShow.overview ?? ""
    }
    var poster_path : String {
        return tvShow.poster_path ?? ""
    }
    var first_air_date : String {
        DateFormat.dateFormatYear(date: tvShow.first_air_date ?? "")
    }
    var popularity : Double {
        return tvShow.popularity ?? 0.0
    }
    var media_type : String {
        return tvShow.media_type ?? ""
    }
    
    init(tvShow: TVShow) {
        self.tvShow = tvShow
    }
}
