//
//  ActorMoviesCollectionNetworkService.swift
//  Movieooze
//
//  Created by Artem Shcherban on 16.09.2021.
//

import Foundation

class ActorMoviesCollectionNetworkService {
    
  static func alamofireActorMoviesRequest(actorID: Int, completion: @escaping(ResultActor) -> ()) {
        
        let request = "person/\(actorID)/movie_credits?"
        NetworkService.shared.getDataFromTMBD(request: request) { myJSONresponse in
            
            let decoder = JSONDecoder()
            if let actorMoviesData = try? decoder.decode(ResultActor.self, from: myJSONresponse) {
                completion(actorMoviesData)
            }
        }
    }
}

