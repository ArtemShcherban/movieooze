//
//  MovieDetailedViewModel.swift
//  Movieooze
//
//  Created by Artem Shcherban on 12.09.2021.
//

import Foundation

class MovieDetailedViewModel {
    
    //    var movieID: Int!
    var movieWithDetails: MovieDetailsEN! = nil
    var logoPath: String!
    var logoAspectRatio: Float = 0.0
    
    func movieDetailsRequest(movieID: Int, completion: @escaping(() -> ())) {
        MovieDetailedNetworkService.alamofireMovieDetailsRequest(movieID: movieID) { dataOfMovie in
            self.movieWithDetails = dataOfMovie.self
            completion()
        }
    }
    
    var adult : Bool {
        movieWithDetails.adult ?? false
    }
    var backdropPath : String {
        movieWithDetails.backdropPath ?? ""
    }
    var belongsToCollection : BelongsToCollection? {
        movieWithDetails.belongsToCollection
    }
    var budget : Int {
        movieWithDetails.budget ?? 0
    }
    
    var genres : String {
        ListOfGenres.movieAndTVShowGenres(genres: movieWithDetails.genres ?? [])
    }
    var homepage : String {
        movieWithDetails.homepage ?? ""
    }
    var id : Int {
        movieWithDetails.id ?? 0
    }
    var imdbId : String {
        movieWithDetails.imdbId ?? ""
    }
    var originalLanguage : String {
        movieWithDetails.originalLanguage ?? ""
    }
    var originalTitle : String {
        movieWithDetails.originalTitle ?? ""
    }
    var overview : String {
        movieWithDetails.overview ?? ""
    }
    var popularity : Double {
        movieWithDetails.popularity ?? 0.0
    }
    var posterPath : String {
        movieWithDetails.posterPath ?? ""
    }
    var productionCompanies : [ProductionCompanies] {
        movieWithDetails.productionCompanies ?? []
    }
    var productionCountries : String {
        getProductionCountries()
    }
    var releaseDate : String {
        DateFormat.dateFormatYear(date: movieWithDetails.releaseDate ?? "")
    }
    var revenue : Int {
        movieWithDetails.revenue ?? 0
    }
    
    var runtime : String {
        runtimeString()
    }
    
    var spokenLanguages : [SpokenLanguages] {
        movieWithDetails.spokenLanguages ?? []
    }
    var status : String {
        movieWithDetails.status ?? ""
    }
    var tagline : String {
        movieWithDetails.tagline ?? ""
    }
    var title : String {
        movieWithDetails.title ?? ""
    }
    var video : Bool {
        movieWithDetails.video ?? false
    }
    var voteAverage : Double {
        movieWithDetails.voteAverage ?? 0.0
    }
    var voteCount : Int {
        movieWithDetails.voteCount ?? 0
    }
    var videos : Videos? {
        movieWithDetails.videos
    }
    var images : Images? {
        movieWithDetails.images
    }
    var credits : Credits? {
        movieWithDetails.credits
    }
    var productionCompanyLogoURL : String {
        "\(Constants.Network.posterBaseURL)" + "\(logoPath ?? "" )"
    }
    
    
    
    func getProductionCompany(completion: @escaping(() -> ())) {
        
        var indexInArray = 0
        if movieWithDetails.productionCompanies?.isEmpty == true {
            completion()
        } else {
            if (movieWithDetails.productionCompanies?.count ?? 0) > 1 {
                var smalestID = movieWithDetails.productionCompanies?[0].id
                for index in  0..<(movieWithDetails.productionCompanies?.count ?? 0) {
                    if let a = movieWithDetails.productionCompanies?[index].id {
                        
                        if a < smalestID ?? 0 {
                            smalestID = a
                            indexInArray = index
                        }
                    }
                }
                let productionCompanyID = movieWithDetails.productionCompanies?[indexInArray].id ?? 0
                MovieDetailedNetworkService.alamofirePoductionCompanyLogo(productionCompanyID: productionCompanyID) { movieImagesData in
                    if movieImagesData.logos?.isEmpty == true || movieImagesData.logos == nil{
                        completion()
                    } else {
                        
                        let logo = movieImagesData.logos?[0]
                        self.logoPath = logo?.file_path
                        self.getLogoAspectRatio(height: logo?.height ?? 0, width: logo?.width ?? 1)
                        completion()
                    }
                }
                //🧐 убрать print
                print(movieWithDetails.productionCompanies?[indexInArray].id ?? 0)
                print(movieWithDetails.id ?? 0 )
            } else {
                let productionCompanyID = movieWithDetails.productionCompanies?[indexInArray].id ?? 0
                
                MovieDetailedNetworkService.alamofirePoductionCompanyLogo(productionCompanyID: productionCompanyID) { movieImagesData in
                    if movieImagesData.logos?.isEmpty == true || movieImagesData.logos == nil{
                        completion()
                    } else {
                        let logo = movieImagesData.logos?[0]
                        self.logoPath = logo?.file_path
                        self.getLogoAspectRatio(height: logo?.height ?? 0, width: logo?.width ?? 1)
                        completion()
                    }
                }
                //🧐 убрать print
                print(movieWithDetails.productionCompanies?[indexInArray].id ?? "")
                print(movieWithDetails.id ?? 0 )
            }
        }
    }
    
    private func runtimeString() -> String  {
        if movieWithDetails.runtime ?? 0 > 0{
            return "\(movieWithDetails.runtime ?? 0)" + " min."
        } else {
            return ""
        }
    }
    
    private func getLogoAspectRatio(height: Int, width: Int) {
        logoAspectRatio = Float(height) / Float(width)
    }
    
    private func getProductionCountries() -> String {
        if movieWithDetails.productionCountries?.isEmpty == true {
            return ""
        } else {
            if movieWithDetails.productionCountries?[0].iso_3166_1 == "US" {
                return "United States"
            } else {
                return movieWithDetails.productionCountries?[0].name ?? ""
            }
        }
    }
}
