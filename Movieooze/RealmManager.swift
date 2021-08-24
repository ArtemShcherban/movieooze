//
//  RealManager.swift
//  Lesson9_HW
//
//  Created by Artem Shcherban on 12.08.2021.
//

import Foundation
import RealmSwift

struct RealmManager {
    static var shared = RealmManager()
    

    let realm = try? Realm()

    
    // MARK: - Создание и запись экземпляра реалм
    
    func createAndSaveMovieForFavorites (movie: Movie?) {
        
        let movieForFavorites = FavoriteMovieRealm()
        movieForFavorites.title = movie?.title ?? ""
        movieForFavorites.adult = movie?.adult ?? false
        movieForFavorites.overview = movie?.overview  ?? ""
        movieForFavorites.posterPath = movie?.posterPath ?? ""
        movieForFavorites.voteAverage = movie?.voteAverage ?? 0.0
        movieForFavorites.id = movie?.id ?? 0
        movieForFavorites.backdropPath = movie?.backdropPath ?? ""
        movieForFavorites.genreIdFirst = movie?.genreIds?[0] ?? 0
        movieForFavorites.genreIdSecond = movie?.genreIds?[1] ?? 0
        movieForFavorites.mediaType = movie?.mediaType ?? ""
        movieForFavorites.originalLanguage = movie?.originalLanguage ?? ""
        movieForFavorites.originalTitle = movie?.originalTitle ?? ""
        movieForFavorites.popularity = movie?.popularity ?? 0.0
        movieForFavorites.releaseDate = movie?.releaseDate ?? ""
        movieForFavorites.voteCount = movie?.voteCount ?? 0
        movieForFavorites.video = movie?.video ?? false
        
        try? realm?.write {
            realm?.add(movieForFavorites)
        }
    }

    // MARK: - Чтение
    
            func newReadFromRealmMovieForFavorites(completion: ([Movie]) ->()) {
                var   arrayOfMoviesFromRealm: [FavoriteMovieRealm] = []
                guard let movieForFavoritesFromRealm = realm?.objects(FavoriteMovieRealm.self) else { return }
                for eachMovie in movieForFavoritesFromRealm {
                    arrayOfMoviesFromRealm.append(eachMovie)
                }
                 completion(convertMovieForFavoritesToMovie(moviesFromRealm: arrayOfMoviesFromRealm))
            }
    
                func convertMovieForFavoritesToMovie(moviesFromRealm: [FavoriteMovieRealm]) ->[Movie] {
                    var movies = [Movie]()
                    for eachMovie in moviesFromRealm {
                        let movie = Movie(from: eachMovie)
                        movies.append(movie)
                    }
                    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
                    print(movies)
                    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
                return movies
            }
            
    func readFromRealmMovieForFavorites() -> [FavoriteMovieRealm]  {
        var   arrayOfMoviesFromRealm: [FavoriteMovieRealm] = []
        guard let movieForFavoritesFromRealm = realm?.objects(FavoriteMovieRealm.self) else { return [] }
        for eachMovie in movieForFavoritesFromRealm {
            arrayOfMoviesFromRealm.append(eachMovie)
        }
         return arrayOfMoviesFromRealm
    }

//    func readFromRealmMovieForFavorites() -> [FavoriteMovieRealm] {
//       arrayOfMoviesForFavorites = []
//        guard let movieForFavoritesFromRealm = realm?.objects(FavoriteMovieRealm.self) else { return [] }
//        for eachMovie in movieForFavoritesFromRealm {
//            arrayOfMoviesForFavorites.append(eachMovie)
//        }
//         return arrayOfMoviesForFavorites
//    }

    // MARK: - Удаление объекта из Realm
    
    func deleteMoviesForFavoritesFromRealmByID(movieID: Int) {
        if let movieForFavoritesInRealm = realm?.objects(FavoriteMovieRealm.self).filter("id = \(movieID)") {
            try? realm?.write {
                realm?.delete(movieForFavoritesInRealm)
            }
        }
    }
    
    func deleteAllDataFromRealmMoviesForFavorites() {
        if let moviesForFavoritesInRealm = realm?.objects(FavoriteMovieRealm.self) {
            try? realm?.write {
                realm?.delete(moviesForFavoritesInRealm)
            }
        }
    }
    
    // MARK: - Поиск объекта по ID в Realm

    func searchMovieForFavoritesIDInRealm(movieID: Int) -> Bool {
        let resultSearchInRealm = realm?.objects(FavoriteMovieRealm.self).filter("id = \(movieID)")
        if resultSearchInRealm == nil {
            return false
        } else if resultSearchInRealm?.count == 0 {
            return false
        } else {
            return true
        }
    }
}


