
import Foundation
import UIKit
import SDWebImage
import RealmSwift

var arrayOfMovies: [Movie] = []
var arrayOfMoviesForFavorites : [Movie] = []
var arrayOFGenres: [Genres] = []
var dicGenres: [Int: Genres] = [:]
var addedToFavorite = false
let posterBaseURL = "https://image.tmdb.org/t/p/w500"
let myDarkGreyColor = UIColor(red: 24/255, green: 26/255, blue: 28/255, alpha: 1)
let myLightGreyColor = UIColor(red: 86/255, green: 92/255, blue: 100/255, alpha: 1)


struct MovieForDelete {
    var title = ""
    var adult = false
    var overview = ""
    var posterPath = ""
    var voteAverage = 0.0
    var id = 0
    var backdropPath = ""
    var genreId = 0
    var mediaType = ""
    var originalLanguage = ""
    var originalTitle = ""
    var popularity = 0.0
    var releaseDate = ""
    var voteCount = 0
    var video = false
}

func dateFormat(date: String) -> String {

    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = "yyyy-MM-dd"
    
    let dateFormatterSet = DateFormatter()
    dateFormatterSet.dateFormat = "yyyy"
   
    if let date = dateFormatterGet.date(from: date) {
        return    dateFormatterSet.string(from: date)
    } else {
        return "There was an error decoding the string (Date)"
    }
}

func reciveGenreIds(array: [Int]) -> (number1: Int?, number2: Int?) {
    if array.count >= 2 {
        let  movieGenresFirstId = array[0]
        let  movieGenresSecondId = array[1]
        return (movieGenresFirstId, movieGenresSecondId)
    } else {
        let movieGenresFirstId = array[0]
        let movieGenresSecondId = 0
        return (movieGenresFirstId, movieGenresSecondId)
    }
}



func movieStarsLevel(level: Double) -> UIImage? {
   
    var starsLevelResult = UIImage(named: "fi-rr-0_5star_orange")
    
    switch level {
    case 9.5...10:
        starsLevelResult = UIImage(named: "fi-rr-5stars_orange")
    case 8.5..<9.5:
        starsLevelResult = UIImage(named: "fi-rr-4_5stars_orange")
    case 7.5..<8.5:
        starsLevelResult = UIImage(named: "fi-rr-4stars_orange")
    case 6.5..<7.5:
        starsLevelResult = UIImage(named: "fi-rr-3_5stars_orange")
    case 5.5..<6.5:
        starsLevelResult = UIImage(named: "fi-rr-3stars_orange")
    case 4.5..<5.5:
        starsLevelResult = UIImage(named: "fi-rr-2_5stars_orange")
    case 3.5..<4.5:
        starsLevelResult = UIImage(named: "fi-rr-2stars_orange")
    case 2.5..<3.5:
        starsLevelResult = UIImage(named: "fi-rr-1_5stars_orange")
    case 1.5..<2.5:
        starsLevelResult = UIImage(named: "fi-rr-1star_orange")
    case 0.0..<1.5:
        starsLevelResult = UIImage(named: "fi-rr-0_5star_orange")
    default:
        break
    }
    return starsLevelResult
}

func arrayToDictionary(array: [Genres]){
    dicGenres = array.toDictionary { $0.id ?? 000000 }
}

extension Array {
    public func toDictionary<Key : Hashable>(with selectKey: (Element) -> Key) -> [Key : Element] {
        var dict = [Key : Element]()
        for element in self {
            dict[selectKey(element)] = element
        }
        return dict
    }
}

