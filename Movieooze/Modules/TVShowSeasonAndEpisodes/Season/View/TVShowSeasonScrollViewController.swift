//
//  TVShowSeasonScrollViewController.swift
//  Movieooze
//
//  Created by Artem Shcherban on 04.10.2021.
//

import Foundation
import UIKit

class TVShowSeasonScrollViewController: UIViewController, UIScrollViewDelegate {
    static let reuseIdentifire = String(describing: TVShowSeasonScrollViewController.self)
    
    var tvShowSeasonViewModel: TVShowSeasonViewModel!
    var episodesTableViewViewModel: EpisodesTableViewViewModel!
    var scrollView: UIScrollView!
    var headerContainerView: UIView!
    var seasonPosterView, titleImageView: UIImageView!
    var gradientView: UIView!
    var mainContainerView: UIView!
    var seasonTitleTextLable: UILabel!
    var overviewTextLabel: UILabel!
    var overviewClearButton: UIButton!
    var overviewButtonPressed = false
    var tvShowSeason: (tvShowID: Int, seasonNumber: Int)!
    var episodesTableView: UITableView!


    
    override func viewDidLoad() {
        super.viewDidLoad()
        tvShowSeasonViewModel = TVShowSeasonViewModel()
        episodesTableViewViewModel = EpisodesTableViewViewModel()
        
        tvShowSeasonViewModel.getTVShowSeasonDetails(tvShowID: tvShowSeason.tvShowID, seasonNumber: tvShowSeason.seasonNumber, completion: {
            
            self.getSeasonPoster(seasonPostrerPath: self.tvShowSeasonViewModel.seasonPoster_path)
            self.episodesTableViewViewModel.getArrayOfEpisodes(tvShowSeasonViewModel: self.tvShowSeasonViewModel)
            self.seasonTitleTextLable.text = self.tvShowSeasonViewModel.seasonName
            self.overviewTextLabel.text = self.tvShowSeasonViewModel.seasonOverview
            self.setConstraintsForEpisodeTableView()
            self.episodesTableView.reloadData()
                        
        })
        
        
        self.createViews()
        self.setViewsConstraints()
        
        // Season Title Text Lable Customization
        self.seasonTitleTextLable.backgroundColor = .clear
        self.seasonTitleTextLable.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        self.seasonTitleTextLable.textColor = .white
        
        // OverView Text Label Customization
        self.overviewTextLabel.backgroundColor = .clear
        self.overviewTextLabel.font = UIFont.systemFont(ofSize: 15)
        self.overviewTextLabel.textColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Make the Navigation Bar background transparent
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = .white

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
        seasonPosterView = UIImageView()
        seasonPosterView.clipsToBounds = true
        seasonPosterView.backgroundColor = .black
        seasonPosterView.contentMode = .scaleAspectFill
        self.headerContainerView.addSubview(seasonPosterView)
        
        // Gradient View
        gradientView = UIView()
        let newLayer = CAGradientLayer()
        newLayer.colors = [UIColor.clear.cgColor,
                           Constants.MyColors.myDarkGreyColor.cgColor]
        newLayer.endPoint = CGPoint(x: 0.5, y: 0.47)
        newLayer.frame = self.view.frame
        self.gradientView.layer.addSublayer(newLayer)
        self.scrollView.addSubview(gradientView)
        
        // Season Title Text Lable
        seasonTitleTextLable = UILabel()
        seasonTitleTextLable.numberOfLines = 0
        seasonTitleTextLable.baselineAdjustment = .alignBaselines
        self.scrollView.addSubview(seasonTitleTextLable)
        
        // Create Episodes Table View
        episodesTableView = UITableView()
        self.episodesTableView.register(EpisodeTableViewCell.self, forCellReuseIdentifier: EpisodeTableViewCell.reuseIdentifire)
        self.episodesTableView.isScrollEnabled = false
        self.episodesTableView.showsVerticalScrollIndicator = false
        self.episodesTableView.delegate = self
        self.episodesTableView.dataSource = self
        episodesTableView.backgroundColor = Constants.MyColors.myDarkGreyColor
        self.scrollView.addSubview(episodesTableView)
        
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
        seasonPosterView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.seasonPosterView.leadingAnchor.constraint(equalTo: self.headerContainerView.leadingAnchor),
                                     self.seasonPosterView.trailingAnchor.constraint(equalTo: self.headerContainerView.trailingAnchor),
                                     self.seasonPosterView.bottomAnchor.constraint(equalTo: self.headerContainerView.bottomAnchor)])
        posterImageViewTopConstraint = self.seasonPosterView.topAnchor.constraint(equalTo: self.view.topAnchor)
        posterImageViewTopConstraint.priority = UILayoutPriority(rawValue: 900)
        posterImageViewTopConstraint.isActive = true
        
        // Gradient View Constraints
        gradientView.translatesAutoresizingMaskIntoConstraints =  false
        NSLayoutConstraint.activate([self.gradientView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
                                     self.gradientView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                                     self.gradientView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                                     self.gradientView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor)])
        
        // Title Text Lable Constraints
        self.seasonTitleTextLable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.seasonTitleTextLable.bottomAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 320),
                                     self.seasonTitleTextLable.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 12),
                                     self.seasonTitleTextLable.widthAnchor.constraint(equalToConstant: 250)])
        
        // Overview Text Label Constraints
        overviewTextLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.overviewTextLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 12),
                                     self.overviewTextLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -12),
                                     self.overviewTextLabel.topAnchor.constraint(equalTo: self.seasonTitleTextLable.bottomAnchor, constant: 50)])
        
        // Overview Clear Button Constraints
        self.overviewClearButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.overviewClearButton.leadingAnchor.constraint(equalTo: self.overviewTextLabel.leadingAnchor),
                                     self.overviewClearButton.trailingAnchor.constraint(equalTo: self.overviewTextLabel.trailingAnchor),
                                     self.overviewClearButton.topAnchor.constraint(equalTo: self.overviewTextLabel.topAnchor),
                                     self.overviewClearButton.bottomAnchor.constraint(equalTo: self.overviewTextLabel.bottomAnchor)])
    }
    
    
    func setConstraintsForEpisodeTableView() {
        // Episodes Table View Constraints
        episodesTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.episodesTableView.topAnchor.constraint(equalTo: overviewTextLabel.bottomAnchor, constant: 20),
                                     self.episodesTableView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
                                     self.episodesTableView.heightAnchor.constraint(equalToConstant: CGFloat(episodesTableViewViewModel.numberOfRows() * 115)), self.episodesTableView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: -10)])
    }
    
    func getSeasonPoster(seasonPostrerPath: String) {
        var imageURL = ""
        imageURL = Constants.Network.posterBaseURL + "\(seasonPostrerPath)"
        self.seasonPosterView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "placeholder.png"))
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
}

extension TVShowSeasonScrollViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        episodesTableViewViewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let episodeCell = episodesTableView.dequeueReusableCell(withIdentifier: EpisodeTableViewCell.reuseIdentifire) as? EpisodeTableViewCell else { return UITableViewCell() }
        let cellViewModel = episodesTableViewViewModel.createCellViewModel(indexPath: indexPath)
        episodeCell.cellConfigure(cellViewModel: cellViewModel)
        
        return episodeCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        115
    }
    
    
}
