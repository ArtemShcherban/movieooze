//
//  SeasonsCollectionViewModel.swift
//  Movieooze
//
//  Created by Artem Shcherban on 30.09.2021.
//

import Foundation

class SeasonsCollectionViewModel {
    
    var arrayOFSeasons: [Seasons] = []
    
    func getArrayOFSeasons(tvShowViewModel:  TVShowViewModel) {
        self.arrayOFSeasons = tvShowViewModel.seasons
    }
    
    func numberOfRows() -> Int {
        return arrayOFSeasons.count
        
    }
    
    func createCellViewModel(indexPath: IndexPath) -> SeasonsCellCollectionViewModel{
        let season = arrayOFSeasons[indexPath.row]
        return SeasonsCellCollectionViewModel(season: season)
    }
}
