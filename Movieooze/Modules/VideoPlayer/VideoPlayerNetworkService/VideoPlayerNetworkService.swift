//
//  VideoPlayerNeyworkService.swift
//  Movieooze
//
//  Created by Artem Shcherban on 15.09.2021.
//

import Foundation

class VideoPlayerNetworkService {
    
    static func afMovieVideoMaterialsRequest(movieID: Int, completion: @escaping(ResultVideoMaterials) -> ()) {
        
        let request = "movie/\(movieID)/videos?"
        
        NetworkService.shared.getDataFromTMBD(request: request) {  myJSONresponse in
            
            let decoder = JSONDecoder()
            if let videoMaterials = try? decoder.decode(ResultVideoMaterials.self, from: myJSONresponse) {
                
                completion(videoMaterials)
            }
        }
    }
    
    static func afTVShowVideoMaterialsRequest(tvShowID: Int, completion: @escaping(ResultVideoMaterials) -> ()) {
        
        let request = "tv/\(tvShowID)/videos?"
        
        NetworkService.shared.getDataFromTMBD(request: request) {  myJSONresponse in
            
            let decoder = JSONDecoder()
            if let videoMaterials = try? decoder.decode(ResultVideoMaterials.self, from: myJSONresponse) {
                
                completion(videoMaterials)
            }
        }
    }
}
