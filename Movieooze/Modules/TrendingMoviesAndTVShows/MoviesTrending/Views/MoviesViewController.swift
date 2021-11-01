//
//  ViewController.swift
//  Movieooze
//
//  Created by Artem Shcherban on 07.08.2021.
//

import UIKit
import SDWebImage


class MoviesViewController: UIViewController {
    
    var pageIndex: Int!
    var tableViewViewModel: MoviesTrendingTableViewViewModel!
   
    @IBOutlet weak var moviesListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tableViewViewModel = MoviesTrendingTableViewViewModel()

        
        self.moviesListTableView.register(UINib(nibName: ListCellTableView.reuseIdentifire, bundle: nil), forCellReuseIdentifier: ListCellTableView.reuseIdentifire)
       
        tableViewViewModel.moviesGenresRequest(completion: {
            
        })
        tableViewViewModel?.moviesTrendingRequest(completion: {
        self.moviesListTableView.reloadData()
            
        })
    }
}

extension MoviesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewViewModel?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: ListCellTableView.reuseIdentifire) as? ListCellTableView, let viewModel = tableViewViewModel else  { return UITableViewCell() }
 
        let cellViewModel = viewModel.createCellViewModel(indexPath: indexPath)
        cell.cellConfigureMovie(cellViewModel: cellViewModel)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 158
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let movieDetailedScrollViewController = storyboard.instantiateViewController(withIdentifier: MovieDetailedScrollViewController.reuseIdentifire) as? MovieDetailedScrollViewController {
            movieDetailedScrollViewController.movieID =  tableViewViewModel.arrayOfMovies[indexPath.row].id
            self.navigationController?.pushViewController(movieDetailedScrollViewController, animated: true)
        }
    }
}
