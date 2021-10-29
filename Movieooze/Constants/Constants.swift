//
//  Constants.swift
//  Movieooze
//
//  Created by Artem Shcherban on 09.09.2021.
//

import Foundation
import UIKit

struct  Constants {
    
    struct Network {
        
        static let apiKey = "api_key=86b8d80830ef6774289e25cad39e4fbd"
        static let tmbdDefaultPath = "https://api.themoviedb.org/3/"
        static let posterBaseURL = "https://image.tmdb.org/t/p/w500"
        static let movieAppendToResponse = "&append_to_response=videos,images,credits"
        static let tvShowAppendToResponse = "&append_to_response=credits"
        static let languageOfRequest = "&language=en-EN"
    }
    
    struct MyColors {
        static let myDarkGreyColor = UIColor(red: 24/255, green: 26/255, blue: 28/255, alpha: 1)
        static let myLightGreyColor = UIColor(red: 86/255, green: 92/255, blue: 100/255, alpha: 1)
    }
    
    struct ExcludedGenres {
        static let genresOfTvShow = [10767, 10763, 10764, 99]
    }
}
