//
//  FavoriteMovieViewController.swift
//  Movieooze
//
//  Created by Artem Shcherban on 15.08.2021.
//

import UIKit

class FavoriteMovieViewController: UIViewController {
    
    var filteredFavoriteMovies: [Movie] = []
    
    @IBOutlet weak var favoriteMovieTableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.favoriteMovieTableView.register(UINib(nibName: ListMovieCellTableView.reuseIdentifire, bundle: nil), forCellReuseIdentifier: ListMovieCellTableView.reuseIdentifire)
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation =  false
        searchController.searchBar.placeholder = "Search favorite movie"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        self.getMoviesFromRealm {
            print("jfbjkbjkfbjk")
        }
        self.favoriteMovieTableView.reloadData()
        
    }
    
    var isSearchBarisEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarisEmpty
    }
    
//    func filterFavoritesMovies(_ searchText: String) {
//        filteredFavoriteMovies = arrayOfMoviesForFavorites.filter { (movie: Movie) -> Bool in
//
//            return
//                movie.title?.lowercased().contains(searchText.lowercased()) ?? false
//        }
//        favoriteMovieTableView.reloadData()
//    }
    func filterFavoritesMovies(_ searchText: String) {
        filteredFavoriteMovies = arrayOfMoviesForFavorites.filter { (movie: Movie) -> Bool in
//            if  let key = dicGenres.ke
            return
                movie.title?.lowercased().contains(searchText.lowercased()) ?? false
        }
        favoriteMovieTableView.reloadData()
    }
}

extension FavoriteMovieViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterFavoritesMovies(searchBar.text ?? "")
    }
}

extension FavoriteMovieViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering {
            return filteredFavoriteMovies.count
        }
        return arrayOfMoviesForFavorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: ListMovieCellTableView.reuseIdentifire, for: indexPath) as? ListMovieCellTableView else {return UITableViewCell() }
        
        if isFiltering {
            cell.cellConfigure(movie: filteredFavoriteMovies[indexPath.row])
            
        } else {
            cell.cellConfigure(movie: arrayOfMoviesForFavorites[indexPath.row])
        }
        
        return cell
    }
}

extension FavoriteMovieViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let movieDetailedScrollViewController = storyboard.instantiateViewController(withIdentifier: MovieDetailedScrollViewController.reuseIdentifire) as? MovieDetailedScrollViewController {
            
            let movieFavorite: Movie
            
            if isFiltering {
                movieFavorite = filteredFavoriteMovies[indexPath.row]
                //     🧐 Убрать print
                print(movieFavorite)
            } else {
                movieFavorite = arrayOfMoviesForFavorites[indexPath.row]
                //     🧐 Убрать print
                print(movieFavorite)
            }
            movieDetailedScrollViewController.movie = movieFavorite
            self .navigationController?.pushViewController(movieDetailedScrollViewController, animated: true)
        }
    }
    
    func getMoviesFromRealm(completion: @escaping(() -> ())) {
        RealmManager.shared.newReadFromRealmMovieForFavorites(completion: { movies in arrayOfMoviesForFavorites = movies})
    }
    
}

