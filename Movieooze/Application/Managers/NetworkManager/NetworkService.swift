//
//  NetworkService.swift
//  Movieooze
//
//  Created by Artem Shcherban on 09.09.2021.
//

import Foundation
import Alamofire

class NetworkService {
    
    private init() {}
    static let shared = NetworkService()
    
    public func getDataFromTMBD (request: String, completion: @escaping (Data) -> ()) {
        AF.request("\(Constants.Network.tmbdDefaultPath)\(request)\(Constants.Network.apiKey)").responseJSON { myJSONresponse in
            completion(myJSONresponse.data!)
        }
    }
    
    public func getMovieDetails(request: String, completion: @escaping (Data) -> ()) {
        AF.request("\(Constants.Network.tmbdDefaultPath)\(request)\(Constants.Network.apiKey)\(Constants.Network.languageOfRequest)\(Constants.Network.movieAppendToResponse)").responseJSON { myJSONresponse in
            completion(myJSONresponse.data!)
        }
    }
    
    public func getSimilarMoviesOrTvShows(request: String, completion: @escaping (Data) -> ()) {
        AF.request("\(Constants.Network.tmbdDefaultPath)\(request)\(Constants.Network.apiKey)\(Constants.Network.languageOfRequest)").responseJSON { myJSONresponse in
            completion(myJSONresponse.data!)
        }
    }
    
    public func getTVShowDetails(request: String, completion: @escaping (Data) -> ()) {
        AF.request("\(Constants.Network.tmbdDefaultPath)\(request)\(Constants.Network.apiKey)\(Constants.Network.tvShowAppendToResponse)").responseJSON { myJSONresponse in
            completion(myJSONresponse.data!)
        }
    }
    
    public func multiSearchFromTMBD(request: String, completion: @escaping (Data) -> ()) {
        AF.request("\(Constants.Network.tmbdDefaultPath)\(Constants.Network.searchMulti)\(Constants.Network.apiKey)\(Constants.Network.languageOfRequest)\(Constants.Network.query)\(request)").responseJSON {
            myJSONresponse in
// 🧐 убрать print
            print("\(Constants.Network.tmbdDefaultPath)\(Constants.Network.searchMulti)\(Constants.Network.apiKey)\(Constants.Network.languageOfRequest)\(Constants.Network.query)\(request)")
            completion(myJSONresponse.data!)
        }
    }
    
    
    
    
    
    
    public func separateSearchFromTMBD(whereToSearch: String, request: String, completion: @escaping (Data) -> ()) {
        AF.request("\(Constants.Network.tmbdDefaultPath)\(whereToSearch)\(Constants.Network.apiKey)\(Constants.Network.languageOfRequest)\(Constants.Network.query)\(request)").responseJSON {
            movieJSONresponse in
            completion(movieJSONresponse.data!)
        }
        
    }
}
