/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct TVShow : Codable {
	var name : String?
    var original_name : String?
    var origin_country : [String]?
    var vote_count : Int?
    var backdrop_path : String?
    var vote_average : Double?
    var genre_ids : [Int]?
    var id : Int?
    var original_language : String?
    var overview : String?
    var poster_path : String?
    var first_air_date : String?
    var popularity : Double?
    var media_type : String?

	enum CodingKeys: String, CodingKey {

		case name = "name"
		case original_name = "original_name"
		case origin_country = "origin_country"
		case vote_count = "vote_count"
		case backdrop_path = "backdrop_path"
		case vote_average = "vote_average"
		case genre_ids = "genre_ids"
		case id = "id"
		case original_language = "original_language"
		case overview = "overview"
		case poster_path = "poster_path"
		case first_air_date = "first_air_date"
		case popularity = "popularity"
		case media_type = "media_type"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		original_name = try values.decodeIfPresent(String.self, forKey: .original_name)
		origin_country = try values.decodeIfPresent([String].self, forKey: .origin_country)
		vote_count = try values.decodeIfPresent(Int.self, forKey: .vote_count)
		backdrop_path = try values.decodeIfPresent(String.self, forKey: .backdrop_path)
		vote_average = try values.decodeIfPresent(Double.self, forKey: .vote_average)
		genre_ids = try values.decodeIfPresent([Int].self, forKey: .genre_ids)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		original_language = try values.decodeIfPresent(String.self, forKey: .original_language)
		overview = try values.decodeIfPresent(String.self, forKey: .overview)
		poster_path = try values.decodeIfPresent(String.self, forKey: .poster_path)
		first_air_date = try values.decodeIfPresent(String.self, forKey: .first_air_date)
		popularity = try values.decodeIfPresent(Double.self, forKey: .popularity)
		media_type = try values.decodeIfPresent(String.self, forKey: .media_type)
	}
    init(from tvShowForFavorites: TVShowForFavoritesRealm) {
        self.name = tvShowForFavorites.name
        self.original_name = tvShowForFavorites.name
        self.origin_country = [tvShowForFavorites.origin_country]
        self.vote_count = tvShowForFavorites.vote_count
        self.backdrop_path = tvShowForFavorites.backdrop_path
        self.vote_average = tvShowForFavorites.vote_average
        self.genre_ids = [tvShowForFavorites.genreIdFirst, tvShowForFavorites.genreIdSecond]
        self.id = tvShowForFavorites.id
        self.original_language = tvShowForFavorites.original_language
        self.overview = tvShowForFavorites.overview
        self.poster_path = tvShowForFavorites.poster_path
        self.first_air_date = tvShowForFavorites.first_air_date
        self.popularity = tvShowForFavorites.popularity
        self.media_type = tvShowForFavorites.type

    }
    
    init(from tvShowSearchResult: TvShowSearchResults) {
        self.name = tvShowSearchResult.name
        self.original_name = tvShowSearchResult.name
        self.origin_country = tvShowSearchResult.origin_country
        self.vote_count = tvShowSearchResult.vote_count
        self.backdrop_path = tvShowSearchResult.backdrop_path
        self.vote_average = tvShowSearchResult.vote_average
        self.genre_ids = tvShowSearchResult.genre_ids
        self.id = tvShowSearchResult.id
        self.original_language = tvShowSearchResult.original_language
        self.overview = tvShowSearchResult.overview
        self.poster_path = tvShowSearchResult.poster_path
        self.first_air_date = tvShowSearchResult.first_air_date
        self.popularity = tvShowSearchResult.popularity
    }
    
}
