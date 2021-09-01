//
//  FavoriteMovieViewController.swift
//  Movieooze
//
//  Created by Artem Shcherban on 15.08.2021.
//

import UIKit

class FavoriteMovieViewController: UIViewController {

    @IBOutlet weak var favoriteMovieTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.favoriteMovieTableView.register(UINib(nibName: ListMovieCellTableView.reuseIdentifire, bundle: nil), forCellReuseIdentifier: ListMovieCellTableView.reuseIdentifire)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.getMoviesFromRealm {
            print("jfbjkbjkfbjk")
        }
        self.favoriteMovieTableView.reloadData()
    }    
}

extension FavoriteMovieViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfMoviesForFavorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: ListMovieCellTableView.reuseIdentifire, for: indexPath) as? ListMovieCellTableView else {return UITableViewCell() }
        
        cell.cellConfigure(movie: arrayOfMoviesForFavorites[indexPath.row])
        
        return cell
    }
}

extension FavoriteMovieViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let movieDetailedScrollViewController = storyboard.instantiateViewController(withIdentifier: MovieDetailedScrollViewController.reuseIdentifire) as? MovieDetailedScrollViewController {
            
            let movieFavorite = arrayOfMoviesForFavorites[indexPath.row]
            movieDetailedScrollViewController.movie = movieFavorite
            self .navigationController?.pushViewController(movieDetailedScrollViewController, animated: true)
            //     🧐 Убрать print
            print(movieFavorite)
        }
    }
    
    func getMoviesFromRealm(completion: @escaping(() -> ())) {
        RealmManager.shared.newReadFromRealmMovieForFavorites(completion: { movies in arrayOfMoviesForFavorites = movies})
    }
    
}

