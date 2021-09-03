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
    var titleTextLable, overviewTextLabel, releaseDateTextLabel, genresTextLabel: UILabel!
    var addToFavoriteButton, overviewClearButton, playButton: UIButton!
    var overviewButtonPressed = false
    var movie: Movie? = nil
    var actorsView, moviesView: UIView!
    var nameOfCollectionViewActorsLabel, nameOfCollectionViewMoviesLabel: UILabel!
    var actorsCollectionView, moviesCollectionView: UICollectionView!
    var layoutActors, layoutMovies: UICollectionViewFlowLayout!
    var arrayOfActors: [Cast] = []
    var dividerLineActorsView, dividerLineMoviesView: UIView!
    var arrayOfSimilarMovies: [SimilarMovie] = []
    
  
  

    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alamofireMovieDetailsRequest()
        alamofireSimilarMoviesRequest()
        createViews()
//        createMovies()
//        createActors()
        setViewConstraints()
        getMoviePoster()
        checkMovieForFavorites()
        fillDetailsFromMovie()


        
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
        
        // Label Customization
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .white
        label.text = ""
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
        
        // Name Of Collection View Movies
        nameOfCollectionViewMoviesLabel = UILabel()
        nameOfCollectionViewMoviesLabel.numberOfLines = 1
        nameOfCollectionViewMoviesLabel.baselineAdjustment = .alignBaselines
        self.actorsView.addSubview(nameOfCollectionViewMoviesLabel)
        
        // Movies View
        self.moviesView = UIView()
        self.scrollView.addSubview(moviesView)
        
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
//    func createMovies() {
//        // Layout Movies
//        let layoutMovies = UICollectionViewFlowLayout()
//        layoutMovies.sectionInset = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
//        layoutMovies.itemSize = CGSize(width: 80, height: 170)
//        layoutMovies.scrollDirection = UICollectionView.ScrollDirection.horizontal
//        self.moviesCollectionView = UICollectionView(frame: self.moviesView.frame, collectionViewLayout: layoutMovies)
//        self.moviesCollectionView.dataSource = self
//        self.moviesCollectionView.delegate = self
//        self.moviesCollectionView.register(SimilarMovieCollectionViewCell.self, forCellWithReuseIdentifier: SimilarMovieCollectionViewCell.reuseIndetifire)
//        self.moviesCollectionView.backgroundColor = .red
//        self.moviesView.addSubview(moviesCollectionView)
//    }
//    func createActors(){
//
//        let layoutActors = UICollectionViewFlowLayout()
//        layoutActors.sectionInset = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
//        layoutActors.itemSize = CGSize(width: 80, height: 170)
//        layoutActors.scrollDirection = UICollectionView.ScrollDirection.horizontal
//        self.actorsCollectionView = UICollectionView(frame: self.moviesView.frame, collectionViewLayout: layoutActors)
//        self.actorsCollectionView.dataSource = self
//        self.actorsCollectionView.delegate = self
//        self.actorsCollectionView.register(ActorCollectionViewCell.self, forCellWithReuseIdentifier: ActorCollectionViewCell.reuseIndetifire)
//        self.actorsCollectionView.backgroundColor = .clear
//        self.actorsView.addSubview(actorsCollectionView)
//    }
    
    
    func setViewConstraints() {
        
//       //  Label Constraints
//        self.label.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            self.label.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
//            self.label.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
//            self.label.bottomAnchor.constraint(equalTo: self.gradientView.bottomAnchor, constant: -10),
//            self.label.topAnchor.constraint(equalTo: self.moviesView.bottomAnchor, constant: 20)
//        ])
        
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
                                     self.actorsView.heightAnchor.constraint(equalToConstant: 180)])
        
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
                                     self.actorsCollectionView.topAnchor.constraint(equalTo: self.actorsView.topAnchor, constant: 20),
                                     self.actorsCollectionView.bottomAnchor.constraint(equalTo: self.actorsView.bottomAnchor)])
        
        
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
        
        // Divider Line Actors Constraints
        dividerLineMoviesView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.dividerLineMoviesView.leadingAnchor.constraint(equalTo: self.moviesView.leadingAnchor, constant: 18),
                                     self.dividerLineMoviesView.trailingAnchor.constraint(equalTo: self.moviesView.trailingAnchor),
                                     self.dividerLineMoviesView.topAnchor.constraint(equalTo: self.moviesView.bottomAnchor, constant: 2 ),
                                     self.dividerLineMoviesView.heightAnchor.constraint(equalToConstant: 0.5)])
        
    }
    
    func getMoviePoster() {
        var imageURL = ""
        imageURL = posterBaseURL + "\(movie?.posterPath ?? "")"
        self.posterImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "placeholder.png"))
    }
    
    func checkMovieForFavorites() {
        addedToFavorite = RealmManager.shared.searchMovieForFavoritesIDInRealm(movieID: self.movie?.id ?? 0)
    }
    
    func fillDetailsFromMovie() {
        titleTextLable.text = movie?.title
        overviewTextLabel.text = movie?.overview
        releaseDateTextLabel.text = dateFormat(date: movie?.releaseDate ?? "")
        numberOfGenres(genreIds: movie?.genreIds ?? [])
        nameOfCollectionViewActorsLabel.text = "Actors:"
        nameOfCollectionViewMoviesLabel.text = "Similar movies:"
    }
    
    func numberOfGenres(genreIds: [Int]) {
        if genreIds.count >= 2 {
            self.genresTextLabel.text = ("\(dicGenres[genreIds[0]]?.name ?? "")" + ", " + "\(dicGenres[genreIds[1]]?.name ?? "")")
        } else {
            self.genresTextLabel.text = "\(dicGenres[genreIds[0]]?.name ?? "")"
        }
    }
    
    @objc func playButtonPressed() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let playerViewConroller = storyboard.instantiateViewController(withIdentifier: PlayerViewController.reuseIdentifire) as? PlayerViewController {
            navigationController?.pushViewController(playerViewConroller, animated: true)
        }
        
    }
    
  
    @objc func addToFavoriteButtonPressed() {
        if addedToFavorite == false {
            RealmManager.shared.createAndSaveMovieForFavorites(movie: movie)
            addedToFavorite = true
            self.addToFavoriteButton.setImage(UIImage(named: "fi-rr-heart_grey"), for: .normal)
            
            //   🧐 убрать print
            //             print(movieTitle, addedToFavorite)
            //             print(RealmManager.shared.readFromRealmMovieForFavorites())
            //                     print(RealmManager.shared.readFromRealmMovieForFavorites().count)
            print(RealmManager.shared.readFromRealmMovieForFavorites())
            print(RealmManager.shared.readFromRealmMovieForFavorites().count)
        } else {
            RealmManager.shared.deleteMoviesForFavoritesFromRealmByID(movieID: movie?.id ?? 0)
            addedToFavorite = false
            self.addToFavoriteButton.setImage(UIImage(named: "fi-rr-add-white"), for: .normal)
            
            //   🧐 убрать print
            print(RealmManager.shared.readFromRealmMovieForFavorites())
            print(RealmManager.shared.readFromRealmMovieForFavorites().count)
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
        
        AF.request("https://api.themoviedb.org/3/movie/\(movie?.id ?? 0)?api_key=86b8d80830ef6774289e25cad39e4fbd&language=en-EN&append_to_response=videos,images,credits").responseJSON { [self] myJSONresponse in
            
            let decoder = JSONDecoder()
            if let dataMovies = try? decoder.decode(MoviesDetailsEN.self, from: myJSONresponse.data!) {
                self.titleTextLable.text = dataMovies.title
                
            }
            if let dataCredits = try? decoder.decode(MoviesDetailsEN.self, from: myJSONresponse.data!) {
                self.arrayOfActors = dataCredits.credits?.cast ?? []
          
                              self.actorsCollectionView.reloadData()
            }
        }
    }
    
    func alamofireSimilarMoviesRequest() {
        
        AF.request("https://api.themoviedb.org/3/movie/\(movie?.id ?? 0)/similar?api_key=86b8d80830ef6774289e25cad39e4fbd&language=en-US&page=1").responseJSON { [self] myJSONresponse in
            
            let decoder = JSONDecoder()
            if let dataMovies = try? decoder.decode(ResultSimilarMovies.self, from: myJSONresponse.data!) {
                
                arrayOfSimilarMovies = dataMovies.results ?? []
                self.moviesCollectionView.reloadData()
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
            movieCell.backgroundColor = .blue
            movieCell.cellConfigure(similarMovie: arrayOfSimilarMovies[indexPath.row])
              return movieCell
            
        } else {
            guard let actorCell = actorsCollectionView.dequeueReusableCell(withReuseIdentifier: ActorCollectionViewCell.reuseIndetifire, for: indexPath) as? ActorCollectionViewCell  else {return UICollectionViewCell()}
            actorCell.cellConfigure(actor: arrayOfActors[indexPath.row])
            return actorCell
        }
    }
    
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
// 🧐 Удалить print
        print("User tapped on item \(indexPath.row)")
     print(arrayOfActors[indexPath.row].id ?? "")
//        print(movie?.id)

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let testViewController = storyboard.instantiateViewController(withIdentifier: "TestViewController") as? TestViewController {
            navigationController?.pushViewController(testViewController, animated: true)
        }
    }
}


