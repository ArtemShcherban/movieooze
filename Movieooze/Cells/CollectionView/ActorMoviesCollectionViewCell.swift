//
//  MovieCollectionViewCell.swift
//  Movieooze
//
//  Created by Artem Shcherban on 31.08.2021.
//

import UIKit
import  SDWebImage
class ActorMoviesCollectionViewCell: UICollectionViewCell {
    static  let reuseIndetifire = String(describing: ActorMoviesCollectionViewCell.self)
    
    var actorMovieImageView: UIImageView!
    var actorMovieTitleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func cellConfigure(actorMovie: MovieWithActor) {
        self.actorMovieImageView?.image = nil
        self.actorMovieTitleLabel?.text = nil
        
        self.backgroundColor = .clear
        self.actorMovieImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 120))
        self.actorMovieImageView.contentMode = .scaleAspectFill
        self.actorMovieImageView.clipsToBounds = true
        self.actorMovieImageView.layer.cornerRadius = 8
        self.addSubview(actorMovieImageView)
        
        self.actorMovieTitleLabel = UILabel(frame: CGRect(x: 0, y: 120, width: self.frame.size.width, height: 30))
        self.actorMovieTitleLabel.font = UIFont.systemFont(ofSize: 10)
        self.actorMovieTitleLabel.textColor = .white
        self.actorMovieTitleLabel.textAlignment = .center
        self.actorMovieTitleLabel.numberOfLines = 0
        self.actorMovieTitleLabel.backgroundColor = .clear
        self.actorMovieTitleLabel.text = actorMovie.title
        loadMoviePoster(actorMovie: actorMovie)
        self.addSubview(actorMovieTitleLabel)
    }
    func loadMoviePoster(actorMovie: MovieWithActor) {
        if actorMovie.poster_path == nil {
            self.actorMovieImageView.image = UIImage(named: "question-mark")
        } else {
            let imageURL = posterBaseURL + "\(actorMovie.poster_path ?? "")"
            self.actorMovieImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "placeholder.png"))
        }
    }
}
