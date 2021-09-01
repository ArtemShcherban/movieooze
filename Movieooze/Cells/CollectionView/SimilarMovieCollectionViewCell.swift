//
//  MovieCollectionViewCell.swift
//  Movieooze
//
//  Created by Artem Shcherban on 31.08.2021.
//

import UIKit
import  SDWebImage
class SimilarMovieCollectionViewCell: UICollectionViewCell {
    static  let reuseIndetifire = String(describing: SimilarMovieCollectionViewCell.self)
    
    var similarMovieImageView: UIImageView!
    var similarMovieTitleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func cellConfigure(similarMovie: SimilarMovie) {
        self.similarMovieImageView?.image = nil
        self.similarMovieTitleLabel?.text = nil

        self.backgroundColor = .clear
        self.similarMovieImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 120))
        self.similarMovieImageView.contentMode = .scaleAspectFill
        self.similarMovieImageView.clipsToBounds = true
        self.similarMovieImageView.layer.cornerRadius = 8
        self.addSubview(similarMovieImageView)

        self.similarMovieTitleLabel = UILabel(frame: CGRect(x: 0, y: 120, width: self.frame.size.width, height: 30))
        self.similarMovieTitleLabel.font = UIFont.systemFont(ofSize: 10)
        self.similarMovieTitleLabel.textColor = .white
        self.similarMovieTitleLabel.textAlignment = .center
        self.similarMovieTitleLabel.numberOfLines = 0
        self.similarMovieTitleLabel.backgroundColor = .clear
        self.similarMovieTitleLabel.text = similarMovie.title
        self.addSubview(similarMovieTitleLabel)
////  🧐 Убрать print
        print(similarMovieTitleLabel ?? "")
        let imageURL = posterBaseURL + "\(similarMovie.poster_path ?? "")"
        self.similarMovieImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "placeholder.png"))
    }
}
