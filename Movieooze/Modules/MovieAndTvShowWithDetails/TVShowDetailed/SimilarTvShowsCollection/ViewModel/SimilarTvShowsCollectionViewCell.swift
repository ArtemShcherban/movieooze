//
//  SimilarTvShowsCollectionViewCell.swift
//  Movieooze
//
//  Created by Artem Shcherban on 18.10.2021.
//

import UIKit
import  SDWebImage

class SimilarTvShowsCollectionViewCell: UICollectionViewCell {
    static  let reuseIndetifire = String(describing: SimilarTvShowsCollectionViewCell.self)
    
    var similarTvShowImageView: UIImageView!
    var similarTvShowTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func cellConfigure(cellViewModel: SimilarTvShowsCellCollectionViewModel) {
        self.similarTvShowImageView?.image = nil
        self.similarTvShowTitleLabel?.text = nil

        self.backgroundColor = .clear
        self.similarTvShowImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 120))
        self.similarTvShowImageView.contentMode = .scaleAspectFill
        self.similarTvShowImageView.clipsToBounds = true
        self.similarTvShowImageView.layer.cornerRadius = 8
        self.addSubview(similarTvShowImageView)

        self.similarTvShowTitleLabel = UILabel(frame: CGRect(x: 0, y: 120, width: self.frame.size.width, height: 30))
        self.similarTvShowTitleLabel.font = UIFont.systemFont(ofSize: 10)
        self.similarTvShowTitleLabel.textColor = .white
        self.similarTvShowTitleLabel.textAlignment = .center
        self.similarTvShowTitleLabel.numberOfLines = 0
        self.similarTvShowTitleLabel.backgroundColor = .clear
        self.similarTvShowTitleLabel.text = cellViewModel.title
        self.addSubview(similarTvShowTitleLabel)
        self.loadTvShowPoster(posterPath: cellViewModel.posterPath)

    }
    
    func loadTvShowPoster(posterPath: String) {
        if posterPath == "" {
            self.similarTvShowImageView.image = UIImage(named: "question-mark")
            self.similarTvShowImageView.layer.borderWidth = 1
            self.similarTvShowImageView.layer.borderColor = Constants.MyColors.myLightGreyColor.cgColor
        } else {
            let imageURL = Constants.Network.posterBaseURL + "\(posterPath)"
            self.similarTvShowImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "placeholder.png"))
        }
    }
    
}
