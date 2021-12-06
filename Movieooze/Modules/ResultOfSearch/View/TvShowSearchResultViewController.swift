//
//  TvShowSearchResultViewController.swift
//  Movieooze
//
//  Created by Artem Shcherban on 01.12.2021.
//

import UIKit

class TvShowSearchResultViewController: UIViewController {
    
    static let reuseidentifier = String(describing: TvShowSearchResultViewController.self)
    
    @IBOutlet weak var tvShowSearchResultTableView: UITableView!
    
    var pageIndex: Int!
    var searchNetworkViewModel: SearchNetworkViewModel!
    var tvShowSearchResultTableViewModel: TvShowSearchResultTableViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tvShowSearchResultTableViewModel = TvShowSearchResultTableViewModel()
        
        self.tvShowSearchResultTableViewModel.getTvShowSearchResult(searchNetworkViewModel: searchNetworkViewModel)
       
        
        self.tvShowSearchResultTableView.register(UINib(nibName: ListCellTableView.reuseIdentifier, bundle: nil), forCellReuseIdentifier: ListCellTableView.reuseIdentifier)
        
        self.tvShowSearchResultTableView.tableFooterView = UIView()
    }
}

extension TvShowSearchResultViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tvShowSearchResultTableViewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListCellTableView.reuseIdentifier) as? ListCellTableView, let viewModel = tvShowSearchResultTableViewModel else { return UITableViewCell() }
       
        let cellViewModel = viewModel.createCellViewModel(indexPath: indexPath)
        
        cell.cellConfigureTVShow(cellViewModel: cellViewModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 158
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let tvShowDetailedScrollViewController = storyboard.instantiateViewController(withIdentifier: TvShowDetailedScrollViewController.reuseIdentifier) as? TvShowDetailedScrollViewController else { return }
        
        tvShowDetailedScrollViewController.tvShowID = tvShowSearchResultTableViewModel.arrayOfTvShowSearchResult[indexPath.row].id
      
        self.navigationController?.pushViewController(tvShowDetailedScrollViewController, animated: true)
    }
}
