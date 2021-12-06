//
//  SearchViewController.swift
//  Movieooze
//
//  Created by Artem Shcherban on 01.11.2021.
//

import UIKit

class SearchViewController: UIViewController {
    
    var searchViewModel: SearchTableViewModel!
    var searchNetworkViewModel: SearchNetworkViewModel!
    
    @IBOutlet weak var searchTextField: UISearchBar!
    @IBOutlet weak var requestesTableView: UITableView!
    
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Search"
        searchViewModel = SearchTableViewModel()
        searchNetworkViewModel = SearchNetworkViewModel()

        tableViewCustomization()

        self.requestesTableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.reuseIndetifire)
        self.searchViewModel.getUsersRequestsFromRealm(completion: {
            self.requestesTableView.reloadData()
        })
    }
    
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = .black
    }
    
    
    
    func openResultViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
       
        if searchNetworkViewModel.numberOfResults > 0 {
            
            if let startSearchViewController = storyboard.instantiateViewController(withIdentifier: StartSearchViewController.reuseidentifier) as? StartSearchViewController {
                self.navigationController?.pushViewController(startSearchViewController, animated: true)
                startSearchViewController.searchNetworkViewModel = searchNetworkViewModel
            }
        
        } else {
            if let noSearchResultViewController = storyboard.instantiateViewController(withIdentifier: NoSearchResultViewController.reuseidentifier) as? NoSearchResultViewController {
                self.navigationController?.pushViewController(noSearchResultViewController, animated: true)
            }
        }
    }
    
    func tableViewCustomization() {
        self.requestesTableView.isScrollEnabled = false
        self.requestesTableView.separatorStyle = .none
        self.requestesTableView.backgroundColor = .clear
    }
    
    func checkSaveUpdate(request: String) {
        searchViewModel.checkAndSaveUserRequest(request: request)
        searchViewModel.getUsersRequestsFromRealm(completion: {
            self.requestesTableView.reloadData()
        })
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.text = ""
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text?.isEmpty != true {
            searchNetworkViewModel.getResultOfSearch(search: searchBar.text ?? "", completion: {
                let endTime = DispatchTime.now()
                let nanoTime = endTime.uptimeNanoseconds - Constants.Network.startTime.uptimeNanoseconds
                let timeInterval = Double(nanoTime) / 1_000_000_000
                print("\(timeInterval) s.")
              
               if self.searchNetworkViewModel.arrayOfPersons.count > 0 {
                print("!!!!!!!!!!! Person:  \(self.searchNetworkViewModel.arrayOfPersons[0].name ?? "")   !!!!!!!!  \(self.searchNetworkViewModel.arrayOfPersons.count)")
               }
               if self.searchNetworkViewModel.arrayOFMovies.count > 0 {
                print("!!!!!!!!!!! Movie: \(self.searchNetworkViewModel.arrayOFMovies[0].title ?? "")   !!!!!!!! \(self.searchNetworkViewModel.arrayOFMovies.count)")
               }
               if self.searchNetworkViewModel.arrayOfTvShows.count > 0 {
                print("!!!!!!!!!!! TvShow: \(self.searchNetworkViewModel.arrayOfTvShows[0].name ?? "")   !!!!!!!! \(self.searchNetworkViewModel.arrayOfTvShows.count)")
               }
//               let a = self.searchNetworkViewModel.indexOfViewController()
                self.openResultViewController()
                self.checkSaveUpdate(request: searchBar.text ?? "")
                searchBar.resignFirstResponder()
            })
            
        } else {
            searchBar.resignFirstResponder()
        }
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchViewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reuseIndetifire, for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        
        let cellViewModel = searchViewModel.createCellViewModel(indexPath: indexPath)
        
        cell.cellConfigure(cellviewModel: cellViewModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let request = searchViewModel.arrayOfUsersRequests[indexPath.row].userRequestText
        
        searchNetworkViewModel.getResultOfSearch(search: request, completion: {
            
            let endTime = DispatchTime.now()
            let nanoTime = endTime.uptimeNanoseconds - Constants.Network.startTime.uptimeNanoseconds
            let timeInterval = Double(nanoTime) / 1_000_000_000
            print("\(timeInterval) s.")
          
           if self.searchNetworkViewModel.arrayOfPersons.count > 0 {
            print("!!!!!!!!!!! Person:  \(self.searchNetworkViewModel.arrayOfPersons[0].name ?? "")   !!!!!!!!  \(self.searchNetworkViewModel.arrayOfPersons.count)")
           }
           if self.searchNetworkViewModel.arrayOFMovies.count > 0 {
            print("!!!!!!!!!!! Movie: \(self.searchNetworkViewModel.arrayOFMovies[0].title ?? "")   !!!!!!!! \(self.searchNetworkViewModel.arrayOFMovies.count)")
           }
           if self.searchNetworkViewModel.arrayOfTvShows.count > 0 {
            print("!!!!!!!!!!! TvShow: \(self.searchNetworkViewModel.arrayOfTvShows[0].name ?? "")   !!!!!!!! \(self.searchNetworkViewModel.arrayOfTvShows.count)")
           }
            self.openResultViewController()
            self.checkSaveUpdate(request: request)
        })
    }
}


