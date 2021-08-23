//
//  MovieDetailedScrollViewController.swift
//  Movieooze
//
//  Created by Artem Shcherban on 18.08.2021.
//

import UIKit
import Alamofire
import SDWebImage
import RealmSwift



class MovieDetailedScrollViewController: UIViewController, UIScrollViewDelegate {
    
   static let reuseIdentifire = String(describing: MovieDetailedScrollViewController.self)
    
    var scrollView: UIScrollView!
    var label: UILabel!
    var headerContainerView: UIView!
    var posterImageView: UIImageView!
    var gradientView: UIView!
    var mainContainerView: UIView!
    var titleTextLable, overviewTextLabel, releaseDateTextLabel, genreTextLabel : UILabel!
    var addToFavoriteButton: UIButton!
    var overviewClearButton: UIButton!
    var movie: Movie? = nil
    var movieFavorite: FavoriteMovieRealm? = nil
    var movieForDelete: MovieForDelete? = nil
    var buttonPressed = false
   

    
    override func viewDidLoad() {
        super.viewDidLoad()

        createViews()
        setViewConstraints()
        getMoviePoster()
        checkMovieForFavorites()
        fillDetailsOfMovie()
        

        // Title Text Lable Customization
        self.titleTextLable.backgroundColor = .clear
        self.titleTextLable.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        self.titleTextLable.textColor = .white

        // OverView Text Label Customization
        self.overviewTextLabel.backgroundColor = .clear
        self.overviewTextLabel.font = UIFont.systemFont(ofSize: 15)
        self.overviewTextLabel.textColor = .white

        // Release Date Label Customization
        self.releaseDateTextLabel.backgroundColor = .clear
        self.releaseDateTextLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        self.releaseDateTextLabel.textColor = myLightGreyColor
        
        // Genre Label Customization
        self.genreTextLabel.backgroundColor = .clear
        self.genreTextLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        self.genreTextLabel.textColor = myLightGreyColor

        // Label Customization
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .white
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Make sure the top constraint of the ScrollView is equal to Superview and not Safe Area
        
        // Hide the navigation bar completely
    //  self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        
        // Make the Navigation Bar background transparent
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = .white

    //     Remove 'Back' text and Title from Navigation Bar
    //    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    //    self.title = ""
        
        if addedToFavorite == false {
            self.addToFavoriteButton.setImage(UIImage(named: "fi-rr-add-white"), for: .normal)
        } else {
            self.addToFavoriteButton.setImage(UIImage(named: "fi-rr-heart_grey"), for: .normal)
        }
    }
    
    func createViews() {

        // Scroll View
        scrollView = UIScrollView()
        scrollView.backgroundColor = myDarkGreyColor
        scrollView.delegate = self
        self.view.addSubview(scrollView)
        
       // Main Container View
        mainContainerView = UIView()
        mainContainerView.backgroundColor = .clear
        self.scrollView.addSubview(mainContainerView)
        
        // Head Conteiner View
        headerContainerView = UIView()
        headerContainerView.backgroundColor = .black
        self.scrollView.addSubview(headerContainerView)
        
        // Poster View
        posterImageView = UIImageView()
        posterImageView.clipsToBounds = true
        posterImageView.backgroundColor = .black
        posterImageView.contentMode = .scaleAspectFill
        self.headerContainerView.addSubview(posterImageView)
        
        // Gradient View
        gradientView = UIView()
        
        let newLayer = CAGradientLayer()
        newLayer.colors = [UIColor.clear.cgColor,
                           myDarkGreyColor.cgColor]
        newLayer.endPoint = CGPoint(x: 0.5, y: 0.40)
        newLayer.frame = self.view.frame
        self.gradientView.layer.addSublayer(newLayer)
        
        self.scrollView.addSubview(gradientView)
        
        // Label
        label = UILabel()
        label.backgroundColor = .clear
        label.numberOfLines = 0
        self.scrollView.addSubview(label)
        
        // Title Text Lable
        titleTextLable = UILabel()
        titleTextLable.numberOfLines = 0
        titleTextLable.baselineAdjustment = .alignBaselines
        self.scrollView.addSubview(titleTextLable)

        // Add To Favorite Button
        addToFavoriteButton = UIButton()
        addToFavoriteButton.backgroundColor = .clear
        addToFavoriteButton.addTarget(self, action: #selector(addToFavoriteButtonPressed), for: .touchUpInside)
        self.scrollView.addSubview(addToFavoriteButton)
        
        // Release Date Label
        releaseDateTextLabel = UILabel()
        releaseDateTextLabel.numberOfLines = 1
        releaseDateTextLabel.baselineAdjustment = .alignBaselines
        self.scrollView.addSubview(releaseDateTextLabel)
        
        // Genre Date Label
        genreTextLabel = UILabel()
        genreTextLabel.numberOfLines = 1
        genreTextLabel.baselineAdjustment = .alignBaselines
        self.scrollView.addSubview(genreTextLabel)
        
        // OverView Text Label
        overviewTextLabel = UILabel()
        overviewTextLabel.numberOfLines = 3
        overviewTextLabel.baselineAdjustment = .alignBaselines
        self.scrollView.addSubview(overviewTextLabel)
        
        // Overview Clear Button
        overviewClearButton = UIButton()
        self.overviewClearButton.backgroundColor = .clear
        self.overviewClearButton.addTarget(self, action: #selector(openOverviewLabel), for: .touchUpInside)
        self.scrollView.addSubview(overviewClearButton)
    }


    func setViewConstraints() {
        
        // Label Constraints
        self.label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.label.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            self.label.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            self.label.bottomAnchor.constraint(equalTo: self.gradientView.bottomAnchor, constant: -10),
            self.label.topAnchor.constraint(equalTo: self.overviewTextLabel.bottomAnchor, constant: 20)
        ])
        
        // Scroll View Constraints
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
                                    self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                                    self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                                    self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)])
        
        // Main Container View Constraints
        self.mainContainerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.mainContainerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                                     self.mainContainerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                                     self.mainContainerView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 500),
                                     self.mainContainerView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor)])
        
        // Head Conteiner View Constraints
        let headerContainerViewBottom : NSLayoutConstraint!
        self.headerContainerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.headerContainerView.topAnchor.constraint(equalTo: self.view.topAnchor),
                                     self.headerContainerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                                     self.headerContainerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)])
        headerContainerViewBottom = self.headerContainerView.bottomAnchor.constraint(equalTo: self.mainContainerView.topAnchor, constant: -10)
        headerContainerViewBottom.priority = UILayoutPriority(rawValue: 900)
        headerContainerViewBottom.isActive = true
        
        // Poster View Constraints
        let posterImageViewTopConstraint: NSLayoutConstraint!
        self.posterImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.posterImageView.leadingAnchor.constraint(equalTo: self.headerContainerView.leadingAnchor),
                                     self.posterImageView.trailingAnchor.constraint(equalTo: self.headerContainerView.trailingAnchor),
                                     self.posterImageView.bottomAnchor.constraint(equalTo: self.headerContainerView.bottomAnchor)])
        posterImageViewTopConstraint = self.posterImageView.topAnchor.constraint(equalTo: self.view.topAnchor)
        posterImageViewTopConstraint.priority = UILayoutPriority(rawValue: 900)
        posterImageViewTopConstraint.isActive = true
        
        // Gradient View Constraints
        self.gradientView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.gradientView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                                     self.gradientView.trailingAnchor.constraint(equalTo: self.view.leadingAnchor),
                                     self.gradientView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
                                     self.gradientView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor)])
        
        // Title Text Lable Constraints
        self.titleTextLable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.titleTextLable.bottomAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 320),
                                     self.titleTextLable.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
                                     self.titleTextLable.trailingAnchor.constraint(lessThanOrEqualTo: self.view.trailingAnchor, constant: -144),
                                     self.titleTextLable.widthAnchor.constraint(equalToConstant: 250)])
        
        // Add To Favorite Button Constraints
        self.addToFavoriteButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.addToFavoriteButton.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 320),
                                     self.addToFavoriteButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -100),
                                     self.addToFavoriteButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 32),
                                     self.addToFavoriteButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 32)])
        
        // Release Date Label Constraints
        self.releaseDateTextLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.releaseDateTextLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
                                     self.releaseDateTextLabel.widthAnchor.constraint(equalToConstant: 35),
                                     self.releaseDateTextLabel.topAnchor.constraint(equalTo: self.addToFavoriteButton.bottomAnchor, constant: 4)])
        
        // Genre Date Label Constraints
        self.genreTextLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.genreTextLabel.leadingAnchor.constraint(equalTo: self.releaseDateTextLabel.trailingAnchor, constant: 8),
                                     self.genreTextLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 60),
                                     self.genreTextLabel.topAnchor.constraint(equalTo: self.addToFavoriteButton.bottomAnchor, constant: 4)])
        
        // OverView Text Label Constraints
        self.overviewTextLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.overviewTextLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
                                     self.overviewTextLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
                                     self.overviewTextLabel.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 400)])
        
        // Overview Clear Button Constraints
        self.overviewClearButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.overviewClearButton.leadingAnchor.constraint(equalTo: self.overviewTextLabel.leadingAnchor),
                                     self.overviewClearButton.trailingAnchor.constraint(equalTo: self.overviewTextLabel.trailingAnchor),
                                     self.overviewClearButton.topAnchor.constraint(equalTo: self.overviewTextLabel.topAnchor),
                                     self.overviewClearButton.bottomAnchor.constraint(equalTo: self.overviewTextLabel.bottomAnchor)])
        
    }

    func getMoviePoster() {
        var imageURL = ""
        if movie != nil {
            imageURL = posterBaseURL + "\(movie?.posterPath ?? "")"
        } else if movieFavorite != nil {
        imageURL = posterBaseURL + "\(movieFavorite?.posterPath ?? "")"
        }
        self.posterImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "placeholder.png"))
    }
    
    func checkMovieForFavorites() {
        if movie != nil {
            let genre = reciveGenreIds(array: movie?.genreIds ?? [])
            print(genre.number1 ?? 0, genre.number2 ?? 0)
            addedToFavorite = RealmManager.shared.searchMovieForFavoritesIDInRealm(movieID: self.movie?.id ?? 0)
        } else if movieFavorite != nil {
            addedToFavorite = true
       }
    }

    @objc func addToFavoriteButtonPressed() {
        if addedToFavorite == false {
             if movieForDelete != nil {
                 RealmManager.shared.SaveMovieForFavoritesAfterDelete(movie: movieForDelete ?? MovieForDelete())
                 addMovieForFavorites()
                 addedToFavorite = true
                 self.addToFavoriteButton.setImage(UIImage(named: "fi-rr-heart_grey"), for: .normal)
                 
                 } else if  movie != nil {
             RealmManager.shared.createAndSaveMovieForFavorites(movie: movie)
             addedToFavorite = true
             self.addToFavoriteButton.setImage(UIImage(named: "fi-rr-heart_grey"), for: .normal)
                     
             //   🧐 убрать print
//             print(movieTitle, addedToFavorite)
             print(RealmManager.shared.readFromRealmMovieForFavorites())
                     print(RealmManager.shared.readFromRealmMovieForFavorites().count)
                     
            }
            
         } else {
             
             if movie != nil {
                 RealmManager.shared.deleteMoviesForFavoritesFromRealmByID(movieID: movie?.id ?? 0)
                 
             } else if movieFavorite != nil {
                 addMovieForDelete()
                 RealmManager.shared.deleteMoviesForFavoritesFromRealmByID(movieID: movieFavorite?.id ?? 0 )
             }
             addedToFavorite = false
             self.addToFavoriteButton.setImage(UIImage(named: "fi-rr-add-white"), for: .normal)
             
             //   🧐 убрать print
             print(RealmManager.shared.readFromRealmMovieForFavorites())
                     print(RealmManager.shared.readFromRealmMovieForFavorites().count)
//             print(movieTitle , addedToFavorite)

         }
     }
     func addMovieForDelete() {
         
         movieForDelete = MovieForDelete()
         movieForDelete?.title = movieFavorite?.title ?? ""
         movieForDelete?.id  = movieFavorite?.id ?? 0
         movieForDelete?.overview = movieFavorite?.overview ?? ""
         movieForDelete?.adult = movieFavorite?.adult ?? false
         movieForDelete?.backdropPath = movieFavorite?.backdropPath ?? ""
         movieForDelete?.genreId = movieFavorite?.genreIdFirst ?? 0
         movieForDelete?.mediaType = movieFavorite?.mediaType ?? ""
         movieForDelete?.originalLanguage = movieFavorite?.originalLanguage ?? ""
         movieForDelete?.popularity = movieFavorite?.popularity ?? 0.0
         movieForDelete?.originalTitle = movieFavorite?.originalTitle ?? ""
         movieForDelete?.posterPath = movieFavorite?.posterPath ?? ""
         movieForDelete?.releaseDate = movieFavorite?.releaseDate ?? ""
         movieForDelete?.video = movieFavorite?.video ?? false
         movieForDelete?.voteAverage = movieFavorite?.voteAverage ?? 0.0
         movieForDelete?.voteCount = movieFavorite?.voteCount ?? 0
     }
     
     func addMovieForFavorites() {
         
         movieFavorite = FavoriteMovieRealm()
         movieFavorite?.title = movieForDelete?.title ?? ""
         movieFavorite?.id = movieForDelete?.id ?? 0
         movieFavorite?.overview = movieForDelete?.overview ?? ""
         movieFavorite?.adult = movieForDelete?.adult ?? false
         movieFavorite?.backdropPath = movieForDelete?.backdropPath ?? ""
         movieFavorite?.genreIdFirst = movieForDelete?.genreId ?? 0
         movieFavorite?.mediaType  = movieForDelete?.mediaType ?? ""
         movieFavorite?.originalLanguage = movieForDelete?.originalLanguage ?? ""
         movieFavorite?.popularity = movieForDelete?.popularity ?? 0.0
         movieFavorite?.originalTitle = movieForDelete?.originalTitle ?? ""
         movieFavorite?.posterPath = movieForDelete?.posterPath ?? ""
         movieFavorite?.releaseDate = movieForDelete?.releaseDate ?? ""
         movieFavorite?.video = movieForDelete?.video ?? false
         movieFavorite?.voteAverage = movieForDelete?.voteAverage ?? 0.0
         movieFavorite?.voteCount = movieForDelete?.voteCount ?? 0
     }

    @objc func openOverviewLabel(){
        if buttonPressed == false {
            self.overviewTextLabel.numberOfLines = 0
            buttonPressed = true
            view.layoutIfNeeded()
        } else if buttonPressed == true {
            self.overviewTextLabel.numberOfLines = 3
            buttonPressed = false
            view.layoutIfNeeded()
        }
    }
    func fillDetailsOfMovie()  {
        if movie != nil {
        fillDetailsFromMovie()
        } else {
            if movieFavorite != nil {
              fillDetailsFromFavoriteMovie()
            }
        }
    }
    
    func fillDetailsFromMovie() {
        titleTextLable.text = movie?.title
        overviewTextLabel.text = movie?.overview
        releaseDateTextLabel.text = dateFormat(date: movie?.releaseDate ?? "")
        genreTextLabel.text = dicGenres[movie?.genreIds?[0] ?? 0]?.name
    }
    
    func fillDetailsFromFavoriteMovie() {
        titleTextLable.text = movieFavorite?.title
        overviewTextLabel.text = movieFavorite?.overview
        releaseDateTextLabel.text = dateFormat(date: movieFavorite?.releaseDate ?? "")
        genreTextLabel.text = dicGenres[movieFavorite?.genreIdFirst ?? 0]?.name
    }
}
