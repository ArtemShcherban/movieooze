//
//  EpisodeCellViewModelTableViewCell.swift
//  Movieooze
//
//  Created by Artem Shcherban on 02.10.2021.
//

import UIKit

class EpisodeCellViewModel {
   
    var episode: Episodes!
    
    var episodeAir_date : String {
        DateFormat.dateFormatDDMMYY(date: episode.air_date ?? "")
    }
    var episode_number : Int {
        episode.episode_number ?? 0
    }
//    var episodeCrew : [String] {
//        episode.crew ?? []
//    }
//    var episodeGuest_stars : [Guest_stars] {
//        episode.guest_stars ?? []
//    }
    var episodeId : Int {
        episode.id ?? 0
    }
    var episodeName : String {
        episode.name ?? ""
    }
    var episodeOverview : String {
        episode.overview ?? ""
    }
    var episodeProduction_code : String {
        episode.production_code ?? ""
    }
    var episodeSeason_number : Int {
        episode.season_number ?? 0
    }
    var episodeStill_path : String {
        episode.still_path ?? ""
    }
    var episodeVote_average : Double {
        episode.vote_average ?? 0.0
    }
    var episodeVote_count : Int {
        episode.vote_count ?? 0
    }
    init(episode: Episodes) {
        self.episode = episode
    }
    
}
