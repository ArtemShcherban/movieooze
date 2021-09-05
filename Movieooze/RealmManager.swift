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
    
    func createAndSaveMovieForFavorites (movie: MovieDetailsEN?) {
        
        let movieForFavorites = MovieForFavoritesRealm()
        movieForFavorites.adult = movie?.adult ?? false
        movieForFavorites.backdropPath = movie?.backdropPath ?? ""
        movieForFavorites.budget = movie?.budget ?? 0
        movieForFavorites.homepage = movie?.homepage ?? ""
        movieForFavorites.id = movie?.id ?? 0
        movieForFavorites.imdbId = movie?.imdbId ?? ""
        movieForFavorites.originalLanguage = movie?.originalLanguage ?? ""
        movieForFavorites.originalTitle = movie?.originalTitle ?? ""
        movieForFavorites.overview = movie?.overview ?? ""
        movieForFavorites.popularity = movie?.popularity ?? 0.0
        movieForFavorites.posterPath = movie?.posterPath ?? ""
        movieForFavorites.releaseDate = movie?.releaseDate ?? ""
        movieForFavorites.revenue = movie?.revenue ?? 0
        movieForFavorites.runtime = movie?.runtime ?? 0
        movieForFavorites.status = movie?.status ?? ""
        movieForFavorites.tagline = movie?.tagline ?? ""
        movieForFavorites.title = movie?.title ?? ""
        movieForFavorites.video = movie?.video ?? false
        movieForFavorites.voteAverage = movie?.voteAverage ?? 0.0
        movieForFavorites.voteCount = movie?.voteCount ?? 0
        if movie?.genres?.count ?? 0 > 0 && movie?.genres?.count ?? 0 >= 2 {
            movieForFavorites.genreIDFirst = movie?.genres?[0].id ?? 0
            movieForFavorites.genreIDSecond = movie?.genres?[1].id ?? 0
        } else if movie?.genres?.count ?? 0 == 1 {
            movieForFavorites.genreIDFirst = movie?.genres?[0].id ?? 0
            movieForFavorites.genreIDSecond = 0
        } else {
            movieForFavorites.genreIDFirst = 0
            movieForFavorites.genreIDSecond = 0
        }
        
       
        
        try? realm?.write {
            realm?.add(movieForFavorites)
        }
    }
    
    // MARK: - Чтение
    
    func newReadFromRealmMovieForFavorites(completion: ([Movie]) ->()) {
        var   arrayOfMoviesFromRealm: [MovieForFavoritesRealm] = []
        guard let movieForFavoritesFromRealm = realm?.objects(MovieForFavoritesRealm.self) else { return }
        for eachMovie in movieForFavoritesFromRealm {
            arrayOfMoviesFromRealm.append(eachMovie)
        }
        completion(convertMovieForFavoritesToMovie(moviesFromRealm: arrayOfMoviesFromRealm))
    }
    
    func convertMovieForFavoritesToMovie(moviesFromRealm: [MovieForFavoritesRealm]) ->[Movie] {
        var movies = [Movie]()
        for eachMovie in moviesFromRealm {
            let movie = Movie(from: eachMovie)
            movies.append(movie)
        }
        //🧐 удалить
        print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
        print(movies)
        print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
        return movies
    }
    
    func readFromRealmMovieForFavorites() -> [MovieForFavoritesRealm]  {
        var   arrayOfMoviesFromRealm: [MovieForFavoritesRealm] = []
        guard let movieForFavoritesFromRealm = realm?.objects(MovieForFavoritesRealm.self) else { return [] }
        for eachMovie in movieForFavoritesFromRealm {
            arrayOfMoviesFromRealm.append(eachMovie)
        }
        return arrayOfMoviesFromRealm
    }
    
    // MARK: - Удаление объекта из Realm
    
    func deleteMoviesForFavoritesFromRealmByID(movieID: Int) {
        if let movieForFavoritesInRealm = realm?.objects(MovieForFavoritesRealm.self).filter("id = \(movieID)") {
            try? realm?.write {
                realm?.delete(movieForFavoritesInRealm)
            }
        }
    }
    
    func deleteAllDataFromRealmMoviesForFavorites() {
        if let moviesForFavoritesInRealm = realm?.objects(MovieForFavoritesRealm.self) {
            try? realm?.write {
                realm?.delete(moviesForFavoritesInRealm)
            }
        }
    }
    
    // MARK: - Поиск объекта по ID в Realm
    
    func searchMovieForFavoritesIDInRealm(movieID: Int) -> Bool {
        let resultSearchInRealm = realm?.objects(MovieForFavoritesRealm.self).filter("id = \(movieID)")
        if resultSearchInRealm == nil {
            return false
        } else if resultSearchInRealm?.count == 0 {
            return false
        } else {
            return true
        }
    }
}


