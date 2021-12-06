//
//  SearchNetworkService.swift
//  Movieooze
//
//  Created by Artem Shcherban on 17.11.2021.
//

import Foundation

class SearchNetworkService {
    static func alamofireMultiSearchRequest(search: String, completion: @escaping(MultiSearch) -> ()) {
        
        let request = search.replacingOccurrences(of: " ", with: "%20")
        
        NetworkService.shared.multiSearchFromTMBD (request: request) { myJSONresponse in
            let decoder = JSONDecoder()
            if let dataOfMovie = try? decoder.decode(MultiSearch.self, from: myJSONresponse) {
                
                completion(dataOfMovie)
                
            }
        }
    }
    
    static func alamofireMovieSearchRequest(search: String, completion:  @escaping(MovieSearch) -> ()) {
        let whereToSearch = Constants.Network.searchMovie
        let request = search.replacingOccurrences(of: " ", with: "%20")
        
        NetworkService.shared.separateSearchFromTMBD (whereToSearch: whereToSearch, request: request) { myJSONresponse in
            let decoder = JSONDecoder()
            if let dataOfMovieSearch = try? decoder.decode(MovieSearch.self, from: myJSONresponse) {
                
                completion(dataOfMovieSearch)
                
            }
        }
    }
    
    static func alamofirePersonSearchRequest(search: String, completion:  @escaping(PersonSearch) -> ()) {
        
        let whereToSearch = Constants.Network.searchPerson
        let request = search.replacingOccurrences(of: " ", with: "%20")
        
        NetworkService.shared.separateSearchFromTMBD (whereToSearch: whereToSearch, request: request) { myJSONresponse in
            let decoder = JSONDecoder()
            if let dataOfPersonSearch = try? decoder.decode(PersonSearch.self, from: myJSONresponse) {
                
                completion(dataOfPersonSearch)
                
            }
        }
    }
    
    static func alamofireTvShowSearchRequest(search: String, completion:  @escaping(TvShowSearch) -> ()) {
        
        let whereToSearch = Constants.Network.searchTv
        let request = search.replacingOccurrences(of: " ", with: "%20")
        
        NetworkService.shared.separateSearchFromTMBD (whereToSearch: whereToSearch, request: request) { myJSONresponse in
            let decoder = JSONDecoder()
            if let dataOfTvShowSearch = try? decoder.decode(TvShowSearch.self, from: myJSONresponse) {
                
                completion(dataOfTvShowSearch)
                
            }
        }
    }
}
