//
//  ActorCollectionViewCell.swift
//  Movieooze
//
//  Created by Artem Shcherban on 29.08.2021.
//

import UIKit
import SDWebImage
class ActorCollectionViewCell: UICollectionViewCell {
    static  let reuseIndetifire = String(describing: ActorCollectionViewCell.self)
    
    var actorImageView: UIImageView!
    var actorNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func cellConfigure(cellViewModel: ActorsCellCollectionViewModel) {
        self.actorImageView?.image = nil
        self.actorNameLabel?.text = nil
       
        self.backgroundColor = .clear
        self.actorImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 120))
        loadActorImage(gender: cellViewModel.gender, profilePath: cellViewModel.profile_path)
        self.actorImageView.contentMode = .scaleAspectFill
        self.actorImageView.clipsToBounds = true
        self.actorImageView.layer.cornerRadius = 8
        self.addSubview(actorImageView)
  
        self.actorNameLabel = UILabel(frame: CGRect(x: 0, y: 120, width: self.frame.size.width, height: 30))
        self.actorNameLabel.font = UIFont.systemFont(ofSize: 10)
        self.actorNameLabel.textColor = .white
        self.actorNameLabel.textAlignment = .center
        self.actorNameLabel.numberOfLines = 0
        self.actorNameLabel.backgroundColor = .clear
        self.actorNameLabel.text = cellViewModel.name

        self.addSubview(actorNameLabel)
    }
    
    func loadActorImage(gender: Int, profilePath: String) {
        if profilePath == "" {
            if gender  == 1 {
                self.actorImageView?.image = UIImage(named: "noImageFemale")
            } else if gender == 2 {
                self.actorImageView?.image = UIImage(named: "noImageMale")
            } else if gender == 3 {
                self.actorImageView?.image = UIImage(named: "fi-rr-picture")
            } else if gender == 0 {
                self.actorImageView?.image = UIImage(named: "question-mark")
            }
        } else {
            let imageURL = Constants.Network.posterBaseURL + "\(profilePath)"
            self.actorImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "placeholder.png"))
        }
    }
}
