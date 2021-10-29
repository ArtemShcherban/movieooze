/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct TvShowWithActor : Codable {
	let poster_path : String?
	let id : Int?
	let vote_average : Double?
	let first_air_date : String?
	let overview : String?
	let name : String?
	let vote_count : Int?
	let backdrop_path : String?
	let origin_country : [String]?
	let genre_ids : [Int]?
	let original_name : String?
	let original_language : String?
	let popularity : Double?
	let character : String?
	let credit_id : String?
	let episode_count : Int?

	enum CodingKeys: String, CodingKey {

		case poster_path = "poster_path"
		case id = "id"
		case vote_average = "vote_average"
		case first_air_date = "first_air_date"
		case overview = "overview"
		case name = "name"
		case vote_count = "vote_count"
		case backdrop_path = "backdrop_path"
		case origin_country = "origin_country"
		case genre_ids = "genre_ids"
		case original_name = "original_name"
		case original_language = "original_language"
		case popularity = "popularity"
		case character = "character"
		case credit_id = "credit_id"
		case episode_count = "episode_count"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		poster_path = try values.decodeIfPresent(String.self, forKey: .poster_path)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		vote_average = try values.decodeIfPresent(Double.self, forKey: .vote_average)
		first_air_date = try values.decodeIfPresent(String.self, forKey: .first_air_date)
		overview = try values.decodeIfPresent(String.self, forKey: .overview)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		vote_count = try values.decodeIfPresent(Int.self, forKey: .vote_count)
		backdrop_path = try values.decodeIfPresent(String.self, forKey: .backdrop_path)
		origin_country = try values.decodeIfPresent([String].self, forKey: .origin_country)
		genre_ids = try values.decodeIfPresent([Int].self, forKey: .genre_ids)
		original_name = try values.decodeIfPresent(String.self, forKey: .original_name)
		original_language = try values.decodeIfPresent(String.self, forKey: .original_language)
		popularity = try values.decodeIfPresent(Double.self, forKey: .popularity)
		character = try values.decodeIfPresent(String.self, forKey: .character)
		credit_id = try values.decodeIfPresent(String.self, forKey: .credit_id)
		episode_count = try values.decodeIfPresent(Int.self, forKey: .episode_count)
	}

}
