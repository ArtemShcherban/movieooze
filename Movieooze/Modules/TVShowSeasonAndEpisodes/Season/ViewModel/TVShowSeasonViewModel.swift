//
//  TVShowSeasonViewModel.swift
//  Movieooze
//
//  Created by Artem Shcherban on 02.10.2021.
//

import Foundation

class TVShowSeasonViewModel {
   
    var tvShowSeason: TVShowSeason! = nil
    
    
    func getTVShowSeasonDetails(tvShowID: Int, seasonNumber: Int, completion: @escaping(() -> ())) {
        TVShowSeasonNetworkService.alamofireTVShowSeasonDetailsRequest(tvShowID: tvShowID, seasonNumber: seasonNumber) { dataOfTVShowSeason in
            
            self.tvShowSeason = dataOfTVShowSeason.self
            
            
           completion()
        }
    }
    
    var seasonLongId : String {
        tvShowSeason.longID ?? ""
    }
    var seasonAirDate : String {
        tvShowSeason.air_date ?? ""
    }
    var seasonEpisodes : [Episodes] {
        tvShowSeason.episodes ?? []
    }
    var seasonName : String {
        tvShowSeason.name ?? ""
    }
    var seasonOverview : String {
        tvShowSeason.overview ?? ""
    }
    var seasonId : Int {
        tvShowSeason.id ?? 0
    }
    var seasonPoster_path : String {
        tvShowSeason.poster_path ?? ""
    }
    var seasonNumber : Int {
        tvShowSeason.season_number ?? 0
    }
    var seasonCredits : Credits? {
        tvShowSeason.credits
    }
    

    
}
