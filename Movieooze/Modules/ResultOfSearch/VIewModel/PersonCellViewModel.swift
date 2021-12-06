//
//  PersonCellViewModel.swift
//  Movieooze
//
//  Created by Artem Shcherban on 05.12.2021.
//

import Foundation

class PersonCellViewModel {
    private var person: PersonSearchResults
    
    var adult: Bool {
        person.adult ?? false
    }
    var gender: Int {
        person.gender ?? 0
    }
    var id: Int {
        person.id ?? 0
    }
    var knownFor: [KnownFor] {
        person.known_for ?? []
    }
    var knownForDepartment: String {
        person.known_for_department ?? ""
    }
    var name: String {
        person.name ?? ""
    }
    var popularity: Double {
        person.popularity ?? 0.0
    }
    var profilePath: String {
        person.profile_path ?? ""
    }
    
    init(person: PersonSearchResults) {
        self.person = person
    }
    
}
