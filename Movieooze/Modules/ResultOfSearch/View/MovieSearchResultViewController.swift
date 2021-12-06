//
//  SearchResultViewController.swift
//  Movieooze
//
//  Created by Artem Shcherban on 20.11.2021.
//

import UIKit

class MovieSearchResultViewController: UIViewController {
    
    static let reuseidentifier = String(describing: MovieSearchResultViewController.self)
    
    @IBOutlet weak var movieSearchResultTableView: UITableView!
    
    var pageIndex: Int!
    var searchNetworkViewModel: SearchNetworkViewModel!
    var movieSearchResultTableViewModel: MovieSearchResultTableViewModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieSearchResultTableViewModel = MovieSearchResultTableViewModel()
        
        self.movieSearchResultTableViewModel.getMovieSearchResult(searchNetworkViewModel: searchNetworkViewModel)
        
        self.movieSearchResultTableView.register(UINib(nibName: ListCellTableView.reuseIdentifier, bundle: nil), forCellReuseIdentifier: ListCellTableView.reuseIdentifier)

        self.movieSearchResultTableView.tableFooterView = UIView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        // Make the Navigation Bar background transparent
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = .white
        
    }
}

extension MovieSearchResultViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movieSearchResultTableViewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: ListCellTableView.reuseIdentifier) as? ListCellTableView, let viewModel = movieSearchResultTableViewModel else  { return UITableViewCell() }
        
        let cellViewModel = viewModel.createCellViewModel(indexPath: indexPath)
        cell.cellConfigureMovie(cellViewModel: cellViewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 158
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let movieDetailedScrollViewController = storyboard.instantiateViewController(withIdentifier: MovieDetailedScrollViewController.reuseIdentifier) as? MovieDetailedScrollViewController else { return }
        
        movieDetailedScrollViewController.movieID = movieSearchResultTableViewModel.arrayOfMovieSearchResult[indexPath.row].id
        self.navigationController?.pushViewController(movieDetailedScrollViewController, animated: true)
    }
    
}
