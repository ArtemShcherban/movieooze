//
//  ActorsCollectionViewModel.swift
//  Movieooze
//
//  Created by Artem Shcherban on 14.09.2021.
//

import Foundation

class ActorsCollectionViewModel {

    var arrayOfActors: [Cast] = []
    
    func getArrayOfMovieActors(movieDetailedViewModel: MovieDetailedViewModel) {
        self.arrayOfActors = movieDetailedViewModel.movieWithDetails.credits?.cast ?? []
    }
    
    func getArrayOfTVShowActors(tvShowViewModel: TVShowViewModel) {
        self.arrayOfActors = tvShowViewModel.tvShowWithDetails.credits?.cast ?? [] 
    }
    
    func numberOfRows() -> Int {
        return arrayOfActors.count
    }
    
    func createCellViewModel(indexPath: IndexPath) -> ActorsCellCollectionViewModel{
        let actor = arrayOfActors[indexPath.row]
        return ActorsCellCollectionViewModel(actor: actor)
    }
}
