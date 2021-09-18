//
//  MovieDetailedViewModel.swift
//  Movieooze
//
//  Created by Artem Shcherban on 12.09.2021.
//

import Foundation

class MovieDetailedViewModel {

    var movieID: Int!
    var movieWithDetailsNew: MovieDetailsEN! = nil
    var logoPath: String!
    var logoAspectRatio: Float = 0.0
    
    func movieDetailsRequest(movieID: Int, completion: @escaping(() -> ())) {
        MovieDetailedNetworkService.alamofireMovieDetailsRequest(movieID: movieID) { dataOfMovie in
            self.movieWithDetailsNew = dataOfMovie.self
            completion()
        }
    }
    
    var adult : Bool {
        movieWithDetailsNew.adult ?? false
    }
    var backdropPath : String {
        movieWithDetailsNew.backdropPath ?? ""
    }
    var belongsToCollection : BelongsToCollection? {
        movieWithDetailsNew.belongsToCollection
    }
    var budget : Int {
        movieWithDetailsNew.budget ?? 0
    }

    var genres : String {
        ListOfGenres.movieGenres(genres: movieWithDetailsNew.genres ?? [])
    }
    var homepage : String {
        movieWithDetailsNew.homepage ?? ""
    }
    var id : Int {
        movieWithDetailsNew.id ?? 0
    }
    var imdbId : String {
        movieWithDetailsNew.imdbId ?? ""
    }
    var originalLanguage : String {
        movieWithDetailsNew.originalLanguage ?? ""
    }
    var originalTitle : String {
        movieWithDetailsNew.originalTitle ?? ""
    }
    var overview : String {
        movieWithDetailsNew.overview ?? ""
    }
    var popularity : Double {
        movieWithDetailsNew.popularity ?? 0.0
    }
    var posterPath : String {
        movieWithDetailsNew.posterPath ?? ""
    }
    var productionCompanies : [ProductionCompanies] {
        movieWithDetailsNew.productionCompanies ?? []
    }
    var productionCountries : String {
        getProductionCountries()
    }
    var releaseDate : String {
        DateFormat.dateFormatYear(date: movieWithDetailsNew.releaseDate ?? "")
    }
    var revenue : Int {
        movieWithDetailsNew.revenue ?? 0
    }

    var runtime : String {
        runtimeString()
    }
    
    var spokenLanguages : [SpokenLanguages] {
        movieWithDetailsNew.spokenLanguages ?? []
    }
    var status : String {
        movieWithDetailsNew.status ?? ""
    }
    var tagline : String {
        movieWithDetailsNew.tagline ?? ""
    }
    var title : String {
        movieWithDetailsNew.title ?? ""
    }
    var video : Bool {
        movieWithDetailsNew.video ?? false
    }
    var voteAverage : Double {
        movieWithDetailsNew.voteAverage ?? 0.0
    }
    var voteCount : Int {
        movieWithDetailsNew.voteCount ?? 0
    }
    var videos : Videos? {
        movieWithDetailsNew.videos
    }
    var images : Images? {
        movieWithDetailsNew.images
    }
    var credits : Credits? {
        movieWithDetailsNew.credits
    }
    var productionCompanyLogoURL : String {
        "\(Constants.Network.posterBaseURL)" + "\(logoPath ?? "" )"
    }

    
    
    func getProductionCompany(completion: @escaping(() -> ())) {
       
        var indexInArray = 0
        if movieWithDetailsNew.productionCompanies?.isEmpty == true {
            completion()
        } else {
            if (movieWithDetailsNew.productionCompanies?.count ?? 0) > 1 {
                var smalestID = movieWithDetailsNew.productionCompanies?[0].id
                for index in  0..<(movieWithDetailsNew.productionCompanies?.count ?? 0) {
                    if let a = movieWithDetailsNew.productionCompanies?[index].id {
                        
                        if a < smalestID ?? 0 {
                            smalestID = a
                            indexInArray = index
                        }
                    }
                }
                let productionCompanyID = movieWithDetailsNew.productionCompanies?[indexInArray].id ?? 0
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
                print(movieWithDetailsNew.productionCompanies?[indexInArray].id ?? 0)
                print(movieWithDetailsNew.id ?? 0 )
            } else {
                let productionCompanyID = movieWithDetailsNew.productionCompanies?[indexInArray].id ?? 0
                
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
                print(movieWithDetailsNew.productionCompanies?[indexInArray].id ?? "")
                print(movieWithDetailsNew.id ?? 0 )
            }
        }
    }
    
    func runtimeString() -> String  {
        if movieWithDetailsNew.runtime ?? 0 > 0{
            return "\(movieWithDetailsNew.runtime ?? 0)" + " min."
        } else {
            return ""
        }
    }
    
    func getLogoAspectRatio(height: Int, width: Int) {
        logoAspectRatio = Float(height) / Float(width)
    }
    
    func getProductionCountries() -> String {
        if movieWithDetailsNew.productionCountries?.isEmpty == true {
            return ""
        } else {
            if movieWithDetailsNew.productionCountries?[0].iso_3166_1 == "US" {
                return "United States"
            } else {
                return movieWithDetailsNew.productionCountries?[0].name ?? ""
            }
        }
    }
}
