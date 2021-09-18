//
//  ActorDetailedViewModel.swift
//  Movieooze
//
//  Created by Artem Shcherban on 16.09.2021.
//

import Foundation

class ActorDetailedViewModel {
    var actor: ActorDetails? = nil
    
    func actorDetailsRequest(actorID: Int, completion: @escaping(() -> ())) {
        
        ActorDetailedNetworkService.alamofireActorDetailsRequest(actorID: actorID) {
            dataOfActor in
            self.actor = dataOfActor.self
            completion()
        }
    }
    
    var adult : Bool {
        actor?.adult ?? false
    }
    var also_known_as : [String] {
        actor?.also_known_as ?? []
    }
    var biography : String {
        actor?.biography ?? ""
    }
    var birthday : String {
        getActorBirthday()
    }
    var deathday : String {
        getActorDeathday()
    }
    var gender : Int {
        actor?.gender ?? 0
    }
    var homepage : String {
        actor?.homepage ?? ""
    }
    var id : Int {
        actor?.id ?? 0
    }
    var imdb_id : String {
        actor?.imdb_id ?? ""
    }
    var known_for_department : String {
        actor?.known_for_department ?? ""
    }
    var name : String {
        actor?.name ?? ""
    }
    var place_of_birth : String {
        actor?.place_of_birth ?? ""
    }
    var popularity : Double {
        actor?.popularity ?? 0.0
    }
    var profile_path : String {
        actor?.profile_path ?? ""
    }
    
    func getActorBirthday() -> String {
        if actor?.birthday != nil {
            return  DateFormat.dateFormatDDMMYY(date: actor?.birthday ?? "")
        } else {
            return  ""
        }
    }
    
    func getActorDeathday() -> String {
        if actor?.deathday != nil {
            return  DateFormat.dateFormatDDMMYY(date: actor?.deathday ?? "")
        } else {
            return  ""
        }
    }
}
