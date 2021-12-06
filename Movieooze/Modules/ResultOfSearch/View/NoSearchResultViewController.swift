//
//  NoSearchResultViewController.swift
//  Movieooze
//
//  Created by Artem Shcherban on 20.11.2021.
//

import UIKit

class NoSearchResultViewController: UIViewController {
   
    static let reuseidentifier = String(describing: NoSearchResultViewController.self)
   

    
    override func viewDidLoad() {
        super.viewDidLoad()

      
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
