//
//  ActorTvShowsCollectionViewCell.swift
//  Movieooze
//
//  Created by Artem Shcherban on 19.10.2021.
//

import UIKit

class ActorTvShowsCollectionViewCell: UICollectionViewCell {
    static  let reuseIndetifire = String(describing: ActorTvShowsCollectionViewCell.self)
    
    var actorTvShowImageView: UIImageView!
    var actorTvShowTitleLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func cellConfigure(cellViewModel: ActorTvShowsCellCollectionViewModel) {
        actorTvShowImageView?.image = nil
        actorTvShowTitleLabel?.text = nil
        
        self.backgroundColor = .clear
        self.actorTvShowImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 120))
        self.actorTvShowImageView.contentMode = .scaleAspectFill
        self.actorTvShowImageView.clipsToBounds = true
        self.actorTvShowImageView.layer.cornerRadius = 8
        self.addSubview(actorTvShowImageView)
        
        self.actorTvShowTitleLabel = UILabel(frame: CGRect(x: 0, y: 120, width: self.frame.size.width, height: 30))
        self.actorTvShowTitleLabel.font = UIFont.systemFont(ofSize: 10)
        self.actorTvShowTitleLabel.textColor = .white
        self.actorTvShowTitleLabel.textAlignment = .center
        self.actorTvShowTitleLabel.numberOfLines = 0
        self.actorTvShowTitleLabel.backgroundColor = .clear
        self.actorTvShowTitleLabel.text = cellViewModel.nameOfTvShow
        self.addSubview(actorTvShowTitleLabel)
        
        loadTvShowPoster(posterPath: cellViewModel.posterPath)
        
    }
    
    func loadTvShowPoster(posterPath: String) {
        if posterPath == "" {
            self.actorTvShowImageView.image = UIImage(named: "question-mark")
        } else {
            let imageURL = Constants.Network.posterBaseURL + "\(posterPath)"
            self.actorTvShowImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "placeholder.png"))
        }
    }
    
}
