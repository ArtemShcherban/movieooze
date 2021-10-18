//
//  TVShowDetailedNetworkService.swift
//  Movieooze
//
//  Created by Artem Shcherban on 29.09.2021.
//

import Foundation

class TVShowDetailedNetworkService {
    static func alamofireTVShowDetailsRequest(tvShowID: Int, completion: @escaping(TVShowDetails) -> ()) {
        let request = "tv/\(tvShowID)?"
        
        NetworkService.shared.getTVShowDetails(request: request) { myJSONresponse in
            let decoder = JSONDecoder()
            if let dataOfTVShow = try? decoder.decode(TVShowDetails.self, from: myJSONresponse) {
                completion(dataOfTVShow)
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
