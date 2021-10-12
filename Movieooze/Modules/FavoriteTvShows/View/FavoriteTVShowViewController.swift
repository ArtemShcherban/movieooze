//
//  FavoriteMovieViewController.swift
//  Movieooze
//
//  Created by Artem Shcherban on 09.10.2021.
//

import UIKit

class FavoriteTVShowViewController: UIViewController {

    
    @IBOutlet weak var searchBar: UISearchBar!
    
    static let reuseIdentifire = String(describing: FavoriteTVShowViewController.self)
   
    var pageIndex: Int!
    
    var favoriteTVShowTableViewViewModel: FavoriteTVShowTableViewViewModel!
    var filteredFavoriteTVShows: [TVShow] = []
    
    @IBOutlet weak var favoriteTVShowTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureSearchBar()
        favoriteTVShowTableViewViewModel = FavoriteTVShowTableViewViewModel()
        self.favoriteTVShowTableView.register(UINib(nibName: ListCellTableView.reuseIdentifire, bundle: nil), forCellReuseIdentifier: ListCellTableView.reuseIdentifire)
  }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoriteTVShowTableViewViewModel.getTVShowsFromRealm(completion: {
            self.favoriteTVShowTableView.reloadData()
        })
    }

    func configureSearchBar() {
        self.searchBar.sizeToFit()
        self.searchBar.delegate = self
        self.searchBar.clipsToBounds = true
        self.searchBar.layer.cornerRadius = 15
        self.searchBar.searchTextField.textColor = .white
        self.searchBar.searchTextField.font = UIFont.systemFont(ofSize: 16, weight: .thin)
        self.searchBar.placeholder = "Search favorite TV Show"
    }
    
        var isFiltering: Bool {
            return searchBar.searchTextField.hasText
        }
    
    
    func filterFavoritesTVShows(_ searchText: String) {
        filteredFavoriteTVShows = favoriteTVShowTableViewViewModel.arrayOfTVShowsForFavorites.filter { (tvShow: TVShow) -> Bool in
            return
                tvShow.name?.lowercased().contains(searchText.lowercased()) ?? false
        }
        favoriteTVShowTableView.reloadData()
    }

}
extension FavoriteTVShowViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterFavoritesTVShows(searchText)
        
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
        
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = false
        self.searchBar.text = ""
        self.searchBar(searchBar, textDidChange: "")
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        view.endEditing(true)
        searchBar.resignFirstResponder()
    }
}

extension FavoriteTVShowViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering {
            return filteredFavoriteTVShows.count
        }
        return favoriteTVShowTableViewViewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: ListCellTableView.reuseIdentifire, for: indexPath) as? ListCellTableView else {return UITableViewCell() }
        
        if isFiltering {
            let  cellViewModel = favoriteTVShowTableViewViewModel.createCellViewModel(indexPath: indexPath, filteredArray: filteredFavoriteTVShows)
               cell.cellConfigureTVShow(cellViewModel: cellViewModel)
            
        } else {
         let  cellViewModel = favoriteTVShowTableViewViewModel.createCellViewModel(indexPath: indexPath)
            cell.cellConfigureTVShow(cellViewModel: cellViewModel)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 158
    }
}

extension FavoriteTVShowViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let tvShowDetailedScrollViewController = storyboard.instantiateViewController(withIdentifier: TvShowDetailedScrollViewController.reuseIdentifire) as? TvShowDetailedScrollViewController {
            
            let tvShowFavorite: TVShow
            
            if isFiltering {
                tvShowFavorite = filteredFavoriteTVShows[indexPath.row]
                
            } else {
                tvShowFavorite = favoriteTVShowTableViewViewModel.arrayOfTVShowsForFavorites[indexPath.row]
            }
            tvShowDetailedScrollViewController.tvShowID = tvShowFavorite.id
            self .navigationController?.pushViewController(tvShowDetailedScrollViewController, animated: true)
        }
    }
}

