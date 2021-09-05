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
    var titleTextLable, overviewTextLabel, releaseDateTextLabel, genresTextLabel, runtimeTextLabel: UILabel!
    var addToFavoriteButton, overviewClearButton, playButton: UIButton!
    var overviewButtonPressed = false
    var movieID: Int!
    var movieWithDetails: MovieDetailsEN? = nil
    var actorsView, moviesView: UIView!
    var nameOfCollectionViewActorsLabel, nameOfCollectionViewMoviesLabel: UILabel!
    var actorsCollectionView, moviesCollectionView: UICollectionView!
    var layoutActors, layoutMovies: UICollectionViewFlowLayout!
    var arrayOfActors: [Cast] = []
    var dividerTopLineActorView, dividerLineActorsView, dividerLineMoviesView: UIView!
    var arrayOfSimilarMovies: [SimilarMovie] = []
    var arrayOfTraillers: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alamofireMovieDetailsRequest()
        alamofireSimilarMoviesRequest()
        alamofireVideoMaterialsRequest()
        createViews()
        setViewConstraints()
        checkMovieForFavorites()
 
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
        self.genresTextLabel.backgroundColor = .clear
        self.genresTextLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        self.genresTextLabel.textColor = myLightGreyColor
        
        // Run Time Text Label Customization
        self.runtimeTextLabel.backgroundColor = .clear
        self.runtimeTextLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        self.runtimeTextLabel.textColor = myLightGreyColor
        
        // Actors View Customization
        self.actorsView.backgroundColor = .clear
        
        // Name Of Collection View Actors Customization
        self.nameOfCollectionViewActorsLabel.backgroundColor = .clear
        self.nameOfCollectionViewActorsLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        self.nameOfCollectionViewActorsLabel.textColor = myLightGreyColor
        
        // Name Of Collection View Movies
        self.nameOfCollectionViewMoviesLabel.backgroundColor = .clear
        self.nameOfCollectionViewMoviesLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        self.nameOfCollectionViewMoviesLabel.textColor = myLightGreyColor
        
        // Movies View Customization
        self.moviesView.backgroundColor = .clear
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Make the Navigation Bar background transparent
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = .white
        
        // Set Image for Add To Favorite Button
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
        
        // Play Button
        playButton = UIButton()
        playButton.backgroundColor = .clear
        playButton.setImage(UIImage(named: "fi-rr-play-alt_orange"), for: .normal)
        playButton.addTarget(self, action: #selector(playButtonPressed), for: .touchUpInside)
        self.scrollView.addSubview(playButton)
        
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
        
        // Genre Label
        genresTextLabel = UILabel()
        genresTextLabel.numberOfLines = 1
        genresTextLabel.baselineAdjustment = .alignBaselines
        self.scrollView.addSubview(genresTextLabel)
        
        // Run Time Text Label
        runtimeTextLabel = UILabel()
        runtimeTextLabel.numberOfLines = 1
        runtimeTextLabel.baselineAdjustment = .alignBaselines
        self.scrollView.addSubview(runtimeTextLabel)
        
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
        
        // Actors View
        self.actorsView = UIView()
        self.scrollView.addSubview(actorsView)
        
        // Name Of Collection View Actors Label
        nameOfCollectionViewActorsLabel = UILabel()
        nameOfCollectionViewActorsLabel.numberOfLines = 1
        nameOfCollectionViewActorsLabel.baselineAdjustment = .alignBaselines
        self.actorsView.addSubview(nameOfCollectionViewActorsLabel)
        
        // Movies View
        self.moviesView = UIView()
        self.scrollView.addSubview(moviesView)
        
        // Name Of Collection View Movies
        nameOfCollectionViewMoviesLabel = UILabel()
        nameOfCollectionViewMoviesLabel.numberOfLines = 1
        nameOfCollectionViewMoviesLabel.baselineAdjustment = .alignBaselines
        self.moviesView.addSubview(nameOfCollectionViewMoviesLabel)
        
        // Layout Actors
        self.layoutActors = UICollectionViewFlowLayout()
        self.layoutActors.sectionInset = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
        self.layoutActors.itemSize = CGSize(width: 80, height: 160)
        self.layoutActors.scrollDirection = UICollectionView.ScrollDirection.horizontal
        
        // Layout Movies
        self.layoutMovies = UICollectionViewFlowLayout()
        self.layoutMovies.sectionInset = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
        self.layoutMovies.itemSize = CGSize(width: 80, height: 160)
        self.layoutMovies.scrollDirection = UICollectionView.ScrollDirection.horizontal
        
        // Actors Collection View
        self.actorsCollectionView = UICollectionView(frame: self.actorsView.frame, collectionViewLayout: layoutActors)
        self.actorsCollectionView.dataSource = self
        self.actorsCollectionView.delegate = self
        self.actorsCollectionView.register(ActorCollectionViewCell.self, forCellWithReuseIdentifier: ActorCollectionViewCell.reuseIndetifire)
        self.actorsCollectionView.backgroundColor = .clear
        self.actorsView.addSubview(actorsCollectionView)
        
        // Divider Top Line Actors View
        self.dividerTopLineActorView = UIView()
        self.dividerTopLineActorView.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        self.actorsView.addSubview(dividerTopLineActorView)
        
        // Divider Line Actors View
        self.dividerLineActorsView = UIView()
        self.dividerLineActorsView.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        self.actorsView.addSubview(dividerLineActorsView)
        
        // Divider Line Movies View
        self.dividerLineMoviesView = UIView()
        self.dividerLineMoviesView.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        self.actorsView.addSubview(dividerLineMoviesView)
        
        // Movies Collection View
        self.moviesCollectionView = UICollectionView(frame: self.moviesView.frame, collectionViewLayout: layoutMovies)
        self.moviesCollectionView.dataSource = self
        self.moviesCollectionView.delegate = self
        self.moviesCollectionView.register(SimilarMovieCollectionViewCell.self, forCellWithReuseIdentifier: SimilarMovieCollectionViewCell.reuseIndetifire)
        self.moviesCollectionView.backgroundColor = .clear
        self.moviesView.addSubview(moviesCollectionView)
        
    }
    
    func setViewConstraints() {
        
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
                                     self.titleTextLable.widthAnchor.constraint(equalToConstant: 250)])
        
        // Add To Favorite Button Constraints
        self.addToFavoriteButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.addToFavoriteButton.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 320),
                                     self.addToFavoriteButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
                                     self.addToFavoriteButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 32),
                                     self.addToFavoriteButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 32)])
        
        // Play Button Constraints
        self.playButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.playButton.topAnchor.constraint(equalTo: self.titleTextLable.bottomAnchor, constant: 4),
                                     self.playButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
                                     self.playButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 40),
                                     self.playButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 40)])
        
        // Release Date Label Constraints
        self.releaseDateTextLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.releaseDateTextLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
                                     self.releaseDateTextLabel.widthAnchor.constraint(equalToConstant: 35),
                                     self.releaseDateTextLabel.topAnchor.constraint(equalTo: self.playButton.bottomAnchor, constant: 8)])
        
        // Genre Date Label Constraints
        self.genresTextLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.genresTextLabel.leadingAnchor.constraint(equalTo: self.releaseDateTextLabel.trailingAnchor, constant: 8),
                                     self.genresTextLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 60),
                                     self.genresTextLabel.topAnchor.constraint(equalTo: self.playButton.bottomAnchor, constant: 8)])
        
        // Genre Date Label Constraints
        self.runtimeTextLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.runtimeTextLabel.leadingAnchor.constraint(equalTo: self.genresTextLabel.trailingAnchor, constant: 8),
                                     self.runtimeTextLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 60),
                                     self.runtimeTextLabel.topAnchor.constraint(equalTo: self.playButton.bottomAnchor, constant: 8)])
        
        // OverView Text Label Constraints
        self.overviewTextLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.overviewTextLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
                                     self.overviewTextLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
                                     self.overviewTextLabel.topAnchor.constraint(equalTo: self.releaseDateTextLabel.bottomAnchor, constant: 12)])
        
        // Overview Clear Button Constraints
        self.overviewClearButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.overviewClearButton.leadingAnchor.constraint(equalTo: self.overviewTextLabel.leadingAnchor),
                                     self.overviewClearButton.trailingAnchor.constraint(equalTo: self.overviewTextLabel.trailingAnchor),
                                     self.overviewClearButton.topAnchor.constraint(equalTo: self.overviewTextLabel.topAnchor),
                                     self.overviewClearButton.bottomAnchor.constraint(equalTo: self.overviewTextLabel.bottomAnchor)])
        
        // Actors View Constraints
        actorsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.actorsView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                                     self.actorsView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
                                     self.actorsView.topAnchor.constraint(equalTo: self.overviewTextLabel.bottomAnchor, constant: 4 ),
                                     self.actorsView.heightAnchor.constraint(equalToConstant: 190)])
        
        // Name Of Collection View Actors Constraints
        nameOfCollectionViewActorsLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.nameOfCollectionViewActorsLabel.leadingAnchor.constraint(equalTo: self.actorsView.leadingAnchor, constant: 18),
                                     self.nameOfCollectionViewActorsLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
                                     self.nameOfCollectionViewActorsLabel.bottomAnchor.constraint(equalTo: self.actorsCollectionView.topAnchor),
                                     self.nameOfCollectionViewActorsLabel.heightAnchor.constraint(equalToConstant: 20)])
        
        // Actors Collection View Constraints
        actorsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.actorsCollectionView.leadingAnchor.constraint(equalTo: self.actorsView.leadingAnchor, constant: 18),
                                     self.actorsCollectionView.trailingAnchor.constraint(equalTo: self.actorsView.trailingAnchor),
                                     self.actorsCollectionView.topAnchor.constraint(equalTo: self.actorsView.topAnchor, constant: 30),
                                     self.actorsCollectionView.bottomAnchor.constraint(equalTo: self.actorsView.bottomAnchor)])
        
        // Divider Top Line Actors Constraints
        dividerTopLineActorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.dividerTopLineActorView.leadingAnchor.constraint(equalTo: self.actorsView.leadingAnchor, constant: 18),
                                     self.dividerTopLineActorView.trailingAnchor.constraint(equalTo: self.actorsView.trailingAnchor),
                                     self.dividerTopLineActorView.topAnchor.constraint(equalTo: self.actorsView.topAnchor, constant: 4 ),
                                     self.dividerTopLineActorView.heightAnchor.constraint(equalToConstant: 0.5)])
        
        // Divider Line Actors Constraints
        dividerLineActorsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.dividerLineActorsView.leadingAnchor.constraint(equalTo: self.actorsView.leadingAnchor, constant: 18),
                                     self.dividerLineActorsView.trailingAnchor.constraint(equalTo: self.actorsView.trailingAnchor),
                                     self.dividerLineActorsView.topAnchor.constraint(equalTo: self.actorsView.bottomAnchor, constant: -2 ),
                                     self.dividerLineActorsView.heightAnchor.constraint(equalToConstant: 0.5)])
        
        // Movies View Constraints
        moviesView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.moviesView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                                     self.moviesView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
                                     self.moviesView.topAnchor.constraint(equalTo: self.actorsView.bottomAnchor, constant: 2 ),
                                     self.moviesView.heightAnchor.constraint(equalToConstant: 180),
                                     self.moviesView.bottomAnchor.constraint(equalTo: self.gradientView.bottomAnchor, constant: -10 )])
        
        // Name Of Collection View Movies Constraints
        nameOfCollectionViewMoviesLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.nameOfCollectionViewMoviesLabel.leadingAnchor.constraint(equalTo: self.moviesView.leadingAnchor, constant: 18),
                                     self.nameOfCollectionViewMoviesLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
                                     self.nameOfCollectionViewMoviesLabel.bottomAnchor.constraint(equalTo: self.moviesCollectionView.topAnchor),
                                     self.nameOfCollectionViewMoviesLabel.heightAnchor.constraint(equalToConstant: 20)])
        
        // Movies Collection View Constraints
        moviesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.moviesCollectionView.leadingAnchor.constraint(equalTo: self.moviesView.leadingAnchor, constant: 18),
                                     self.moviesCollectionView.trailingAnchor.constraint(equalTo: self.moviesView.trailingAnchor),
                                     self.moviesCollectionView.topAnchor.constraint(equalTo: self.moviesView.topAnchor, constant: 20),
                                     self.moviesCollectionView.bottomAnchor.constraint(equalTo: self.moviesView.bottomAnchor)])
        
        // Divider Line Movies Constraints
        dividerLineMoviesView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.dividerLineMoviesView.leadingAnchor.constraint(equalTo: self.moviesView.leadingAnchor, constant: 18),
                                     self.dividerLineMoviesView.trailingAnchor.constraint(equalTo: self.moviesView.trailingAnchor),
                                     self.dividerLineMoviesView.topAnchor.constraint(equalTo: self.moviesView.bottomAnchor, constant: 4 ),
                                     self.dividerLineMoviesView.heightAnchor.constraint(equalToConstant: 0.5)])
    }
    
    func getMoviePoster() {
        var imageURL = ""
        imageURL = posterBaseURL + "\(movieWithDetails?.posterPath ?? "")"
        self.posterImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "placeholder.png"))
    }
    
    func checkMovieForFavorites() {
        addedToFavorite = RealmManager.shared.searchMovieForFavoritesIDInRealm(movieID: self.movieID ?? 0)
    }
    
    func fillDetailsFromMovie() {
        titleTextLable.text = movieWithDetails?.title
        overviewTextLabel.text = movieWithDetails?.overview
        releaseDateTextLabel.text = dateFormatYear(date: movieWithDetails?.releaseDate ?? "")
        numberOfGenres(genres: movieWithDetails?.genres ?? [])
        runtimeTextLabel.text = "\(movieWithDetails?.runtime ?? 0)" + " min."
        nameOfCollectionViewActorsLabel.text = "Actors:"
        nameOfCollectionViewMoviesLabel.text = "Similar movies:"
    }
     
    func numberOfGenres(genres: [Genres]) {
        if genres.count >= 2 {
            self.genresTextLabel.text = ("\(genres[0].name ?? "")" + ", " + "\(genres[1].name ?? "")")
        } else if genres.count == 1 {
            self.genresTextLabel.text = "\(genres[0].name ?? "")"
        } else {
            self.genresTextLabel.text = ""
        }
    }
    
    @objc func playButtonPressed() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let playerViewConroller = storyboard.instantiateViewController(withIdentifier: PlayerViewController.reuseIdentifire) as? PlayerViewController {
            
            playerViewConroller.arrayOfTraillers = arrayOfTraillers
            navigationController?.pushViewController(playerViewConroller, animated: true)
        }
    }
    
    @objc func addToFavoriteButtonPressed() {
        if addedToFavorite == false {
            RealmManager.shared.createAndSaveMovieForFavorites(movie: movieWithDetails)
            addedToFavorite = true
            self.addToFavoriteButton.setImage(UIImage(named: "fi-rr-heart_grey"), for: .normal)
            
        } else {
            RealmManager.shared.deleteMoviesForFavoritesFromRealmByID(movieID: movieID ?? 0)
            addedToFavorite = false
            self.addToFavoriteButton.setImage(UIImage(named: "fi-rr-add-white"), for: .normal)
        }
    }
    
    @objc func openOverviewLabel() {
        if overviewButtonPressed == false {
            self.overviewTextLabel.numberOfLines = 0
            overviewButtonPressed = true
            view.layoutIfNeeded()
        } else if overviewButtonPressed == true {
            self.overviewTextLabel.numberOfLines = 3
            overviewButtonPressed = false
            view.layoutIfNeeded()
        }
    }
    
    func alamofireMovieDetailsRequest() {
        
        AF.request("https://api.themoviedb.org/3/movie/\(movieID ?? 0)?api_key=86b8d80830ef6774289e25cad39e4fbd&language=en-EN&append_to_response=videos,images,credits").responseJSON { [self] myJSONresponse in
            
            let decoder = JSONDecoder()
            if let dataOfMovie = try? decoder.decode(MovieDetailsEN.self, from: myJSONresponse.data!) {
                self.movieWithDetails = dataOfMovie
                self.getMoviePoster()
                self.fillDetailsFromMovie()
                self.arrayOfActors = movieWithDetails?.credits?.cast ?? []
                self.actorsCollectionView.reloadData()
            }
        }
    }
    
    func alamofireSimilarMoviesRequest() {
        
        AF.request("https://api.themoviedb.org/3/movie/\(movieID ?? 0)/similar?api_key=86b8d80830ef6774289e25cad39e4fbd&language=en-US&page=1").responseJSON { [self] myJSONresponse in
            
            let decoder = JSONDecoder()
            if let dataMovies = try? decoder.decode(ResultSimilarMovies.self, from: myJSONresponse.data!) {
                
                arrayOfSimilarMovies = dataMovies.results ?? []
                self.moviesCollectionView.reloadData()
            }
        }
    }
    func alamofireVideoMaterialsRequest() {
        
        AF.request("https://api.themoviedb.org/3/movie/\(movieID ?? 0)/videos?api_key=86b8d80830ef6774289e25cad39e4fbd").responseJSON {  myJSONresponse in
            
            let decoder = JSONDecoder()
            if let videoMat = try? decoder.decode(ResultVideoMaterials.self, from: myJSONresponse.data!) {
                
                let arrayOfVideos = videoMat.results
                for item in arrayOfVideos ?? []{
                    if item.type == "Trailer" {
                        self.arrayOfTraillers.append(item.key ?? "")
                    }
                }
            }
        }
    }
}

extension MovieDetailedScrollViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == moviesCollectionView {
            return  arrayOfSimilarMovies.count
        } else {
            return arrayOfActors.count
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == moviesCollectionView {
            
            guard let movieCell = moviesCollectionView.dequeueReusableCell(withReuseIdentifier: SimilarMovieCollectionViewCell.reuseIndetifire, for: indexPath) as? SimilarMovieCollectionViewCell  else {return UICollectionViewCell()}
            movieCell.cellConfigure(similarMovie: arrayOfSimilarMovies[indexPath.row])
            return movieCell
            
        } else {
            guard let actorCell = actorsCollectionView.dequeueReusableCell(withReuseIdentifier: ActorCollectionViewCell.reuseIndetifire, for: indexPath) as? ActorCollectionViewCell  else {return UICollectionViewCell()}
            actorCell.cellConfigure(actor: arrayOfActors[indexPath.row])
            return actorCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == moviesCollectionView {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let movieDetailedScrollViewController = storyboard.instantiateViewController(withIdentifier: MovieDetailedScrollViewController.reuseIdentifire) as? MovieDetailedScrollViewController {
                
                movieDetailedScrollViewController.movieID = arrayOfSimilarMovies[indexPath.row].id
                navigationController?.pushViewController(movieDetailedScrollViewController, animated: true)
            }
            
        } else  {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let actorDetailedScrollViewController = storyboard.instantiateViewController(withIdentifier: ActorDetailedScrollViewController.reuseIdentifire) as? ActorDetailedScrollViewController {
                
                actorDetailedScrollViewController.actorID = arrayOfActors[indexPath.row].id
                navigationController?.pushViewController(actorDetailedScrollViewController, animated: true)
            }
        }
    }
}

