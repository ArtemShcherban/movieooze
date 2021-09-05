
import Foundation
struct Movie: Codable {
    var genreIds : [Int]?
    var id : Int?
    var originalLanguage : String?
    var originalTitle : String?
    var posterPath : String?
    var video : Bool?
    var voteAverage : Double?
    var overview : String?
    var releaseDate : String?
    var voteCount : Int?
    var adult : Bool?
    var backdropPath : String?
    var title : String?
    var popularity : Double?
    var mediaType : String?

    enum CodingKeys: String, CodingKey {

        case genreIds = "genre_ids"
        case id = "id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case video = "video"
        case voteAverage = "vote_average"
        case overview = "overview"
        case releaseDate = "release_date"
        case voteCount = "vote_count"
        case adult = "adult"
        case backdropPath = "backdrop_path"
        case title = "title"
        case popularity = "popularity"
        case mediaType = "media_type"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        genreIds = try values.decodeIfPresent([Int].self, forKey: .genreIds)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        originalLanguage = try values.decodeIfPresent(String.self, forKey: .originalLanguage)
        originalTitle = try values.decodeIfPresent(String.self, forKey: .originalTitle)
        posterPath = try values.decodeIfPresent(String.self, forKey: .posterPath)
        video = try values.decodeIfPresent(Bool.self, forKey: .video)
        voteAverage = try values.decodeIfPresent(Double.self, forKey: .voteAverage)
        overview = try values.decodeIfPresent(String.self, forKey: .overview)
        releaseDate = try values.decodeIfPresent(String.self, forKey: .releaseDate)
        voteCount = try values.decodeIfPresent(Int.self, forKey: .voteCount)
        adult = try values.decodeIfPresent(Bool.self, forKey: .adult)
        backdropPath = try values.decodeIfPresent(String.self, forKey: .backdropPath)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        popularity = try values.decodeIfPresent(Double.self, forKey: .popularity)
        mediaType = try values.decodeIfPresent(String.self, forKey: .mediaType)
    }

        init(from movieForFavorites: MovieForFavoritesRealm) {
        self.title = movieForFavorites.title
        self.adult = movieForFavorites.adult
        self.overview = movieForFavorites.overview
        self.posterPath = movieForFavorites.posterPath
        self.voteAverage = movieForFavorites.voteAverage
        self.id = movieForFavorites.id
        self.backdropPath = movieForFavorites.backdropPath
        self.genreIds = [movieForFavorites.genreIDFirst, movieForFavorites.genreIDSecond]
        self.originalLanguage = movieForFavorites.originalLanguage
        self.originalTitle = movieForFavorites.originalTitle
        self.popularity = movieForFavorites.popularity
        self.releaseDate = movieForFavorites.releaseDate
        self.voteCount = movieForFavorites.voteCount
        self.video = movieForFavorites.video
    }
}
