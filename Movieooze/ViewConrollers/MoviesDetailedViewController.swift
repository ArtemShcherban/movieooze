////
////  MoviesDetailedViewController.swift
////  Movieooze
////
////  Created by Artem Shcherban on 21.08.2021.
////
//
//
//import UIKit
//import RealmSwift
//import Alamofire
//
//class MoviesDetailedViewController: UIViewController, UIScrollViewDelegate {
//    
//    
//    @IBOutlet weak var moviePosterImageView: UIImageView!
//    @IBOutlet weak var titleTextLable: UILabel!
//    @IBOutlet weak var myCleanView: UIView!
//    @IBOutlet weak var favoriteButton: UIButton!
//    @IBOutlet weak var movieDescriptionLabel: UILabel!
//    
//    var movieTitle = ""
//    var moviePosterURL = ""
//    var movie: Movie? = nil
//    var movieForFavorites: FavoriteMovieRealm? = nil
//    var movieForDelete: MovieForDelete? = nil
//
//    var buttonPressed = false
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        
//        self.titleTextLable.bringSubviewToFront(self.view)
//        let newLayer = CAGradientLayer()
//        newLayer.colors = [UIColor.clear.cgColor,
//                           UIColor(displayP3Red: 24 / 255, green: 26 / 255, blue: 28 / 255, alpha: 1).cgColor]
//        newLayer.endPoint = CGPoint(x: 0.5, y: 0.55)
//        newLayer.frame = self.view.frame
//        self.view.layer.addSublayer(newLayer)
//        self.view.bringSubviewToFront(myCleanView)
//        
//        if movie != nil {
//            addedToFavorite = RealmManager.shared.searchMovieForFavoritesIDInRealm(movieID: self.movie?.id ?? 0)
//            self.titleTextLable.text = movie?.title
//            self.movieDescriptionLabel.text = movie?.overview
//            let imageURL = posterBaseURL + "\(movie?.posterPath ?? "")"
//            self.moviePosterImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "placeholder.png"))
//            
//            
//        } else if movieForFavorites != nil {
//            addedToFavorite = true
//            self.titleTextLable.text = movieForFavorites?.title
//            self.movieDescriptionLabel.text = movieForFavorites?.overview
//            let imageURL = posterBaseURL + "\(movieForFavorites?.posterPath ?? "")"
//            self.moviePosterImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "placeholder.png"))
//        }
////  print()
////        print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
////        print(Realm.Configuration.defaultConfiguration.fileURL)
////////        RealmManager.shared.createAndSaveMovieForFavorites(movie: movie)
//////        print(RealmManager.shared.readFromRealmMovieForFavorites())
////////        RealmManager.shared.createAndSaveLovlyMovie(movie: movie)
////////        print(RealmManager.shared.readfromRealmLovlyMovie())
////
////                print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")//        print()
//////        print(movie?.overview ?? "")
////                print("////////////////////////////////////////////")
////                print()
//////                RealmManager.shared.readfromRealm()
////                print(arrayOfMoviesForFavorites)
////                print("////////////////////////////////////////////")
////                print()
//        //        print("??????????????????????????????????????????????")
//        //        print()
//        //        RealmManager.shared.readfromRealm()
//        ////        print(arrayOfFavoriteMovies.count)
//        //        print("??????????????????????????????????????????????")
//    }
//    
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        if addedToFavorite == false {
//            self.favoriteButton.setImage(UIImage(named: "fi-rr-add-white"), for: .normal)
//        } else {
//            self.favoriteButton.setImage(UIImage(named: "fi-rr-heart_grey"), for: .normal)
//        }
//        print(movieTitle, addedToFavorite)
//    }
//    
//    @IBAction func descriptionButtonPressed(_ sender: Any) {
//        
//        
//        if buttonPressed == false {
//            movieDescriptionLabel.numberOfLines = 0
//            buttonPressed = true
//            view.layoutIfNeeded()
//        } else if buttonPressed == true {
//            movieDescriptionLabel.numberOfLines = 3
//            buttonPressed = false
//            view.layoutIfNeeded()
//        }
// 
//    }
//    
//    
//    
//    @IBAction func favoriteButtonPressed(_ sender: Any) {
//       if addedToFavorite == false {
//            if movieForDelete != nil {
//                RealmManager.shared.SaveMovieForFavoritesAfterDelete(movie: movieForDelete ?? MovieForDelete())
//                addMovieForFavorites()
//                addedToFavorite = true
//                self.favoriteButton.setImage(UIImage(named: "fi-rr-heart_grey"), for: .normal)
//                
//                //   🧐 убрать print
//                print(RealmManager.shared.readFromRealmMovieForFavorites())
//                        print(RealmManager.shared.readFromRealmMovieForFavorites().count)
//                
//                } else if  movie != nil {
//            RealmManager.shared.createAndSaveMovieForFavorites(movie: movie)
//            addedToFavorite = true
//            self.favoriteButton.setImage(UIImage(named: "fi-rr-heart_grey"), for: .normal)
//                    
//            //   🧐 убрать print
//                    print(RealmManager.shared.readFromRealmMovieForFavorites())
//                            print(RealmManager.shared.readFromRealmMovieForFavorites().count)
//                                    }
//        } else {
//            
//            if movie != nil {
//                RealmManager.shared.deleteMoviesForFavoritesFromRealmByID(movieID: movie?.id ?? 0)
//                
//            } else if movieForFavorites != nil {
//                addMovieForDelete()
//                RealmManager.shared.deleteMoviesForFavoritesFromRealmByID(movieID: movieForFavorites?.id ?? 0 )
//            }
//            addedToFavorite = false
//            self.favoriteButton.setImage(UIImage(named: "fi-rr-add-white"), for: .normal)
//            
//            //   🧐 убрать print
//            print(RealmManager.shared.readFromRealmMovieForFavorites())
//                    print(RealmManager.shared.readFromRealmMovieForFavorites().count)
//        }
//    }
//    func addMovieForDelete() {
//        
//        movieForDelete = MovieForDelete()
//        movieForDelete?.title = movieForFavorites?.title ?? ""
//        movieForDelete?.id  = movieForFavorites?.id ?? 0
//        movieForDelete?.overview = movieForFavorites?.overview ?? ""
//        movieForDelete?.adult = movieForFavorites?.adult ?? false
//        movieForDelete?.backdropPath = movieForFavorites?.backdropPath ?? ""
//        movieForDelete?.genreId = movieForFavorites?.genreIdFirst ?? 0
//        movieForDelete?.mediaType = movieForFavorites?.mediaType ?? ""
//        movieForDelete?.originalLanguage = movieForFavorites?.originalLanguage ?? ""
//        movieForDelete?.popularity = movieForFavorites?.popularity ?? 0.0
//        movieForDelete?.originalTitle = movieForFavorites?.originalTitle ?? ""
//        movieForDelete?.posterPath = movieForFavorites?.posterPath ?? ""
//        movieForDelete?.releaseDate = movieForFavorites?.releaseDate ?? ""
//        movieForDelete?.video = movieForFavorites?.video ?? false
//        movieForDelete?.voteAverage = movieForFavorites?.voteAverage ?? 0.0
//        movieForDelete?.voteCount = movieForFavorites?.voteCount ?? 0
//    }
//    
//    func addMovieForFavorites() {
//        
//        movieForFavorites = FavoriteMovieRealm()
//        movieForFavorites?.title = movieForDelete?.title ?? ""
//        movieForFavorites?.id = movieForDelete?.id ?? 0
//        movieForFavorites?.overview = movieForDelete?.overview ?? ""
//        movieForFavorites?.adult = movieForDelete?.adult ?? false
//        movieForFavorites?.backdropPath = movieForDelete?.backdropPath ?? ""
//        movieForFavorites?.genreIdFirst = movieForDelete?.genreId ?? 0
//        movieForFavorites?.mediaType  = movieForDelete?.mediaType ?? ""
//        movieForFavorites?.originalLanguage = movieForDelete?.originalLanguage ?? ""
//        movieForFavorites?.popularity = movieForDelete?.popularity ?? 0.0
//        movieForFavorites?.originalTitle = movieForDelete?.originalTitle ?? ""
//        movieForFavorites?.posterPath = movieForDelete?.posterPath ?? ""
//        movieForFavorites?.releaseDate = movieForDelete?.releaseDate ?? ""
//        movieForFavorites?.video = movieForDelete?.video ?? false
//        movieForFavorites?.voteAverage = movieForDelete?.voteAverage ?? 0.0
//        movieForFavorites?.voteCount = movieForDelete?.voteCount ?? 0
//    }
//
//}
//
