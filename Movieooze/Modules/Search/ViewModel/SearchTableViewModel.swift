//
//  SearchViewModel.swift
//  Movieooze
//
//  Created by Artem Shcherban on 03.11.2021.
//

import Foundation

class SearchTableViewModel {
    
    var arrayOfUsersRequests: [UserRequestRealm] = []
    
    func getUsersRequestsFromRealm(completion: @escaping(() -> ())) {
        RealmManagerSearch.shared.readUsersRequestesFromRealm(completion: { requestes in
            let unSortedRequests = requestes
            self.arrayOfUsersRequests = unSortedRequests.reversed()
        })
        completion()
    }
    
    func checkAndSaveUserRequest(request: String) {
        if   RealmManagerSearch.shared.deleteSameRequest(request: request) == true {
        self.getUsersRequestsFromRealm(completion: {
        })
    }
        if arrayOfUsersRequests.count >= 10 {
            RealmManagerSearch.shared.deleteFistObjectInRealm()
            RealmManagerSearch.shared.createAndSaveUserRequest(request: request)
        } else {
            RealmManagerSearch.shared.createAndSaveUserRequest(request: request)
        }
        
    }
    
    func numberOfRows() -> Int {
        return arrayOfUsersRequests.count
    }
    
    func createCellViewModel(indexPath: IndexPath) -> SearchTableViewCellModel{
        let request = arrayOfUsersRequests[indexPath.row]
        return SearchTableViewCellModel(request: request)
    }
    
}
