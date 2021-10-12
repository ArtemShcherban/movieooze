//
//  ActorCollectionViewCell.swift
//  Movieooze
//
//  Created by Artem Shcherban on 30.09.2021.
//


import UIKit
import SDWebImage

class SeasonCollectionViewCell: UICollectionViewCell {
    static let reuseIndetifire = String(describing: SeasonCollectionViewCell.self)
    
    var seasonImageView: UIImageView!
    var seasonTitleLabel: UILabel!
    
    func cellConfigure(cellViewModel: SeasonsCellCollectionViewModel){
        self.seasonImageView?.image = nil
        self.seasonTitleLabel?.text = nil
        
        self.backgroundColor = .clear
        self.seasonImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 120))
        self.seasonImageView.contentMode = .scaleAspectFill
        self.seasonImageView.clipsToBounds = true
        self.seasonImageView.layer.cornerRadius = 8
        self.loadSeasonImage(posterPath: cellViewModel.poster_path)
        self.addSubview(self.seasonImageView)
        
        self.seasonTitleLabel = UILabel(frame: CGRect(x: 0, y: 120, width: self.frame.width, height: self.frame.height - self.seasonImageView.frame.height))
        self.seasonTitleLabel.backgroundColor = .clear
        self.seasonTitleLabel.font = UIFont.systemFont(ofSize: 10)
        self.seasonTitleLabel.textColor = .white
        self.seasonTitleLabel.textAlignment = .center
        self.seasonTitleLabel.text = cellViewModel.name
        self.addSubview(self.seasonTitleLabel)
    }
    
    func loadSeasonImage(posterPath: String) {
        if posterPath == "" {
                self.seasonImageView?.image = UIImage(named: "question-mark")
        } else {
            let imageURL = Constants.Network.posterBaseURL + "\(posterPath)"
            self.seasonImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "placeholder.png"))
        }
    }
}
