//
//  EpisodeTableViewCell.swift
//  Movieooze
//
//  Created by Artem Shcherban on 02.10.2021.
//

import UIKit
import SDWebImage

class EpisodeTableViewCell: UITableViewCell {
    static let reuseIdentifire = String(describing: EpisodeTableViewCell.self)
    
    var episodeImageView: UIImageView!
    var overviewTextLabel: UILabel!
    var episodeNumberTextLabel: UILabel!
    var episodeAirDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func cellConfigure(cellViewModel: EpisodeCellViewModel) {
        self.episodeImageView?.image = nil
        self.overviewTextLabel?.text = nil
        self.episodeNumberTextLabel?.text = nil
        self.episodeAirDate?.text = nil
        
        createViews()
        setViewConstraints()
        getEpisodeImage(episodeImagePath: cellViewModel.episodeStill_path)
        self.backgroundColor = .clear
//        self.backgroundColor = Constants.MyColors.myDarkGreyColor
        self.selectionStyle = .none
        self.episodeNumberTextLabel.text = cellViewModel.episodeName
        self.episodeAirDate.text = cellViewModel.episodeAir_date
        
        if cellViewModel.episodeOverview == "" {
            overviewTextLabel.text = "Coming soon"
        } else {
            self.overviewTextLabel.text = cellViewModel.episodeOverview
        }
    }
    
    func createViews() {
        // Create Episode Number Text Label
        episodeNumberTextLabel = UILabel()
        episodeNumberTextLabel.backgroundColor = .clear
        episodeNumberTextLabel.numberOfLines = 1
        episodeNumberTextLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        episodeNumberTextLabel.textColor = Constants.MyColors.myLightGreyColor
        self.addSubview(episodeNumberTextLabel)
        
        // Create Episode Air Date Text Label
        episodeAirDate = UILabel()
        episodeAirDate.backgroundColor = .clear
        episodeAirDate.numberOfLines = 1
        episodeAirDate.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        episodeAirDate.textColor = Constants.MyColors.myLightGreyColor
        self.addSubview(episodeAirDate)
        
        // Create Episode Poster Image View
        episodeImageView = UIImageView()
        episodeImageView.backgroundColor = .clear
        episodeImageView.clipsToBounds = true
        episodeImageView.contentMode = .scaleAspectFill
        episodeImageView.layer.cornerRadius = 8
        self.addSubview(episodeImageView)
        
        // Create Overview Text Label
        overviewTextLabel = UILabel()
        overviewTextLabel.backgroundColor = .clear
        overviewTextLabel.numberOfLines = 5
        overviewTextLabel.font = UIFont.systemFont(ofSize: 13, weight: .thin)
        overviewTextLabel.textColor = .white
        self.addSubview(overviewTextLabel)
    }
    
    func setViewConstraints() {
        
        //  Set Episode Number Text Label Constraints
        episodeNumberTextLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.episodeNumberTextLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
                                     self.episodeNumberTextLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12), self.episodeNumberTextLabel.heightAnchor.constraint(equalToConstant: 15)])
        
        //  Set Episode Air Date Text Label Constraints
        episodeAirDate.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.episodeAirDate.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
                                     self.episodeAirDate.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12), self.episodeAirDate.heightAnchor.constraint(equalToConstant: 15)])
        
        //  Set Episode Poster Image View Constraints
        episodeImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([episodeImageView.topAnchor.constraint(equalTo: self.episodeNumberTextLabel.bottomAnchor, constant: 4),
                                     episodeImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12), self.episodeImageView.widthAnchor.constraint(equalToConstant: 142),
                                     self.episodeImageView.heightAnchor.constraint(equalToConstant: 80)])
        
        
        //  Set Overview Text Label Constraints
        overviewTextLabel.translatesAutoresizingMaskIntoConstraints =  false
        NSLayoutConstraint.activate([self.overviewTextLabel.topAnchor.constraint(equalTo: self.episodeImageView.topAnchor, constant: 0),
                                     self.overviewTextLabel.leadingAnchor.constraint(equalTo: self.episodeImageView.trailingAnchor, constant: 8),
                                     self.overviewTextLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8)])
        
    }
    
    func getEpisodeImage(episodeImagePath: String) {
        if episodeImagePath == "" {
            self.episodeImageView.image = UIImage(named: "question-mark 142x80")
            self.episodeImageView.contentMode = .scaleAspectFit
            self.episodeImageView.layer.borderWidth = 1
            self.episodeImageView.layer.borderColor = Constants.MyColors.myLightGreyColor.cgColor
        } else {
            let imageURL = Constants.Network.posterBaseURL + "\(episodeImagePath)"
            self.episodeImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "placeholder.png"))
        }
    }
}
