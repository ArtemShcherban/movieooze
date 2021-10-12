/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct TVShowSeason : Codable {
	let longID : String?
	let air_date : String?
	let episodes : [Episodes]?
	let name : String?
	let overview : String?
	let id : Int?
	let poster_path : String?
	let season_number : Int?
	let credits : Credits?

	enum CodingKeys: String, CodingKey {

		case longID = "_id"
		case air_date = "air_date"
		case episodes = "episodes"
		case name = "name"
		case overview = "overview"
		case id = "id"
		case poster_path = "poster_path"
		case season_number = "season_number"
		case credits = "credits"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		longID = try values.decodeIfPresent(String.self, forKey: .longID)
		air_date = try values.decodeIfPresent(String.self, forKey: .air_date)
		episodes = try values.decodeIfPresent([Episodes].self, forKey: .episodes)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		overview = try values.decodeIfPresent(String.self, forKey: .overview)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		poster_path = try values.decodeIfPresent(String.self, forKey: .poster_path)
		season_number = try values.decodeIfPresent(Int.self, forKey: .season_number)
		credits = try values.decodeIfPresent(Credits.self, forKey: .credits)
	}

}
