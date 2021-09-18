//
//  MoviesTrendingNetworkService.swift
//  Movieooze
//
//  Created by Artem Shcherban on 09.09.2021.
//

import Foundation

class MoviesTrendingNetworkService {
    private init() {}
    
    static func alamofireMoviesListRequest(completion: @escaping(ResultMoviesTrendingDay) -> ()) {
        let request = "trending/movie/day?"
        NetworkService.shared.getDataFromTMBD(request: request) { myJSONresponse in
            let decoder = JSONDecoder()
            if let dataFromTMBD = try? decoder.decode(ResultMoviesTrendingDay.self, from: myJSONresponse) {
                completion(dataFromTMBD)
            }
        }
    }
    
  static  func alamofireGenresListRequest(completion: @escaping(ResultGenres) -> ()) {
    let request = "genre/movie/list?"
    NetworkService.shared.getDataFromTMBD(request: request) { myJSONresponse in
        let decoder = JSONDecoder()
        if let dataFromTMBD = try? decoder.decode(ResultGenres.self, from: myJSONresponse) {
            completion(dataFromTMBD)
            }
        }
    }
}
