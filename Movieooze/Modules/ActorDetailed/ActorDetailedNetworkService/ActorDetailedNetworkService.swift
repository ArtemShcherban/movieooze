//
//  ActorDetailedNetworkService.swift
//  Movieooze
//
//  Created by Artem Shcherban on 16.09.2021.
//

import Foundation

class ActorDetailedNetworkService {
    
    
  static func alamofireActorDetailsRequest(actorID: Int, completion: @escaping(ActorDetails) -> ()) {
        
        let request = "person/\(actorID )?"
        
        NetworkService.shared.getDataFromTMBD(request: request) {  myJSONresponse in
            
            let decoder = JSONDecoder()
            if let dataOfActor = try? decoder.decode(ActorDetails.self, from: myJSONresponse) {
                completion(dataOfActor)
                
//                self.actor = dataOfActor
//                self.getActorPhoto()
//                self.fillActorDetails()
//                setTitleForBackButton()
            }
        }
    }
}
