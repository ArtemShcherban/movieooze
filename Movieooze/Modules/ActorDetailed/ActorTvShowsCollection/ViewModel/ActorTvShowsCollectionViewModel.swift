//
//  ActorTvShowsCollectionViewModel.swift
//  Movieooze
//
//  Created by Artem Shcherban on 19.10.2021.
//

import Foundation

class ActorTvShowsCollectionViewModel {
    var arrayOfActorTvShows: [TvShowWithActor] = []
    
    func actorTvShowsRequest(actorID: Int, completion: @escaping( () ->() )) {
        ActorTvShowsCollectionNetworkService.alamofireActorTvShowsRequest(actorID: actorID) { actorTvShowsData in
            
            self.sortingAndFilteringArray(arrayFromRequest:  actorTvShowsData.cast ?? [])
            
            completion()
        }
    }
    
    func sortingAndFilteringArray(arrayFromRequest: [TvShowWithActor]) {

        for eachTvShow in arrayFromRequest {

            let tvShowGenres = eachTvShow.genre_ids ?? []
            
            if arrayOfActorTvShows.contains(where: {$0.id == eachTvShow.id}) ||
                eachTvShow.character?.isEmpty == true ||
                    tvShowGenres.contains(where: Constants.ExcludedGenres.genresOfTvShow.contains) ||
                        tvShowGenres == [] {
                
            } else {
                    arrayOfActorTvShows.append(eachTvShow)
               // 🧐 удалить Print
                    print("\(eachTvShow.name ?? "пустое название") - \(eachTvShow.genre_ids ?? []) - \(eachTvShow.character ?? "пустая роль")")
                }
            }
        self.arrayOfActorTvShows.sort { Int($0.popularity ?? 0.0) > Int($1.popularity ?? 0.0) }
        }
    
    func numberOfRows() -> Int {
        return arrayOfActorTvShows.count
    }
    
    func createCellViewModel(indexPath: IndexPath) -> ActorTvShowsCellCollectionViewModel {
        let tvShow = arrayOfActorTvShows[indexPath.row]
        return ActorTvShowsCellCollectionViewModel(actorTvShow: tvShow)
    }
}
