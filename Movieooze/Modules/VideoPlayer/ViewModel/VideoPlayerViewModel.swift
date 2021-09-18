//
//  VideoPlayerViewModel.swift
//  Movieooze
//
//  Created by Artem Shcherban on 15.09.2021.
//

import Foundation

class VideoPlayerViewModel {
    
    var arrayOfTraillers: [String] = []
    
    func videoMaterialsRequest(movieID: Int, completion: @escaping(() -> ())) {
        VideoPlayerNetworkService.alamofireVideoMaterialsRequest(movieID: movieID) {
            videoMaterials in
            let arrayOfVideos = videoMaterials.results
            for item in arrayOfVideos ?? [] {
                if item.type == "Trailer" {
                    self.arrayOfTraillers.append(item.key ?? "")
                    completion()
                }
            }
        }
    }
}
