//
//  TVShowSeasonNetworkServise.swift
//  Movieooze
//
//  Created by Artem Shcherban on 02.10.2021.
//

import Foundation

class TVShowSeasonNetworkService {
    
    static func alamofireTVShowSeasonDetailsRequest(tvShowID: Int, seasonNumber: Int, completion: @escaping(TVShowSeason) -> ()) {
        let request = "tv/\(tvShowID)/season/\(seasonNumber)?"
        
        NetworkService.shared.getTVShowDetails(request: request) { myJSONresponse in
            let decoder = JSONDecoder()
            if let dataOfTVShowSeason = try? decoder.decode(TVShowSeason.self, from: myJSONresponse) {
                completion(dataOfTVShowSeason)
            }
        }
    }    
}
