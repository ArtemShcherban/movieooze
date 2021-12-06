//
//  FavoriteMovieViewController.swift
//  Movieooze
//
//  Created by Artem Shcherban on 15.08.2021.
//

import UIKit

class FavoriteMovieViewController: UIViewController, UISearchControllerDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    static let reuseIdentifire = String(describing: FavoriteMovieViewController.self)
   
    var pageIndex: Int!
    
    var favoriteMoviesTableViewViewModel: FavoriteMoviesTableViewViewModel!
    var filteredFavoriteMovies: [Movie] = []
    
    @IBOutlet weak var favoriteMovieTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchBar()
        favoriteMoviesTableViewViewModel = FavoriteMoviesTableViewViewModel()
        self.favoriteMovieTableView.register(UINib(nibName: ListCellTableView.reuseIdentifier, bundle: nil), forCellReuseIdentifier: ListCellTableView.reuseIdentifier)
  }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoriteMoviesTableViewViewModel.getMoviesFromRealm(completion: {
            self.favoriteMovieTableView.reloadData()
        })

    }

    func configureSearchBar() {
        self.searchBar.sizeToFit()
        self.searchBar.delegate = self
        self.searchBar.clipsToBounds = true
        self.searchBar.layer.cornerRadius = 15
        self.searchBar.searchTextField.textColor = .white
        self.searchBar.searchTextField.font = UIFont.systemFont(ofSize: 16, weight: .thin)
        self.searchBar.placeholder = "Search favorite movie"
    }
    
        var isFiltering: Bool {
            return searchBar.searchTextField.hasText
        }
    
    
    func filterFavoritesMovies(_ searchText: String) {
        filteredFavoriteMovies = favoriteMoviesTableViewViewModel.arrayOfMoviesForFavorites.filter { (movie: Movie) -> Bool in
            return
                movie.title?.lowercased().contains(searchText.lowercased()) ?? false
        }
        favoriteMovieTableView.reloadData()
    }

}
extension FavoriteMovieViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterFavoritesMovies(searchText)
        
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

extension FavoriteMovieViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering {
            return filteredFavoriteMovies.count
        }
        return favoriteMoviesTableViewViewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: ListCellTableView.reuseIdentifier, for: indexPath) as? ListCellTableView else {return UITableViewCell() }
        
        if isFiltering {
            let  cellViewModel = favoriteMoviesTableViewViewModel.createCellViewModel(indexPath: indexPath, filteredArray: filteredFavoriteMovies)
               cell.cellConfigureMovie(cellViewModel: cellViewModel)
            
        } else {
         let  cellViewModel = favoriteMoviesTableViewViewModel.createCellViewModel(indexPath: indexPath)
            cell.cellConfigureMovie(cellViewModel: cellViewModel)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 158
    }
}

extension FavoriteMovieViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let movieDetailedScrollViewController = storyboard.instantiateViewController(withIdentifier: MovieDetailedScrollViewController.reuseIdentifier) as? MovieDetailedScrollViewController {
            
            let movieFavorite: Movie
            
            if isFiltering {
                movieFavorite = filteredFavoriteMovies[indexPath.row]
                
            } else {
                movieFavorite = favoriteMoviesTableViewViewModel.arrayOfMoviesForFavorites[indexPath.row]
            }
            movieDetailedScrollViewController.movieID = movieFavorite.id
            self .navigationController?.pushViewController(movieDetailedScrollViewController, animated: true)
        }
    }
}

