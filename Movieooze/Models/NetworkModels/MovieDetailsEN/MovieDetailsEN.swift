/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct MovieDetailsEN : Codable {
	var adult : Bool?
    var backdropPath : String?
    var belongsToCollection : BelongsToCollection?
    var budget : Int?
    var genres : [Genres]?
    var homepage : String?
    var id : Int?
    var imdbId : String?
    var originalLanguage : String?
    var originalTitle : String?
    var overview : String?
    var popularity : Double?
    var posterPath : String?
    var productionCompanies : [ProductionCompanies]?
    var productionCountries : [ProductionCountries]?
    var releaseDate : String?
    var revenue : Int?
    var runtime : Int?
    var spokenLanguages : [SpokenLanguages]?
    var status : String?
    var tagline : String?
    var title : String?
    var video : Bool?
    var voteAverage : Double?
    var voteCount : Int?
    var videos : Videos?
    var images : Images?
    var credits : Credits?

	enum CodingKeys: String, CodingKey {

		case adult = "adult"
		case backdropPath = "backdrop_path"
		case belongsToCollection = "belongs_to_collection"
		case budget = "budget"
		case genres = "genres"
		case homepage = "homepage"
		case id = "id"
		case imdbId = "imdb_id"
		case originalLanguage = "original_language"
		case originalTitle = "original_title"
		case overview = "overview"
		case popularity = "popularity"
		case posterPath = "poster_path"
		case productionCompanies = "production_companies"
		case productionCountries = "production_countries"
		case releaseDate = "release_date"
		case revenue = "revenue"
		case runtime = "runtime"
		case spokenLanguages = "spoken_languages"
		case status = "status"
		case tagline = "tagline"
		case title = "title"
		case video = "video"
		case voteAverage = "vote_average"
		case voteCount = "vote_count"
		case videos = "videos"
		case images = "images"
		case credits = "credits"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		adult = try values.decodeIfPresent(Bool.self, forKey: .adult)
		backdropPath = try values.decodeIfPresent(String.self, forKey: .backdropPath)
		belongsToCollection = try values.decodeIfPresent(BelongsToCollection.self, forKey: .belongsToCollection)
		budget = try values.decodeIfPresent(Int.self, forKey: .budget)
		genres = try values.decodeIfPresent([Genres].self, forKey: .genres)
		homepage = try values.decodeIfPresent(String.self, forKey: .homepage)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		imdbId = try values.decodeIfPresent(String.self, forKey: .imdbId)
		originalLanguage = try values.decodeIfPresent(String.self, forKey: .originalLanguage)
		originalTitle = try values.decodeIfPresent(String.self, forKey: .originalTitle)
		overview = try values.decodeIfPresent(String.self, forKey: .overview)
		popularity = try values.decodeIfPresent(Double.self, forKey: .popularity)
		posterPath = try values.decodeIfPresent(String.self, forKey: .posterPath)
		productionCompanies = try values.decodeIfPresent([ProductionCompanies].self, forKey: .productionCompanies)
		productionCountries = try values.decodeIfPresent([ProductionCountries].self, forKey: .productionCountries)
		releaseDate = try values.decodeIfPresent(String.self, forKey: .releaseDate)
		revenue = try values.decodeIfPresent(Int.self, forKey: .revenue)
		runtime = try values.decodeIfPresent(Int.self, forKey: .runtime)
		spokenLanguages = try values.decodeIfPresent([SpokenLanguages].self, forKey: .spokenLanguages)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		tagline = try values.decodeIfPresent(String.self, forKey: .tagline)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		video = try values.decodeIfPresent(Bool.self, forKey: .video)
		voteAverage = try values.decodeIfPresent(Double.self, forKey: .voteAverage)
		voteCount = try values.decodeIfPresent(Int.self, forKey: .voteCount)
		videos = try values.decodeIfPresent(Videos.self, forKey: .videos)
		images = try values.decodeIfPresent(Images.self, forKey: .images)
		credits = try values.decodeIfPresent(Credits.self, forKey: .credits)
	}
    
    init(from movieForFavorites: MovieForFavoritesRealm) {
//    self.title = movieForFavorites.title
//    self.adult = movieForFavorites.adult
//    self.overview = movieForFavorites.overview
//    self.posterPath = movieForFavorites.posterPath
//    self.voteAverage = movieForFavorites.voteAverage
//    self.id = movieForFavorites.id
//    self.backdropPath = movieForFavorites.backdropPath
//    self.genreIds = [movieForFavorites.genreIdFirst, movieForFavorites.genreIdSecond]
//    self.mediaType = movieForFavorites.mediaType
//    self.originalLanguage = movieForFavorites.originalLanguage
//    self.originalTitle = movieForFavorites.originalTitle
//    self.popularity = movieForFavorites.popularity
//    self.releaseDate = movieForFavorites.releaseDate
//    self.voteCount = movieForFavorites.voteCount
//    self.video = movieForFavorites.video
        self.adult = movieForFavorites.adult
        self.backdropPath = movieForFavorites.backdropPath
        self.budget = movieForFavorites.budget
//        self.genres = movieForFavorites.
        self.homepage = movieForFavorites.homepage
        self.id = movieForFavorites.id
        self.imdbId = movieForFavorites.imdbId
        self.originalLanguage = movieForFavorites.originalLanguage
        self.originalTitle = movieForFavorites.originalTitle
        self.overview = movieForFavorites.overview
        self.popularity = movieForFavorites.popularity
        self.posterPath = movieForFavorites.posterPath
//        self.productionCompanies : [ProductionCompanies]?
//        self.productionCountries : [ProductionCountries]?
        self.releaseDate = movieForFavorites.releaseDate
        self.revenue = movieForFavorites.revenue
        self.runtime = movieForFavorites.runtime
//        self.spokenLanguages : [SpokenLanguages]?
        self.status = movieForFavorites.status
        self.tagline = movieForFavorites.tagline
        self.title = movieForFavorites.tagline
        self.video = movieForFavorites.video
        self.voteAverage = movieForFavorites.voteAverage
        self.voteCount = movieForFavorites.voteCount
//        self.videos : Videos?
//        self.images : Images?
//        self.credits : Credits?

}

}
