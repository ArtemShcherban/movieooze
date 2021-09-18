//
//  ListOfGenres.swift
//  Movieooze
//
//  Created by Artem Shcherban on 12.09.2021.
//

import Foundation

struct ListOfGenres {
    static var arrayOFGenres: [Genres] = []
    
    static  func genresOfMovies(genreIds: [Int]) -> String {
        
        if genreIds.isEmpty == true {
            
        } else if genreIds.count >= 2 {
            if genreIds[0] == 0 && genreIds[1] == 0 {
                print("genreIds[0] = 0 ")
            }else if genreIds[1] == 0 {
                let genreFirst = arrayOFGenres.filter({$0.id == genreIds[0]}).first
                let genre = "\(genreFirst?.name ?? "")"
                return genre
            } else {
                let genrFirst = arrayOFGenres.filter({$0.id == genreIds[0]}).first
                let genrSecond = arrayOFGenres.filter({$0.id == genreIds[1]}).first
                let genres = "\(genrFirst?.name ?? ""), \(genrSecond?.name ?? "")"
                return genres
            }
        } else {
            let genreFirst = arrayOFGenres.filter({$0.id == genreIds[0]}).first
            let genre = "\(genreFirst?.name ?? "")"
            return genre
        }
        return ""
    }
    
    
    static  func movieGenres(genres: [Genres]) -> String {
        if genres.count >= 2 {
            let stringOfgenres = ("\(genres[0].name ?? "")" + ", " + "\(genres[1].name ?? "")")
            return stringOfgenres
        } else if genres.count == 1 {
            let stringOfgenre = "\(genres[0].name ?? "")"
            return stringOfgenre
        } else {
            return ""
        }
    }
}
