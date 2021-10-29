//
//  ActorMoviesCollectionViewModel.swift
//  Movieooze
//
//  Created by Artem Shcherban on 16.09.2021.
//

import Foundation

class ActorMoviesCollectionViewModel {
    var arrayOfActorMovies: [MovieWithActor] = []
    
    func actorMoviesRequest(actorID: Int, completion: @escaping( () ->() )) {
        ActorMoviesCollectionNetworkService.alamofireActorMoviesRequest(actorID: actorID) { actorMoviesData in
            let unsortedArray = actorMoviesData.cast ?? []
            self.arrayOfActorMovies = unsortedArray.sorted { Int($0.popularity ?? 0.0) > Int($1.popularity ?? 0.0) }
            completion()
        }
    }
    
    func numberOfRows() -> Int {
        return arrayOfActorMovies.count
    }
    
    func createCellViewModel(indexPath: IndexPath) -> ActorMoviesCellCollectionViewModel {
        let movie = arrayOfActorMovies[indexPath.row]
        return ActorMoviesCellCollectionViewModel(actorMovie: movie)
    }
}
