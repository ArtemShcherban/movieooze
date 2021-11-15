//
//  SearchViewController.swift
//  Movieooze
//
//  Created by Artem Shcherban on 01.11.2021.
//

import UIKit

class SearchViewController: UIViewController {

    var searchViewModel: SearchTableViewModel!
    
    @IBOutlet weak var searchTextField: UISearchBar!
  
    @IBOutlet weak var requestesTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchViewModel = SearchTableViewModel()
        title = "Search"
        tableViewCustomization()

        
        self.requestesTableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.reuseIndetifire)

        self.searchViewModel.getUsersRequestsFromRealm(completion: {
            self.requestesTableView.reloadData()
        })
        
    }
    func tableViewCustomization() {
        self.requestesTableView.isScrollEnabled = false
        self.requestesTableView.separatorStyle = .none
        self.requestesTableView.backgroundColor = .clear
    }
}
extension SearchViewController: UISearchBarDelegate {

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.text = ""
    }

    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        view.endEditing(true)
        if searchBar.text?.isEmpty != true {
            searchViewModel.checkAndSaveUserRequest(request: searchBar.text ?? "")
                searchViewModel.getUsersRequestsFromRealm(completion: {
            self.requestesTableView.reloadData()
        })
        searchBar.resignFirstResponder()
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
}


