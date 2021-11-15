//
//  RealmManagerSearch.swift
//  Movieooze
//
//  Created by Artem Shcherban on 03.11.2021.
//

import Foundation
import RealmSwift

struct RealmManagerSearch {
    static var shared = RealmManagerSearch()
    
    
    let realm = try? Realm()
    
    func createAndSaveUserRequest(request: String){
        let userRequest = UserRequestRealm()
        userRequest.userRequestText = request
        
        try? realm?.write {
            realm?.add(userRequest)
        }
    }
    
    func readUsersRequestesFromRealm(completion: @escaping ([UserRequestRealm]) -> ()) {
        guard let usersRequestesFromRealm = realm?.objects(UserRequestRealm.self) else { return completion([]) }
        var requestes = [UserRequestRealm]()
        for eachRequest in usersRequestesFromRealm {
            requestes.append(eachRequest)
        }
              completion(requestes)
    }
    
    func deleteFistObjectInRealm() {
        guard let userRequestes = realm?.objects(UserRequestRealm.self) else { return }
        if let firstUserRequestinArray = userRequestes.first {
            try? realm?.write {
                realm?.delete(firstUserRequestinArray)
            }
        }
    }
    
    func deleteAllRequestsFromRealm() {
        guard let userRequestes = realm?.objects(UserRequestRealm.self) else { return }
            try? realm?.write {
                realm?.delete(userRequestes)
        }
    }
    
    
}
