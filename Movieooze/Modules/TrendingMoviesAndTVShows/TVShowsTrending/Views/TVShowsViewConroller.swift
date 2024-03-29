//
//  TVShowsViewConroller.swift
//  Movieooze
//
//  Created by Artem Shcherban on 19.09.2021.
//

import UIKit


class TVShowsViewConroller: UIViewController {
    
    @IBOutlet weak var tvShowsTableView: UITableView!
    
    var pageIndex: Int!
    var tableViewViewModel: TVShowsTrendingTableViewModel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewViewModel = TVShowsTrendingTableViewModel()
  
        self.tvShowsTableView.register(UINib(nibName: ListCellTableView.reuseIdentifier, bundle: nil), forCellReuseIdentifier: ListCellTableView.reuseIdentifier)

        tableViewViewModel.tvShowsTrendingRequest(completion: {
            self.tvShowsTableView.reloadData()
        })
    }
}

extension TVShowsViewConroller: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewViewModel.numberOfRows()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 158
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard  let cell = tvShowsTableView.dequeueReusableCell(withIdentifier: ListCellTableView.reuseIdentifier) as? ListCellTableView else  { return UITableViewCell() }
        
        let cellViewModel = tableViewViewModel.createCellViewModel(indexPath: indexPath)
        cell.cellConfigureTVShow(cellViewModel: cellViewModel)
        print("\(cellViewModel.name) \(cellViewModel.id)")
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let tvShowDetailedScrollViewController = storyboard.instantiateViewController(withIdentifier: TvShowDetailedScrollViewController.reuseIdentifier) as? TvShowDetailedScrollViewController {
            tvShowDetailedScrollViewController.tvShowID = tableViewViewModel.arrayOfTVShows[indexPath.row].id
            navigationController?.pushViewController(tvShowDetailedScrollViewController, animated: true)
        }
        
    }
    
    
}
