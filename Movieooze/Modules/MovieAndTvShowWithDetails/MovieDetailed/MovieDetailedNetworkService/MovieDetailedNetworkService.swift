//
//  MovieDetailedNetworkService.swift
//  Movieooze
//
//  Created by Artem Shcherban on 12.09.2021.
//

import Foundation

class MovieDetailedNetworkService {
    
    static func alamofireMovieDetailsRequest(movieID: Int, completion: @escaping(MovieDetailsEN) -> ()) {
        let request = "movie/\(movieID)?"
        
        NetworkService.shared.getMovieDetails(request: request) { myJSONresponse in
            let decoder = JSONDecoder()
            if let dataOfMovie = try? decoder.decode(MovieDetailsEN.self, from: myJSONresponse) {
                completion(dataOfMovie)
            }
        }
    }
    
    static  func alamofirePoductionCompanyLogo(productionCompanyID: Int, completion: @escaping(ResultProductionCompanyLogo) -> ()) {
        
        let request = "company/\(productionCompanyID)/images?"
        
        NetworkService.shared.getDataFromTMBD(request: request) { myJSONresponse in
            
            let decoder = JSONDecoder()
            if let movieImagesData = try? decoder.decode(ResultProductionCompanyLogo.self, from: myJSONresponse) {
                completion(movieImagesData)
            }
        }
    }
}

