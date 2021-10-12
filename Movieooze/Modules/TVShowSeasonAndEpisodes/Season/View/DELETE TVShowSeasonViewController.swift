//
//  TVShowSeasonViewController.swift
//  Movieooze
//
//  Created by Artem Shcherban on 02.10.2021.
//

import UIKit

class TVShowSeasonViewController: UIViewController {
    static let reuseIdentifire = String(describing: TVShowSeasonViewController.self)
    
    var tvShowSeasonViewModel: TVShowSeasonViewModel!
    var episodesTableViewViewModel: EpisodesTableViewViewModel!
    var headerView: StretchyTVShowSeasonTableHeaderView!
    var tvShowSeason: (tvShowID: Int, seasonNumber: Int)!
    var episodesTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tvShowSeasonViewModel = TVShowSeasonViewModel()
        episodesTableViewViewModel = EpisodesTableViewViewModel()
        
        tvShowSeasonViewModel.getTVShowSeasonDetails(tvShowID: tvShowSeason.tvShowID, seasonNumber: tvShowSeason.seasonNumber, completion: {
            
            self.getSeasonPoster(seasonPostrerPath: self.tvShowSeasonViewModel.seasonPoster_path)
            self.episodesTableViewViewModel.getArrayOfEpisodes(tvShowSeasonViewModel: self.tvShowSeasonViewModel)
            self.episodesTableView.reloadData()
            self.episodesTableView.isScrollEnabled = false
            self.episodesTableView.showsVerticalScrollIndicator = false
            //🧐 убрать print
            print(self.tvShowSeason.tvShowID)
            print(self.tvShowSeasonViewModel.seasonOverview)
            //            print(self.episodesTableViewViewModel.arrayOfEpisodes)
            
        })
        createViews()
        createHeaderView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Make the Navigation Bar background transparent
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = .white
        
    }
    
    
    func createHeaderView() {
        headerView = StretchyTVShowSeasonTableHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 500))
        self.episodesTableView.tableHeaderView = self.headerView
    }
    
    func createViews() {
        
        // Create Episodes Table View
        episodesTableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        
        self.episodesTableView.register(EpisodeTableViewCell.self, forCellReuseIdentifier: EpisodeTableViewCell.reuseIdentifire)
        self.episodesTableView.delegate = self
        self.episodesTableView.dataSource = self
        episodesTableView.backgroundColor = Constants.MyColors.myDarkGreyColor
        self.view.addSubview(episodesTableView)
        
        
    }
    
    func getSeasonPoster(seasonPostrerPath: String) {
        var imageURL = ""
        imageURL = Constants.Network.posterBaseURL + "\(seasonPostrerPath)"
        headerView.seasonPosterView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "placeholder.png"))
    }
}

extension TVShowSeasonViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let headerView = self.episodesTableView.tableHeaderView as! StretchyTVShowSeasonTableHeaderView
        headerView.scrollViewDidScroll(scrollView: scrollView)
    }
}

extension TVShowSeasonViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodesTableViewViewModel.numberOfRows()
        
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


