//
//  SearchTableViewCell.swift
//  Movieooze
//
//  Created by Artem Shcherban on 06.11.2021.
//

import Foundation
import UIKit

class SearchTableViewCell: UITableViewCell {
    static let reuseIndetifire = String(describing: SearchTableViewCell.self)
    
    
    
    func cellConfigure(cellviewModel: SearchTableViewCellModel) {
        self.textLabel?.text = cellviewModel.textOfRequest
        self.backgroundColor = .clear
        self.textLabel?.textAlignment = .center
        self.textLabel?.font = UIFont.systemFont(ofSize: 20, weight: .thin)
        self.textLabel?.textColor = .white
        
    }
}
