//
//  TvShowDetailedScrollViewController.swift
//  Movieooze
//
//  Created by Artem Shcherban on 24.09.2021.
//

import UIKit
import SDWebImage

class TvShowDetailedScrollViewController: UIViewController, UIScrollViewDelegate {
    
    static let reuseIdentifire = String(describing: TvShowDetailedScrollViewController.self)
    
    var tvShowViewModel: TVShowViewModel!
    var videoPlayerViewModel: VideoPlayerViewModel!
    var actorsCollectionViewModel: ActorsCollectionViewModel!
    var seasonsCollectionViewModel: SeasonsCollectionViewModel!
    
    var scrollView: UIScrollView!
    var headerContainerView: UIView!
    var posterImageView, titleImageView: UIImageView!
    var gradientView: UIView!
    var mainContainerView: UIView!
    var titleTextLable, releaseDateTextLabel, genresTextLabel, runtimeTextLabel, overviewTextLabel, countryTextLabel: UILabel!
    var starsImageView: UIImageView!
    var arrayOfTextLabels: [UILabel] = []
    var overviewClearButton, playButton: UIButton!
    var overviewButtonPressed = false
    var addToFavoriteButton: UIBarButtonItem!
    var tvShowID: Int!
    var actorsView: UIView!
    var seasonsView: UIView!
    var nameOfCollectionViewActorsLabel, nameOfCollectionViewSeasonsLabel: UILabel!
    var actorsCollectionView, seasonsCollectionView: UICollectionView!
    var layoutActors, layoutSeasons: UICollectionViewFlowLayout!
    var dividerTopLineActorView, dividerTopLineSeasonsView, dividerBottomLineSeasonsView: UIView!
    var arrayOfDividerLines: [UIView] = []
    var logoImageView: UIImageView!
    var logoAspectRatio = 0.0
    var addedToFavorite: Bool!
    
    
    var episodesTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tvShowViewModel = TVShowViewModel()
        actorsCollectionViewModel = ActorsCollectionViewModel()
        seasonsCollectionViewModel = SeasonsCollectionViewModel()
        videoPlayerViewModel = VideoPlayerViewModel()
        tvShowViewModel.tvShowDetailsRequest(tvShowID: tvShowID, completion: {
            self.tvShowViewModel.getProductionCompany(completion: {
            self.fillDetailsOfTVShow()
            self.setTitleForBackButton()
            self.setLogoConstraints(aspectRatio: self.tvShowViewModel.logoAspectRatio)
            self.actorsCollectionViewModel.getArrayOfTVShowActors(tvShowViewModel: self.tvShowViewModel)
            self.seasonsCollectionViewModel.getArrayOFSeasons(tvShowViewModel: self.tvShowViewModel)
            self.actorsCollectionView.reloadData()
            self.seasonsCollectionView.reloadData()
            self.videoPlayerViewModel.tvShowVideoMaterialsRequest(tvShowID: self.tvShowID, completion: {})
            //🧐 убрать print
            print(self.tvShowViewModel.name)
            
            })
        })
        createViews()
        setViewsConstraints()
        checkTVShowForFavorites()
        
        
        
        // Title Text Lable Customization
        self.titleTextLable.backgroundColor = .clear
        self.titleTextLable.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        self.titleTextLable.textColor = .white
        
        //  Release Date Text Label, Genre Label Customization, Run Time Text Label, Country Text Label
        for textLabel in arrayOfTextLabels {
            textLabel.backgroundColor = .clear
            textLabel.font = UIFont.systemFont(ofSize: 13, weight: .thin)
            textLabel.textColor = .white
        }
        
        // OverView Text Label Customization
        self.overviewTextLabel.backgroundColor = .clear
        self.overviewTextLabel.font = UIFont.systemFont(ofSize: 15)
        self.overviewTextLabel.textColor = .white
        
        // Actors View Customization
        self.actorsView.backgroundColor = .clear
        
        // Name Of Collection View Actors Customization
        self.nameOfCollectionViewActorsLabel.backgroundColor = .clear
        self.nameOfCollectionViewActorsLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        self.nameOfCollectionViewActorsLabel.textColor = Constants.MyColors.myLightGreyColor
        
        // Name Of Collection View Seasons
        self.nameOfCollectionViewSeasonsLabel.backgroundColor = .clear
        self.nameOfCollectionViewSeasonsLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        self.nameOfCollectionViewSeasonsLabel.textColor = Constants.MyColors.myLightGreyColor
        
        // TV Show Seasons View Customization
        self.seasonsView.backgroundColor = .clear
        
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
        // Create Scroll View
        scrollView = UIScrollView()
        scrollView.backgroundColor = Constants.MyColors.myDarkGreyColor
        scrollView.delegate = self
        self.view.addSubview(scrollView)
        
        // Create Main Container View
        mainContainerView = UIView()
        mainContainerView.backgroundColor = .clear
        self.scrollView.addSubview(mainContainerView)
        
        // Create Head Container View
        headerContainerView = UIView()
        headerContainerView.backgroundColor = .red
        self.scrollView.addSubview(headerContainerView)
        
        // Poster Image View
        posterImageView = UIImageView()
        posterImageView.clipsToBounds = true
        posterImageView.backgroundColor = .black
        posterImageView.contentMode = .scaleAspectFill
        //        posterImageView.image = UIImage(named: "gFZriCkpJYsApPZEF3jhxL4yLzG")
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
        
        // Title Text Lable
        titleTextLable = UILabel()
        titleTextLable.numberOfLines = 0
        titleTextLable.baselineAdjustment = .alignBaselines
        self.scrollView.addSubview(titleTextLable)
        
        // Play Button
        playButton = UIButton()
        playButton.backgroundColor = .clear
        playButton.setImage(UIImage(named: "fi-rr-play-alt_orange"), for: .normal)
        playButton.addTarget(self, action: #selector(playButtonPressed), for: .touchUpInside)
        self.scrollView.addSubview(playButton)
        
        // Stars Level Image View
        starsImageView = UIImageView()
        starsImageView.backgroundColor = .clear
        starsImageView.clipsToBounds = true
        starsImageView.contentMode = .left
        self.scrollView.addSubview(starsImageView)
        
        // Logo Image View
        logoImageView = UIImageView()
        logoImageView.clipsToBounds = true
        logoImageView.backgroundColor = .clear
        logoImageView.contentMode = .scaleAspectFit
        self.scrollView.addSubview(logoImageView)
        
        // Add To Favorite Button
        addToFavoriteButton = UIBarButtonItem()
        addToFavoriteButton.style = .done
        addToFavoriteButton.target = self
        addToFavoriteButton.action = #selector(addToFavoriteButtonPressed)
        self.navigationItem.rightBarButtonItem = addToFavoriteButton
        
        //  Release Date Text Label, Genre Label
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
        
        // TV Show Seasons View
        self.seasonsView = UIView()
        self.scrollView.addSubview(seasonsView)
        
        // Name Of Collection View Seasons
        nameOfCollectionViewSeasonsLabel = UILabel()
        nameOfCollectionViewSeasonsLabel.numberOfLines = 1
        nameOfCollectionViewSeasonsLabel.baselineAdjustment = .alignBaselines
        self.seasonsView.addSubview(nameOfCollectionViewSeasonsLabel)
        
        // Layout Actors
        self.layoutActors = UICollectionViewFlowLayout()
        self.layoutActors.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 4)
        self.layoutActors.itemSize = CGSize(width: 80, height: 150)
        self.layoutActors.scrollDirection = UICollectionView.ScrollDirection.horizontal
        
        // Layout Seasons
        self.layoutSeasons = UICollectionViewFlowLayout()
        self.layoutSeasons.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 4)
        self.layoutSeasons.itemSize = CGSize(width: 80, height: 150)
        self.layoutSeasons.scrollDirection = UICollectionView.ScrollDirection.horizontal
        
        // Actors Collection View
        self.actorsCollectionView = UICollectionView(frame: self.actorsView.frame, collectionViewLayout: layoutActors)
        self.actorsCollectionView.dataSource = self
        self.actorsCollectionView.delegate = self
        self.actorsCollectionView.register(ActorCollectionViewCell.self, forCellWithReuseIdentifier: ActorCollectionViewCell.reuseIndetifire)
        self.actorsCollectionView.backgroundColor = .clear
        self.actorsView.addSubview(actorsCollectionView)
        
        // Divider Top Line Actors View
        dividerTopLineActorView = UIView()
        dividerTopLineActorView.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        self.actorsView.addSubview(dividerTopLineActorView)
        
        // Seasons Collection View
        self.seasonsCollectionView = UICollectionView(frame: self.seasonsView.frame, collectionViewLayout: layoutSeasons)
        self.seasonsCollectionView.dataSource = self
        self.seasonsCollectionView.delegate = self
        self.seasonsCollectionView.register(SeasonCollectionViewCell.self, forCellWithReuseIdentifier: SeasonCollectionViewCell.reuseIndetifire)
        self.seasonsCollectionView.backgroundColor = .clear
        self.seasonsView.addSubview(seasonsCollectionView)
        
        // Divider Top Line Season View, Divider Bottom Line Seasons
        dividerTopLineSeasonsView = UIView(); dividerBottomLineSeasonsView = UIView()
        arrayOfDividerLines = [dividerTopLineSeasonsView, dividerBottomLineSeasonsView]
        for dividerLine in arrayOfDividerLines {
            dividerLine.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
            self.seasonsView.addSubview(dividerLine)
        }
    }
    
    
    func setViewsConstraints() {
        // Scroll View Constrainrs
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
                                     self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                                     self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                                     self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)])
        
        // Main Container View Constrainrs
        mainContainerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.mainContainerView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 500),
                                     self.mainContainerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                                     self.mainContainerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                                     self.mainContainerView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor)])
        
        // Head Container View Constrainrs
        let headerContainerViewBottomConstraint: NSLayoutConstraint!
        headerContainerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.headerContainerView.topAnchor.constraint(equalTo: self.view.topAnchor), self.headerContainerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                                     self.headerContainerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)])
        headerContainerViewBottomConstraint = self.headerContainerView.bottomAnchor.constraint(equalTo: self.mainContainerView.topAnchor, constant: -10)
        headerContainerViewBottomConstraint.priority = UILayoutPriority(rawValue: 900)
        headerContainerViewBottomConstraint.isActive = true
        
        // Poster Image View Constrainrs
        let posterImageViewTopConstraint: NSLayoutConstraint!
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.posterImageView.leadingAnchor.constraint(equalTo: self.headerContainerView.leadingAnchor),
                                     self.posterImageView.trailingAnchor.constraint(equalTo: self.headerContainerView.trailingAnchor),
                                     self.posterImageView.bottomAnchor.constraint(equalTo: self.headerContainerView.bottomAnchor)])
        posterImageViewTopConstraint = self.posterImageView.topAnchor.constraint(equalTo: self.view.topAnchor)
        posterImageViewTopConstraint.priority = UILayoutPriority(rawValue: 900)
        posterImageViewTopConstraint.isActive = true
        
        // Gradient View Constraints
        gradientView.translatesAutoresizingMaskIntoConstraints =  false
        NSLayoutConstraint.activate([self.gradientView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
                                     self.gradientView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                                     self.gradientView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                                     self.gradientView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor)])
        
        // Title Text Lable Constraints
        self.titleTextLable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.titleTextLable.bottomAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 320),
                                     self.titleTextLable.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 12),
                                     self.titleTextLable.widthAnchor.constraint(equalToConstant: 250)])
        
        // Play Button Constraints
        self.playButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.playButton.topAnchor.constraint(equalTo: self.titleTextLable.bottomAnchor, constant: 4),
                                     self.playButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 12),
                                     self.playButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 40),
                                     self.playButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 40)])
        
        // Stars Level Image View Constraints
        self.starsImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.starsImageView.leadingAnchor.constraint(equalTo: self.playButton.trailingAnchor, constant: 20), self.starsImageView.widthAnchor.constraint(lessThanOrEqualToConstant: 122), self.starsImageView.heightAnchor.constraint(equalToConstant: 25), self.starsImageView.bottomAnchor.constraint(equalTo: self.playButton.bottomAnchor)])
        
        // Release Date Text Label Constraints
        self.releaseDateTextLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.releaseDateTextLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 12),
                                     self.releaseDateTextLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 33),
                                     self.releaseDateTextLabel.topAnchor.constraint(equalTo: self.playButton.bottomAnchor, constant: 8)])
        
        // Genre Text Label Constraints
        self.genresTextLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.genresTextLabel.leadingAnchor.constraint(equalTo: self.releaseDateTextLabel.trailingAnchor, constant: 4),
                                     self.genresTextLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 180),
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
        
        // Overview Text Label Constraints
        overviewTextLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.overviewTextLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 12),
                                     self.overviewTextLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -12),
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
                                     self.actorsView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -12),
                                     self.actorsView.topAnchor.constraint(equalTo: self.overviewTextLabel.bottomAnchor, constant: 4 ),
                                     self.actorsView.heightAnchor.constraint(equalToConstant: 180)])
        
        // Divider Top Line Actors Constraints
        dividerTopLineActorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.dividerTopLineActorView.leadingAnchor.constraint(equalTo: self.actorsView.leadingAnchor, constant: 12),
                                     self.dividerTopLineActorView.trailingAnchor.constraint(equalTo: self.actorsView.trailingAnchor),
                                     self.dividerTopLineActorView.topAnchor.constraint(equalTo: self.actorsView.topAnchor, constant: 4 ),
                                     self.dividerTopLineActorView.heightAnchor.constraint(equalToConstant: 0.5)])
        
        // Name Of Collection View Actors Constraints
        nameOfCollectionViewActorsLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.nameOfCollectionViewActorsLabel.leadingAnchor.constraint(equalTo: self.actorsView.leadingAnchor, constant: 12),
                                     self.nameOfCollectionViewActorsLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -12),
                                     self.nameOfCollectionViewActorsLabel.bottomAnchor.constraint(equalTo: self.actorsCollectionView.topAnchor, constant: -4),
                                     self.nameOfCollectionViewActorsLabel.heightAnchor.constraint(equalToConstant: 20)])
        
        // Actors Collection View Constraints
        actorsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.actorsCollectionView.leadingAnchor.constraint(equalTo: self.actorsView.leadingAnchor, constant: 12),
                                     self.actorsCollectionView.trailingAnchor.constraint(equalTo: self.actorsView.trailingAnchor),
                                     self.actorsCollectionView.topAnchor.constraint(equalTo: self.actorsView.topAnchor, constant: 30),
                                     self.actorsCollectionView.bottomAnchor.constraint(equalTo: self.actorsView.bottomAnchor)])
        
        // Seasons View Constraints
        seasonsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.seasonsView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                                     self.seasonsView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -12),
                                     self.seasonsView.topAnchor.constraint(equalTo: self.actorsView.bottomAnchor),
                                     self.seasonsView.heightAnchor.constraint(equalToConstant: 180),
                                     self.seasonsView.bottomAnchor.constraint(equalTo: self.gradientView.bottomAnchor, constant: -10 )])
        
        // Divider Top Line Seasons Constraints
        dividerTopLineSeasonsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.dividerTopLineSeasonsView.leadingAnchor.constraint(equalTo: self.actorsView.leadingAnchor, constant: 12),
                                     self.dividerTopLineSeasonsView.trailingAnchor.constraint(equalTo: self.actorsView.trailingAnchor),
                                     self.dividerTopLineSeasonsView.topAnchor.constraint(equalTo: self.seasonsView.topAnchor, constant: 4),
                                     self.dividerTopLineSeasonsView.heightAnchor.constraint(equalToConstant: 0.5)])
        
        // Name Of Collection View Seasons Constraints
        nameOfCollectionViewSeasonsLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.nameOfCollectionViewSeasonsLabel.leadingAnchor.constraint(equalTo: self.seasonsView.leadingAnchor, constant: 12),
                                     self.nameOfCollectionViewSeasonsLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -12),
                                     self.nameOfCollectionViewSeasonsLabel.bottomAnchor.constraint(equalTo: self.seasonsCollectionView.topAnchor, constant: -4),
                                     self.nameOfCollectionViewSeasonsLabel.heightAnchor.constraint(equalToConstant: 20)])
        
        // Seasons Collection View Constraints
        seasonsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.seasonsCollectionView.leadingAnchor.constraint(equalTo: self.seasonsView.leadingAnchor, constant: 12),
                                     self.seasonsCollectionView.trailingAnchor.constraint(equalTo: self.seasonsView.trailingAnchor),
                                     self.seasonsCollectionView.topAnchor.constraint(equalTo: self.seasonsView.topAnchor, constant: 30),
                                     self.seasonsCollectionView.bottomAnchor.constraint(equalTo: self.seasonsView.bottomAnchor)])
        
        // Divider Bottom Line Seasons Constraints
        dividerBottomLineSeasonsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.dividerBottomLineSeasonsView.leadingAnchor.constraint(equalTo: self.seasonsView.leadingAnchor, constant: 12),
                                     self.dividerBottomLineSeasonsView.trailingAnchor.constraint(equalTo: self.seasonsView.trailingAnchor),
                                     self.dividerBottomLineSeasonsView.topAnchor.constraint(equalTo: self.seasonsView.bottomAnchor, constant: 4),
                                     self.dividerBottomLineSeasonsView.heightAnchor.constraint(equalToConstant: 0.5)])
    }
    
    // Logo Image View Constraints
func setLogoConstraints(aspectRatio: Float) {
    self.logoImageView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([self.logoImageView.bottomAnchor.constraint(equalTo: self.playButton.bottomAnchor),
                                 self.logoImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -12),
                                 self.logoImageView.widthAnchor.constraint(equalToConstant: 75),
                                 self.logoImageView.heightAnchor.constraint(equalTo: self.logoImageView.widthAnchor, multiplier: CGFloat(aspectRatio))])
}
    
    func checkTVShowForFavorites() {
        addedToFavorite = RealmManagerTVShow.shared.searchTVShowForFavoritesIDInRealm(tvShowID: tvShowID)
    }
    
    func fillDetailsOfTVShow() {
        self.getTVShowPoster()
        self.getStarsLevel(starsLevel: tvShowViewModel.vote_average)
        self.getProductionCompanyLogo(logoURL: tvShowViewModel.productionCompanyLogoURL)
        titleTextLable.text = tvShowViewModel.name
        releaseDateTextLabel.text = tvShowViewModel.first_air_date
        genresTextLabel.text = tvShowViewModel.genres
        runtimeTextLabel.text = tvShowViewModel.episodeRunTime
        countryTextLabel.text = tvShowViewModel.production_countries
        overviewTextLabel.text = tvShowViewModel.overview
        nameOfCollectionViewActorsLabel.text = "Actors:"
        nameOfCollectionViewSeasonsLabel.text = "Seasons: \(tvShowViewModel.number_of_seasons)"
        
    }
    func getTVShowPoster() {
        var imageURL = ""
        imageURL = Constants.Network.posterBaseURL + "\(tvShowViewModel.poster_path)"
        self.posterImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "placeholder.png"))
    }
    
    func getStarsLevel(starsLevel: Double) {
        starsImageView.image = StarsLevel.movieOrTvShowStarsLevel(level: starsLevel)
        starsImageView.image = starsImageView.image?.withRenderingMode(.alwaysTemplate)
        starsImageView.tintColor = Constants.MyColors.myLightGreyColor
    }
    
    func getProductionCompanyLogo(logoURL: String) {
        self.logoImageView.sd_setImage(with: URL(string:logoURL), placeholderImage: UIImage(named: "placeholder.png"))
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
            RealmManagerTVShow.shared.createAndSaveTVShowForFavorites(tvShow: tvShowViewModel.tvShowWithDetails)
            addedToFavorite = true
            self.addToFavoriteButton.image = UIImage(named: "fi-rr-heart")
            self.addToFavoriteButton.tintColor = .orange
        } else {
            RealmManagerTVShow.shared.deleteTVShowForFavoritesFromRealmByID(tvShowID: tvShowID)
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
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: self.tvShowViewModel.name[0..<25] , style: .plain, target: self, action: nil)
    }
}

extension TvShowDetailedScrollViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == actorsCollectionView {
            return self.actorsCollectionViewModel.numberOfRows()
        } else {
            return self.seasonsCollectionViewModel.numberOfRows()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == actorsCollectionView {
            
            guard let actorCell = actorsCollectionView.dequeueReusableCell(withReuseIdentifier: ActorCollectionViewCell.reuseIndetifire, for: indexPath) as? ActorCollectionViewCell  else {return UICollectionViewCell()}
            let cellViewModel = actorsCollectionViewModel.createCellViewModel(indexPath: indexPath)
            actorCell.cellConfigure(cellViewModel: cellViewModel)
            return actorCell
            
        } else {
            guard let seasonCell = seasonsCollectionView.dequeueReusableCell(withReuseIdentifier: SeasonCollectionViewCell.reuseIndetifire, for: indexPath) as? SeasonCollectionViewCell  else {return UICollectionViewCell()}
            let cellViewModel = seasonsCollectionViewModel.createCellViewModel(indexPath: indexPath)
            seasonCell.cellConfigure(cellViewModel: cellViewModel)
            return seasonCell
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if collectionView == actorsCollectionView {
            if let actorDetailedScrollViewController = storyboard.instantiateViewController(withIdentifier: ActorDetailedScrollViewController.reuseIdentifire) as? ActorDetailedScrollViewController {
                
                actorDetailedScrollViewController.actorID = self.actorsCollectionViewModel.arrayOfActors[indexPath.row].id
                navigationController?.pushViewController(actorDetailedScrollViewController, animated: true)
            }
        } else {
            
            if let tvShowSeasonScrollViewController = storyboard.instantiateViewController(withIdentifier: TVShowSeasonScrollViewController.reuseIdentifire) as? TVShowSeasonScrollViewController {
                tvShowSeasonScrollViewController.tvShowSeason =  (tvShowID,
                                                                  seasonNumber: self.seasonsCollectionViewModel.arrayOFSeasons[indexPath.row].season_number ?? 0)
                navigationController?.pushViewController(tvShowSeasonScrollViewController, animated: true)
            }
        }
    }
}

