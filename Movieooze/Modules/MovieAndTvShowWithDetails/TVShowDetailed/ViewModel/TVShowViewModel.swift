//
//  TVShowViewModel.swift
//  Movieooze
//
//  Created by Artem Shcherban on 29.09.2021.
//

import Foundation

class TVShowViewModel {
    
    var tvShowWithDetails: TVShowDetails! = nil
    var logoPath: String!
    var logoAspectRatio: Float = 0.0
    
    func tvShowDetailsRequest(tvShowID: Int, completion: @escaping(() -> ())) {
        TVShowDetailedNetworkService.alamofireTVShowDetailsRequest(tvShowID: tvShowID) { dataOfTVShow in
            self.tvShowWithDetails = dataOfTVShow.self
            
            completion()
        }
    }
    
    var backdrop_path : String {
        tvShowWithDetails.backdrop_path ?? ""
    }
    var created_by : [Created_by] {
        tvShowWithDetails.created_by ?? []
    }
    var episodeRunTime : String {
        self.runtimeString()
    }
    var first_air_date : String {
        DateFormat.dateFormatYear(date: tvShowWithDetails.first_air_date ?? "")
    }
    var genres : String {
        ListOfGenres.movieAndTVShowGenres(genres: tvShowWithDetails.genres ?? [])
    }
    var homepage : String {
        tvShowWithDetails.homepage ?? ""
    }
    var id : Int {
        tvShowWithDetails.id ?? 0
    }
    var in_production : Bool {
        tvShowWithDetails.in_production ?? false
    }
    var languages : [String] {
        tvShowWithDetails.languages ?? []
    }
    var last_air_date : String {
        tvShowWithDetails.last_air_date ?? ""
    }
    var last_episode_to_air : Last_episode_to_air? {
        tvShowWithDetails.last_episode_to_air ?? nil
    }
    var name : String {
        tvShowWithDetails.name ?? ""
    }
    var next_episode_to_air : Next_episode_to_air? {
        tvShowWithDetails.next_episode_to_air ?? nil
    }
    var networks : [Networks]{
        tvShowWithDetails.networks ?? []
    }
    var number_of_episodes : Int {
        tvShowWithDetails.number_of_episodes ?? 0
    }
    var number_of_seasons : Int {
        tvShowWithDetails.number_of_seasons ?? 0
    }
    var origin_country : [String] {
        tvShowWithDetails.origin_country ?? []
    }
    var original_language : String {
        tvShowWithDetails.original_language ?? ""
    }
    var original_name : String {
        tvShowWithDetails.original_name ?? ""
    }
    var overview : String {
        tvShowWithDetails.overview ?? ""
    }
    var popularity : Double {
        tvShowWithDetails.popularity ?? 0.0
    }
    var poster_path : String {
        tvShowWithDetails.poster_path ?? ""
    }
    var production_companies : [ProductionCompanies] {
        tvShowWithDetails.production_companies ?? []
    }
    var production_countries : String {
        self.getProductionCountries()
    }
    var seasons : [Seasons] {
        tvShowWithDetails.seasons ?? []
    }
    var spoken_languages : [Spoken_languages] {
        tvShowWithDetails.spoken_languages ?? []
    }
    var status : String {
        tvShowWithDetails.status ?? ""
    }
    var tagline : String {
        tvShowWithDetails.tagline ?? ""
    }
    var type : String {
        tvShowWithDetails.type ?? ""
    }
    var vote_average : Double {
        tvShowWithDetails.vote_average ?? 0.0
    }
    var vote_count : Int {
        tvShowWithDetails.vote_count ?? 0
    }
    var credits : Credits? {
        tvShowWithDetails.credits
    }
    var productionCompanyLogoURL : String {
        "\(Constants.Network.posterBaseURL)" + "\(logoPath ?? "" )"
    }
    
    func getProductionCompany(completion: @escaping(() -> ())) {
        
        var indexInArray = 0
        if tvShowWithDetails.production_companies?.isEmpty == true {
            completion()
        } else {
            if (tvShowWithDetails.production_companies?.count ?? 0) > 1 {
                var smalestID = tvShowWithDetails.production_companies?[0].id
                for index in  0..<(tvShowWithDetails.production_companies?.count ?? 0) {
                    if let a = tvShowWithDetails.production_companies?[index].id {
                        
                        if a < smalestID ?? 0 {
                            smalestID = a
                            indexInArray = index
                        }
                    }
                }
                let productionCompanyID = tvShowWithDetails.production_companies?[indexInArray].id ?? 0
                TVShowDetailedNetworkService.alamofirePoductionCompanyLogo(productionCompanyID: productionCompanyID) { TVShowImagesData in
                    if TVShowImagesData.logos?.isEmpty == true || TVShowImagesData.logos == nil{
                        completion()
                    } else {
                        
                        let logo = TVShowImagesData.logos?[0]
                        self.logoPath = logo?.file_path
                        self.getLogoAspectRatio(height: logo?.height ?? 0, width: logo?.width ?? 1)
                        completion()
                    }
                }
                //🧐 убрать print
                print(tvShowWithDetails.production_companies?[indexInArray].id ?? 0)
                print(tvShowWithDetails.id ?? 0 )
            } else {
                let productionCompanyID = tvShowWithDetails.production_companies?[indexInArray].id ?? 0
                
                TVShowDetailedNetworkService.alamofirePoductionCompanyLogo(productionCompanyID: productionCompanyID) { TVShowImagesData in
                    if TVShowImagesData.logos?.isEmpty == true || TVShowImagesData.logos == nil{
                        completion()
                    } else {
                        let logo = TVShowImagesData.logos?[0]
                        self.logoPath = logo?.file_path
                        self.getLogoAspectRatio(height: logo?.height ?? 0, width: logo?.width ?? 1)
                        completion()
                    }
                }
                //🧐 убрать print
                print(tvShowWithDetails.production_companies?[indexInArray].id ?? "")
                print(tvShowWithDetails.id ?? 0 )
            }
        }
    }
    
    private func runtimeString() -> String  {
        if tvShowWithDetails.episode_run_time?.isEmpty == true {
            return ""
        } else {
            return "\(tvShowWithDetails.episode_run_time?[0] ?? 0)" + " min."
        }
    }
    
    private func getLogoAspectRatio(height: Int, width: Int) {
        logoAspectRatio = Float(height) / Float(width)
    }
    
    private func getProductionCountries() -> String {
        if tvShowWithDetails.production_countries?.isEmpty == true {
            return ""
        } else {
            if tvShowWithDetails.production_countries?[0].iso_3166_1 == "US" {
                return "United States"
            } else {
                return tvShowWithDetails.production_countries?[0].name ?? ""
            }
        }
    }
    
}
