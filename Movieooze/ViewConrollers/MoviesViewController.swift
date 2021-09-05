//
//  ViewController.swift
//  Movieooze
//
//  Created by Artem Shcherban on 07.08.2021.
//

import UIKit
import Alamofire
import SDWebImage


class MoviesViewController: UIViewController {
    
    @IBOutlet weak var moviesListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.moviesListTableView.register(UINib(nibName: ListMovieCellTableView.reuseIdentifire, bundle: nil), forCellReuseIdentifier: ListMovieCellTableView.reuseIdentifire)
        
        self.alamofireGenresListRequest()
        self.alamofireMoviesListRequest()
        self.moviesListTableView.reloadData()
    }
}


extension MoviesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: ListMovieCellTableView.reuseIdentifire) as? ListMovieCellTableView else  { return UITableViewCell() }
        
        cell.cellConfigure(movie: arrayOfMovies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let movieDetailedScrollViewController = storyboard.instantiateViewController(withIdentifier: MovieDetailedScrollViewController.reuseIdentifire) as? MovieDetailedScrollViewController {
            
            movieDetailedScrollViewController.movieID = arrayOfMovies[indexPath.row].id
            self.navigationController?.pushViewController(movieDetailedScrollViewController, animated: true)
        }
    }
    
    func alamofireMoviesListRequest() {
        
        AF.request("https://api.themoviedb.org/3/trending/movie/day?api_key=86b8d80830ef6774289e25cad39e4fbd").responseJSON { myJSONresponse in
            
            let decoder = JSONDecoder()
            if let dataMovies = try? decoder.decode(ResultMoviesTrendingDay.self, from: myJSONresponse.data!) {
                arrayOfMovies = dataMovies.results ?? []
                self.moviesListTableView.reloadData()
            }
        }
    }
    
    func alamofireGenresListRequest() {
        
        AF.request("https://api.themoviedb.org/3/genre/movie/list?api_key=86b8d80830ef6774289e25cad39e4fbd").responseJSON { myJSONresponse in
            let decoder = JSONDecoder()
            if let dataGenres = try? decoder.decode(ResultGenres.self, from: myJSONresponse.data!) {
                
                arrayOFGenres = dataGenres.genres ?? []
                arrayToDictionary(array: arrayOFGenres)
            }
        }
    }
}
