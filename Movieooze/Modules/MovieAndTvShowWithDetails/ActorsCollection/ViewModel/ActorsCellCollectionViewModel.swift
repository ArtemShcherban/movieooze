//
//  ActorsCellCollectionViewModel.swift
//  Movieooze
//
//  Created by Artem Shcherban on 15.09.2021.
//

import Foundation

class ActorsCellCollectionViewModel {
    
    var actor: Cast!
    
    var adult : Bool {
        actor.adult ?? false
    }
    var gender : Int {
        actor.gender ?? 0
    }
    var id : Int {
        actor.id ?? 0
    }
    var known_for_department : String {
        actor.known_for_department ?? ""
    }
    var name: String {
        actor.name ?? ""
    }
    var original_name : String {
        actor.original_name ?? ""
    }
    var popularity : Double {
        actor.popularity ?? 0.0
    }
    var profile_path : String {
        actor.profile_path ?? ""
    }
    var cast_id : Int {
        actor.cast_id ?? 0
    }
    var character : String {
        actor.character ?? ""
    }
    var credit_id : String {
        actor.credit_id ?? ""
    }
    var order : Int {
        actor.order ?? 0
    }
    
    init(actor: Cast ) {
        self.actor = actor
    }
}
