//
//  PersonSearchResult.swift
//  Movieooze
//
//  Created by Artem Shcherban on 05.12.2021.
//

import Foundation

class PersonSearchResultTableViewModel {
    
    var arrayOfPersonSearchResult: [PersonSearchResults] = []
    
    func getPersonSearchResult(searchNetworkViewModel: SearchNetworkViewModel) {
        arrayOfPersonSearchResult = searchNetworkViewModel.arrayOfPersons
    }
    
    func numberOfRows() -> Int {
        return arrayOfPersonSearchResult.count
    }
    
    func createCellViewModel(indexPath: IndexPath) -> PersonCellViewModel {
        let person = self.arrayOfPersonSearchResult[indexPath.row]
        return PersonCellViewModel(person: person)
    }
}
