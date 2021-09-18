//
//  MovieDetailedScrollViewController.swift
//  Movieooze
//
//  Created by Artem Shcherban on 18.08.2021.
//

import UIKit
import SDWebImage
import RealmSwift

class MovieDetailedScrollViewController: UIViewController, UIScrollViewDelegate {
    
    static let reuseIdentifire = String(describing: MovieDetailedScrollViewController.self)
    
    var movieDetailedViewModel: MovieDetailedViewModel!
    var similarMoviesCollectionViewModel: SimilarMoviesCollectionViewModel!
    var actorsCollectionViewModel: ActorsCollectionViewModel!
    var videoPlayerViewModel: VideoPlayerViewModel!
    var scrollView: UIScrollView!
    var label: UILabel!
    var headerContainerView: UIView!
    var posterImageView: UIImageView!
    var gradientView: UIView!
    var mainContainerView: UIView!
    var titleTextLable, overviewTextLabel, releaseDateTextLabel, genresTextLabel, runtimeTextLabel, countryTextLabel: UILabel!
    var arrayOfTextLabels: [UILabel] = []
    var overviewClearButton, playButton: UIButton!
    var addToFavoriteButton: UIBarButtonItem!
    var overviewButtonPressed = false
    var movieID: Int!
    var movieWithDetails: MovieDetailsEN? = nil
    var actorsView, moviesView: UIView!
    var nameOfCollectionViewActorsLabel, nameOfCollectionViewMoviesLabel: UILabel!
    var actorsCollectionView, moviesCollectionView: UICollectionView!
    var layoutActors, layoutMovies: UICollectionViewFlowLayout!
    var dividerTopLineActorView, dividerLineActorsView, dividerLineMoviesView: UIView!
    var arrayOfDividerLines: [UIView] = []
    var logoImageView: UIImageView!
    var logoAspectRatio = 0.0
    var addedToFavorite: Bool!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieDetailedViewModel = MovieDetailedViewModel()
        similarMoviesCollectionViewModel = SimilarMoviesCollectionViewModel()
        actorsCollectionViewModel = ActorsCollectionViewModel()
        videoPlayerViewModel = VideoPlayerViewModel()
        
        movieDetailedViewModel.movieDetailsRequest(movieID: movieID, completion: {
            self.movieDetailedViewModel.getProductionCompany(completion: {
            
            self.fillDetailsFromMovie()
            self.setTitleForBackButton()
            self.setLogoConstraints(aspectRatio: self.movieDetailedViewModel.logoAspectRatio)
            self.actorsCollectionViewModel.getArrayOfActors(movieDetailedViewModel: self.movieDetailedViewModel)
            self.actorsCollectionView.reloadData()
            })
        })
        
        similarMoviesCollectionViewModel.similarMovieRequest(movieID: movieID, completion: {
            self.moviesCollectionView.reloadData()
        })

        videoPlayerViewModel.videoMaterialsRequest(movieID: movieID, completion: {})
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
                
        // Release Date Label, Genre Label, Run Time Text Label, Country Text Label Customization
        for textLabel in arrayOfTextLabels {
            textLabel.backgroundColor = .clear
            textLabel.font = UIFont.systemFont(ofSize: 13, weight: .thin)
            textLabel.textColor = .white
        }
        
        // Actors View Customization
        self.actorsView.backgroundColor = .clear
        
        // Name Of Collection View Actors Customization
        self.nameOfCollectionViewActorsLabel.backgroundColor = .clear
        self.nameOfCollectionViewActorsLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        self.nameOfCollectionViewActorsLabel.textColor = Constants.MyColors.myLightGreyColor
        
        // Name Of Collection View Movies
        self.nameOfCollectionViewMoviesLabel.backgroundColor = .clear
        self.nameOfCollectionViewMoviesLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        self.nameOfCollectionViewMoviesLabel.textColor = Constants.MyColors.myLightGreyColor
        
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
            self.addToFavoriteButton.image = UIImage(named: "fi-rr-add-white")
            self.addToFavoriteButton.tintColor = .white
        } else {
            self.addToFavoriteButton.image = UIImage(named: "fi-rr-heart")
            self.addToFavoriteButton.tintColor = .orange
        }
    }

    func createViews() {

        // Scroll View
        scrollView = UIScrollView()
        scrollView.backgroundColor = Constants.MyColors.myDarkGreyColor
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
                           Constants.MyColors.myDarkGreyColor.cgColor]
        newLayer.endPoint = CGPoint(x: 0.5, y: 0.47)
        newLayer.frame = self.view.frame
        self.gradientView.layer.addSublayer(newLayer)
        self.scrollView.addSubview(gradientView)
        
        
        // Play Button
        playButton = UIButton()
        playButton.backgroundColor = .clear
        playButton.setImage(UIImage(named: "fi-rr-play-alt_orange"), for: .normal)
        playButton.addTarget(self, action: #selector(playButtonPressed), for: .touchUpInside)
        self.scrollView.addSubview(playButton)
        
        // Logo Image View
        logoImageView = UIImageView()
        logoImageView.clipsToBounds = true
        logoImageView.backgroundColor = .clear
        logoImageView.contentMode = .scaleAspectFit
        self.scrollView.addSubview(logoImageView)
        
        // Title Text Lable
        titleTextLable = UILabel()
        titleTextLable.numberOfLines = 0
        titleTextLable.baselineAdjustment = .alignBaselines
        self.scrollView.addSubview(titleTextLable)
        
        // Add To Favorite Button
        addToFavoriteButton = UIBarButtonItem()
        addToFavoriteButton.style = .done
        addToFavoriteButton.target = self
        addToFavoriteButton.action = #selector(addToFavoriteButtonPressed)
        self.navigationItem.rightBarButtonItem = addToFavoriteButton

        // Release Date Label, Genre Label, Run Time Text Label, Country Text Label
        releaseDateTextLabel = UILabel(); genresTextLabel = UILabel(); runtimeTextLabel = UILabel(); countryTextLabel = UILabel()
        arrayOfTextLabels = [releaseDateTextLabel, genresTextLabel, runtimeTextLabel, countryTextLabel]
        for textLabel in arrayOfTextLabels {
            textLabel.numberOfLines = 1
            textLabel.baselineAdjustment = .alignBaselines
            self.scrollView.addSubview(textLabel)
        }
        
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
        
        // Divider Top Line Actors View, Divider Line Actors View, Divider Line Movies View
        dividerTopLineActorView = UIView(); dividerLineActorsView = UIView(); dividerLineMoviesView = UIView()
        arrayOfDividerLines = [dividerTopLineActorView, dividerLineActorsView, dividerLineMoviesView]
        for dividerLine in arrayOfDividerLines {
        dividerLine.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        self.actorsView.addSubview(dividerLine)
        }
        
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
        
        // Play Button Constraints
        self.playButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.playButton.topAnchor.constraint(equalTo: self.titleTextLable.bottomAnchor, constant: 4),
                                     self.playButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
                                     self.playButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 40),
                                     self.playButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 40)])
        
        // Release Date Text Label Constraints
        self.releaseDateTextLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.releaseDateTextLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
                                     self.releaseDateTextLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 33),
                                     self.releaseDateTextLabel.topAnchor.constraint(equalTo: self.playButton.bottomAnchor, constant: 8)])
        
        // Genre Date Text Label Constraints
        self.genresTextLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.genresTextLabel.leadingAnchor.constraint(equalTo: self.releaseDateTextLabel.trailingAnchor, constant: 4),
                                     self.genresTextLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 150),
                                     self.genresTextLabel.topAnchor.constraint(equalTo: self.playButton.bottomAnchor, constant: 8)])
        
        // Run Time Text Label Constraints
        self.runtimeTextLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.runtimeTextLabel.leadingAnchor.constraint(equalTo: self.genresTextLabel.trailingAnchor, constant: 4),
                                     self.runtimeTextLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 55),
                                     self.runtimeTextLabel.topAnchor.constraint(equalTo: self.playButton.bottomAnchor, constant: 8)])
        
        // Country Text Label Constraints
        self.countryTextLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.countryTextLabel.leadingAnchor.constraint(equalTo: self.runtimeTextLabel.trailingAnchor, constant: 4),
                                     self.countryTextLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 120),
                                     self.countryTextLabel.topAnchor.constraint(equalTo: self.playButton.bottomAnchor, constant: 8)])
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
        // Logo Image View Constraints
    func setLogoConstraints(aspectRatio: Float) {
        self.logoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.logoImageView.bottomAnchor.constraint(equalTo: self.playButton.bottomAnchor),
                                     self.logoImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
                                     self.logoImageView.widthAnchor.constraint(equalToConstant: 75),
                                     self.logoImageView.heightAnchor.constraint(equalTo: self.logoImageView.widthAnchor, multiplier: CGFloat(aspectRatio))])
    }

    
    func getMoviePoster() {
        var imageURL = ""
        imageURL = Constants.Network.posterBaseURL + "\(movieDetailedViewModel.posterPath)"
        self.posterImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "placeholder.png"))
    }
    
    func checkMovieForFavorites() {
        addedToFavorite = RealmManager.shared.searchMovieForFavoritesIDInRealm(movieID: self.movieID ?? 0)
    }
    
    func fillDetailsFromMovie() {
        self.titleTextLable.text = movieDetailedViewModel.title
        self.overviewTextLabel.text = movieDetailedViewModel.overview
        self.releaseDateTextLabel.text = movieDetailedViewModel.releaseDate
        self.genresTextLabel.text = movieDetailedViewModel.genres
        self.runtimeTextLabel.text = movieDetailedViewModel.runtime
        self.countryTextLabel.text = movieDetailedViewModel.productionCountries
        self.logoImageView.sd_setImage(with: URL(string: movieDetailedViewModel.productionCompanyLogoURL), placeholderImage: UIImage(named: "placeholder.png"))
        self.getMoviePoster()
        nameOfCollectionViewActorsLabel.text = "Actors:"
        nameOfCollectionViewMoviesLabel.text = "Similar movies:"
    }

    @objc func playButtonPressed() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let playerViewConroller = storyboard.instantiateViewController(withIdentifier: PlayerViewController.reuseIdentifire) as? PlayerViewController {
            
            playerViewConroller.videoPlayerViewModel = self.videoPlayerViewModel
            navigationController?.pushViewController(playerViewConroller, animated: true)
        }
    }

    @objc func addToFavoriteButtonPressed() {
        if addedToFavorite == false {
            RealmManager.shared.createAndSaveMovieForFavorites(movie: movieDetailedViewModel.movieWithDetailsNew)
            addedToFavorite = true
            self.addToFavoriteButton.image = UIImage(named: "fi-rr-heart")
            self.addToFavoriteButton.tintColor = .orange
        } else {
            RealmManager.shared.deleteMoviesForFavoritesFromRealmByID(movieID: movieID ?? 0)
            addedToFavorite = false
            self.addToFavoriteButton.image = UIImage(named: "fi-rr-add-white")
            self.addToFavoriteButton.tintColor = .white
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
    
    func setTitleForBackButton() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: self.movieDetailedViewModel.title[0..<25] , style: .plain, target: self, action: nil)
    }
    

}

extension MovieDetailedScrollViewController: UICollectionViewDataSource, UICollectionViewDelegate {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == moviesCollectionView {
            return  similarMoviesCollectionViewModel.numberOfRows()
        } else {
            return self.actorsCollectionViewModel.numberOfRows()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == moviesCollectionView {
            
            guard let movieCell = moviesCollectionView.dequeueReusableCell(withReuseIdentifier: SimilarMovieCollectionViewCell.reuseIndetifire, for: indexPath) as? SimilarMovieCollectionViewCell  else {return UICollectionViewCell()}
            let cellViewModel = similarMoviesCollectionViewModel.createCellViewModel(indexPath: indexPath)
            movieCell.cellConfigure(cellViewModel: cellViewModel)
            return movieCell
            
        } else {
            guard let actorCell = actorsCollectionView.dequeueReusableCell(withReuseIdentifier: ActorCollectionViewCell.reuseIndetifire, for: indexPath) as? ActorCollectionViewCell  else {return UICollectionViewCell()}
            let cellViewModel = actorsCollectionViewModel.createCellViewModel(indexPath: indexPath)
            actorCell.cellConfigure(cellViewModel: cellViewModel)
            return actorCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == moviesCollectionView {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let movieDetailedScrollViewController = storyboard.instantiateViewController(withIdentifier: MovieDetailedScrollViewController.reuseIdentifire) as? MovieDetailedScrollViewController {
                
                movieDetailedScrollViewController.movieID = similarMoviesCollectionViewModel.arrayOfSimilarMovies[indexPath.row].id
                navigationController?.pushViewController(movieDetailedScrollViewController, animated: true)
            }
            
        } else  {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let actorDetailedScrollViewController = storyboard.instantiateViewController(withIdentifier: ActorDetailedScrollViewController.reuseIdentifire) as? ActorDetailedScrollViewController {
                
                actorDetailedScrollViewController.actorID = self.actorsCollectionViewModel.arrayOfActors[indexPath.row].id
                navigationController?.pushViewController(actorDetailedScrollViewController, animated: true)
            }
        }
    }
}

