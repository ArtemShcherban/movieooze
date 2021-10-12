//
//  VideoPlayerViewModel.swift
//  Movieooze
//
//  Created by Artem Shcherban on 15.09.2021.
//

import Foundation

class VideoPlayerViewModel {
    
    var arrayOfTraillers: [String] = []
    
    func movieVideoMaterialsRequest(movieID: Int, completion: @escaping(() -> ())) {
        VideoPlayerNetworkService.afMovieVideoMaterialsRequest(movieID: movieID) {
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
    
    func tvShowVideoMaterialsRequest(tvShowID: Int, completion: @escaping(() -> ())) {
        VideoPlayerNetworkService.afTVShowVideoMaterialsRequest(tvShowID: tvShowID) {
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
