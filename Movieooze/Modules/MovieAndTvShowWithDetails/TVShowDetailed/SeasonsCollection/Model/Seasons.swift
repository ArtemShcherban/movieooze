/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Seasons : Codable {
	let air_date : String?
	let episode_count : Int?
	let id : Int?
	let name : String?
	let overview : String?
	let poster_path : String?
	let season_number : Int?

	enum CodingKeys: String, CodingKey {

		case air_date = "air_date"
		case episode_count = "episode_count"
		case id = "id"
		case name = "name"
		case overview = "overview"
		case poster_path = "poster_path"
		case season_number = "season_number"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		air_date = try values.decodeIfPresent(String.self, forKey: .air_date)
		episode_count = try values.decodeIfPresent(Int.self, forKey: .episode_count)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		overview = try values.decodeIfPresent(String.self, forKey: .overview)
		poster_path = try values.decodeIfPresent(String.self, forKey: .poster_path)
		season_number = try values.decodeIfPresent(Int.self, forKey: .season_number)
	}

}