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
    
    public func getSimilarMovies(request: String, completion: @escaping (Data) -> ()) {
        AF.request("\(Constants.Network.tmbdDefaultPath)\(request)\(Constants.Network.apiKey)\(Constants.Network.languageOfRequest)").responseJSON { myJSONresponse in
            completion(myJSONresponse.data!)
        }
    }
    
    public func getTVShowDetails(request: String, completion: @escaping (Data) -> ()) {
        AF.request("\(Constants.Network.tmbdDefaultPath)\(request)\(Constants.Network.apiKey)\(Constants.Network.tvShowAppendToResponse)").responseJSON { myJSONresponse in
            completion(myJSONresponse.data!)
        }
    }
}
