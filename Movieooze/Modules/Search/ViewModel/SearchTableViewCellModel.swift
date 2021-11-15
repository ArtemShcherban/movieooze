//
//  SearchTableViewCellModel.swift
//  Movieooze
//
//  Created by Artem Shcherban on 06.11.2021.
//

import Foundation

class SearchTableViewCellModel {
    private var request: UserRequestRealm
    
    var textOfRequest: String {
        return request.userRequestText
    }
    
    init(request: UserRequestRealm) {
        self.request = request
    }
}
