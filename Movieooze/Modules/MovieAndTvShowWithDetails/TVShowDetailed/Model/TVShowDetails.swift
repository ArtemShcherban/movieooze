/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct TVShowDetails : Codable {
	var backdrop_path : String?
    var created_by : [Created_by]?
    var episode_run_time : [Int]?
    var first_air_date : String?
    var genres : [Genres]?
    var homepage : String?
    var id : Int?
    var in_production : Bool?
    var languages : [String]?
    var last_air_date : String?
    var last_episode_to_air : Last_episode_to_air?
    var name : String?
    var next_episode_to_air : Next_episode_to_air?
    var networks : [Networks]?
    var number_of_episodes : Int?
    var number_of_seasons : Int?
    var origin_country : [String]?
    var original_language : String?
    var original_name : String?
    var overview : String?
    var popularity : Double?
    var poster_path : String?
    var production_companies : [ProductionCompanies]?
    var production_countries : [ProductionCountries]?
    var seasons : [Seasons]?
    var spoken_languages : [Spoken_languages]?
    var status : String?
    var tagline : String?
    var type : String?
    var vote_average : Double?
    var vote_count : Int?
    var credits : Credits?

	enum CodingKeys: String, CodingKey {

		case backdrop_path = "backdrop_path"
		case created_by = "created_by"
		case episode_run_time = "episode_run_time"
		case first_air_date = "first_air_date"
		case genres = "genres"
		case homepage = "homepage"
		case id = "id"
		case in_production = "in_production"
		case languages = "languages"
		case last_air_date = "last_air_date"
		case last_episode_to_air = "last_episode_to_air"
		case name = "name"
		case next_episode_to_air = "next_episode_to_air"
		case networks = "networks"
		case number_of_episodes = "number_of_episodes"
		case number_of_seasons = "number_of_seasons"
		case origin_country = "origin_country"
		case original_language = "original_language"
		case original_name = "original_name"
		case overview = "overview"
		case popularity = "popularity"
		case poster_path = "poster_path"
		case production_companies = "production_companies"
		case production_countries = "production_countries"
		case seasons = "seasons"
		case spoken_languages = "spoken_languages"
		case status = "status"
		case tagline = "tagline"
		case type = "type"
		case vote_average = "vote_average"
		case vote_count = "vote_count"
        case credits = "credits"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		backdrop_path = try values.decodeIfPresent(String.self, forKey: .backdrop_path)
		created_by = try values.decodeIfPresent([Created_by].self, forKey: .created_by)
		episode_run_time = try values.decodeIfPresent([Int].self, forKey: .episode_run_time)
		first_air_date = try values.decodeIfPresent(String.self, forKey: .first_air_date)
		genres = try values.decodeIfPresent([Genres].self, forKey: .genres)
		homepage = try values.decodeIfPresent(String.self, forKey: .homepage)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		in_production = try values.decodeIfPresent(Bool.self, forKey: .in_production)
		languages = try values.decodeIfPresent([String].self, forKey: .languages)
		last_air_date = try values.decodeIfPresent(String.self, forKey: .last_air_date)
		last_episode_to_air = try values.decodeIfPresent(Last_episode_to_air.self, forKey: .last_episode_to_air)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		next_episode_to_air = try values.decodeIfPresent(Next_episode_to_air.self, forKey: .next_episode_to_air)
		networks = try values.decodeIfPresent([Networks].self, forKey: .networks)
		number_of_episodes = try values.decodeIfPresent(Int.self, forKey: .number_of_episodes)
		number_of_seasons = try values.decodeIfPresent(Int.self, forKey: .number_of_seasons)
		origin_country = try values.decodeIfPresent([String].self, forKey: .origin_country)
		original_language = try values.decodeIfPresent(String.self, forKey: .original_language)
		original_name = try values.decodeIfPresent(String.self, forKey: .original_name)
		overview = try values.decodeIfPresent(String.self, forKey: .overview)
		popularity = try values.decodeIfPresent(Double.self, forKey: .popularity)
		poster_path = try values.decodeIfPresent(String.self, forKey: .poster_path)
		production_companies = try values.decodeIfPresent([ProductionCompanies].self, forKey: .production_companies)
		production_countries = try values.decodeIfPresent([ProductionCountries].self, forKey: .production_countries)
		seasons = try values.decodeIfPresent([Seasons].self, forKey: .seasons)
		spoken_languages = try values.decodeIfPresent([Spoken_languages].self, forKey: .spoken_languages)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		tagline = try values.decodeIfPresent(String.self, forKey: .tagline)
		type = try values.decodeIfPresent(String.self, forKey: .type)
		vote_average = try values.decodeIfPresent(Double.self, forKey: .vote_average)
		vote_count = try values.decodeIfPresent(Int.self, forKey: .vote_count)
        credits = try values.decodeIfPresent(Credits.self, forKey: .credits)
	}
    
    init(from tvShowForFavorites: TVShowForFavoritesRealm) {
        self.backdrop_path = tvShowForFavorites.backdrop_path
        self.first_air_date = tvShowForFavorites.first_air_date
        tvShowForFavorites.genreIdFirst = 0
        tvShowForFavorites.genreIdSecond = 0
        self.homepage = tvShowForFavorites.homepage
        self.id = tvShowForFavorites.id
        self.in_production = tvShowForFavorites.in_production
        self.last_air_date = tvShowForFavorites.last_air_date
        self.name = tvShowForFavorites.name 
        self.number_of_episodes = tvShowForFavorites.number_of_episodes 
        self.number_of_seasons = tvShowForFavorites.number_of_seasons 
        self.original_language = tvShowForFavorites.original_language 
        self.original_name = tvShowForFavorites.original_name 
        self.overview = tvShowForFavorites.overview 
        self.popularity = tvShowForFavorites.popularity 
        self.poster_path = tvShowForFavorites.poster_path 
        self.status = tvShowForFavorites.status 
        self.tagline = tvShowForFavorites.tagline 
        self.type = tvShowForFavorites.type 
        self.vote_average = tvShowForFavorites.vote_average 
        self.vote_count = tvShowForFavorites.vote_count 
    }

}
