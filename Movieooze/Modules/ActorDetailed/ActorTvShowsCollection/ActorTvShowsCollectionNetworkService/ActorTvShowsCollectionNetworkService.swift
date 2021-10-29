//
//  ActorTvShowsCollectionNetworkService.swift
//  Movieooze
//
//  Created by Artem Shcherban on 19.10.2021.
//

import Foundation

class ActorTvShowsCollectionNetworkService {
    static func alamofireActorTvShowsRequest(actorID: Int, completion: @escaping(ResultAcorTvShows) -> ()) {
        let request = "person/\(actorID)/tv_credits?"
        NetworkService.shared.getDataFromTMBD(request: request) { myJSONresponse in
            
            let decoder = JSONDecoder()
            if let actorTvShowData = try? decoder.decode(ResultAcorTvShows.self, from: myJSONresponse) {
                completion(actorTvShowData)
            }
        }
    }
}
