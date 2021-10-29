//
//  SimilarTvShowsCollectionNetworkService.swift
//  Movieooze
//
//  Created by Artem Shcherban on 18.10.2021.
//

import Foundation

class SimilarTvShowsCollectionNetworkService {
    static  func alamofireSimilarTvShowsRequest(tvShowID: Int, completion: @escaping(ResultSimilarTvShow) -> ()) {
        
        let request = "tv/\(tvShowID)/similar?"
        
        NetworkService.shared.getSimilarMoviesOrTvShows(request: request) { myJSONresponse in
            
            let decoder = JSONDecoder()
            if let similarTvShowsData = try? decoder.decode(ResultSimilarTvShow.self, from: myJSONresponse) {
                completion(similarTvShowsData)
            }
        }
    }
}
