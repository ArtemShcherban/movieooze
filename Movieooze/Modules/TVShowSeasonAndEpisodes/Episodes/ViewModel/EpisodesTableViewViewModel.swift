//
//  EpisodesTableViewViewModel.swift
//  Movieooze
//
//  Created by Artem Shcherban on 02.10.2021.
//

import Foundation

class EpisodesTableViewViewModel {
    
    var arrayOfEpisodes: [Episodes] = []
    
    func getArrayOfEpisodes(tvShowSeasonViewModel: TVShowSeasonViewModel) {
        arrayOfEpisodes = tvShowSeasonViewModel.seasonEpisodes
    }
    
    func numberOfRows() -> Int{
       return arrayOfEpisodes.count
    }
    
    func createCellViewModel(indexPath: IndexPath) -> EpisodeCellViewModel{
        let episode = arrayOfEpisodes[indexPath.row]
        return EpisodeCellViewModel(episode: episode)
    }
}
