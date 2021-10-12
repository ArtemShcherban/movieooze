//
//  TVShowsTrendingNetworkService.swift
//  Movieooze
//
//  Created by Artem Shcherban on 20.09.2021.
//

import Foundation

class TVShowsTrendingNetworkService {
    
    static func alamofireTVShowsListRequest(completion: @escaping(ResultTVShowsTrendingDay) -> ()) {
        let request = "trending/tv/day?"
        NetworkService.shared.getDataFromTMBD(request: request) { myJSONresponse in
            let decoder = JSONDecoder()
            if let dataFromTMBD = try? decoder.decode(ResultTVShowsTrendingDay.self, from: myJSONresponse) {
                completion(dataFromTMBD)
            }
        }
    }
    
    static  func alamofireGenresListRequest(completion: @escaping(ResultGenres) -> ()) {
      let request = "genre/tv/list?"
      NetworkService.shared.getDataFromTMBD(request: request) { myJSONresponse in
          let decoder = JSONDecoder()
          if let dataFromTMBD = try? decoder.decode(ResultGenres.self, from: myJSONresponse) {
              completion(dataFromTMBD)
              }
          }
      }
}
