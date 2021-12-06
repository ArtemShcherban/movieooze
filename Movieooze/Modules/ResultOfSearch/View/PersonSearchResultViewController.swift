//
//  PersonSearchResultViewController.swift
//  Movieooze
//
//  Created by Artem Shcherban on 01.12.2021.
//

import UIKit

class PersonSearchResultViewController: UIViewController {
    
    static let reuseidentifier = String(describing: PersonSearchResultViewController.self)
     
    @IBOutlet weak var personSearchResultTableView: UITableView!
    
    var pageIndex: Int!
    var searchNetworkViewModel: SearchNetworkViewModel!
    var personSearchResultTableViewModel: PersonSearchResultTableViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        personSearchResultTableViewModel = PersonSearchResultTableViewModel()
        
        self.personSearchResultTableViewModel.getPersonSearchResult(searchNetworkViewModel: searchNetworkViewModel)
         
        self.personSearchResultTableView.register(UINib(nibName: PersonTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: PersonTableViewCell.reuseIdentifier)
        
        self.personSearchResultTableView.tableFooterView = UIView()
        

    }

}

extension PersonSearchResultViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.personSearchResultTableViewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: PersonTableViewCell.reuseIdentifier) as? PersonTableViewCell, let viewModel = personSearchResultTableViewModel else { return UITableViewCell ()}
        
        let cellViewModel = viewModel.createCellViewModel(indexPath: indexPath)
        
        cell.cellConfigure(cellViewModel: cellViewModel)
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let actorDetailedScrollViewController = storyboard.instantiateViewController(withIdentifier: ActorDetailedScrollViewController.reuseIdentifier) as? ActorDetailedScrollViewController else { return }
        
        actorDetailedScrollViewController.actorID = personSearchResultTableViewModel.arrayOfPersonSearchResult[indexPath.row].id
        
        self.navigationController?.pushViewController(actorDetailedScrollViewController, animated: true)
        
    }
}
