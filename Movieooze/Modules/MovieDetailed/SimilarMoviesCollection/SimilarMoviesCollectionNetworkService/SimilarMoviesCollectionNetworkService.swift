//
//  SimilarMoviesCollectionNetworkService.swift
//  Movieooze
//
//  Created by Artem Shcherban on 13.09.2021.
//

import Foundation

class SimilarMoviesCollectionNetworkService {
   
    static  func alamofireSimilarMoviesRequest(movieID: Int, completion: @escaping(ResultSimilarMovies) -> ()) {
        
        let request = "movie/\(movieID)/similar?"
        
        NetworkService.shared.getSimilarMovies(request: request) { myJSONresponse in
            
            let decoder = JSONDecoder()
            if let similarMoviesData = try? decoder.decode(ResultSimilarMovies.self, from: myJSONresponse) {
                completion(similarMoviesData)
            }
        }
    }
}
