/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Backdrops : Codable {
	let aspect_ratio : Double?
	let height : Int?
	let iso_639_1 : String?
	let file_path : String?
	let vote_average : Double?
	let vote_count : Int?
	let width : Int?

	enum CodingKeys: String, CodingKey {

		case aspect_ratio = "aspect_ratio"
		case height = "height"
		case iso_639_1 = "iso_639_1"
		case file_path = "file_path"
		case vote_average = "vote_average"
		case vote_count = "vote_count"
		case width = "width"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		aspect_ratio = try values.decodeIfPresent(Double.self, forKey: .aspect_ratio)
		height = try values.decodeIfPresent(Int.self, forKey: .height)
		iso_639_1 = try values.decodeIfPresent(String.self, forKey: .iso_639_1)
		file_path = try values.decodeIfPresent(String.self, forKey: .file_path)
		vote_average = try values.decodeIfPresent(Double.self, forKey: .vote_average)
		vote_count = try values.decodeIfPresent(Int.self, forKey: .vote_count)
		width = try values.decodeIfPresent(Int.self, forKey: .width)
	}

}