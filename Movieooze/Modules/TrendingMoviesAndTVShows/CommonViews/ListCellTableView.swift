//
//  ListCellTableView.swift
//
//
//  Created by Artem Shcherban on 21.08.2021.
//


import UIKit
import SDWebImage

class ListCellTableView: UITableViewCell {
    
    static let reuseIdentifier = String(describing: ListCellTableView.self)
 
    var titleMovieTextLabel: UILabel!
    var yearTextLabel: UILabel!
    var genresTextLabel: UILabel!
    
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var rightArrowView: UIImageView!
    @IBOutlet weak var starsImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        createLabels()
        setLabelsConstaints()
        
        // Title Movie Text Label Customization
        self.titleMovieTextLabel.backgroundColor = .clear
        self.titleMovieTextLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        self.titleMovieTextLabel.textColor = .white
        
        // Year Text Label Customization
        self.yearTextLabel.backgroundColor = .clear
        self.yearTextLabel.font = UIFont.systemFont(ofSize: 12)
        self.yearTextLabel.textColor = Constants.MyColors.myLightGreyColor
        
        
        // Genres Text Label Customization
        self.genresTextLabel.backgroundColor = .clear
        self.genresTextLabel.font = UIFont.systemFont(ofSize: 12)
        self.genresTextLabel.textColor = Constants.MyColors.myLightGreyColor
    }
    

    func cellConfigureMovie(cellViewModel: MoviesCellViewModel) {
        self.getStarsLevel(starsLevel: cellViewModel.voteAverage)
        self.getPoster(posterImagePath: cellViewModel.posterPath)
        self.posterView.layer.cornerRadius = 8
        
        self.titleMovieTextLabel.text = cellViewModel.title
        self.yearTextLabel.text = cellViewModel.releaseDate
        self.rightArrowView.image = UIImage.init(named: "fi-rr-angle-small-right-grey")
        self.genresTextLabel.text = cellViewModel.movieGenres
    }
    
    func cellConfigureTVShow(cellViewModel: TvShowCellViewModel) {
        self.getStarsLevel(starsLevel: cellViewModel.vote_average)
        self.getPoster(posterImagePath: cellViewModel.poster_path)
        self.posterView.layer.cornerRadius = 8
        
        self.titleMovieTextLabel.text = cellViewModel.name
        self.yearTextLabel.text = cellViewModel.first_air_date
        self.rightArrowView.image = UIImage.init(named: "fi-rr-angle-small-right-grey")
        self.genresTextLabel.text = cellViewModel.tvShowGenre
    }
        
    func createLabels() {
        
        // Title Movie Text Label
        titleMovieTextLabel = UILabel()
        titleMovieTextLabel.numberOfLines = 3
        titleMovieTextLabel.baselineAdjustment = .alignBaselines
        self.contentView.addSubview(titleMovieTextLabel)
        
        // Year Text Label
        yearTextLabel = UILabel()
        yearTextLabel.baselineAdjustment = .alignBaselines
        self.contentView.addSubview(yearTextLabel)
        
        // Genres Text Label Customization
        genresTextLabel = UILabel()
        genresTextLabel.baselineAdjustment = .alignBaselines
        self.contentView.addSubview(genresTextLabel)
    }
    
    func getPoster(posterImagePath: String) {
        self.posterView.layer.borderColor = nil
        if posterImagePath == "" {
            self.posterView.image = UIImage(named: "question-mark")
            self.posterView.layer.borderWidth = 1
            self.posterView.layer.borderColor = Constants.MyColors.myLightGreyColor.cgColor
        } else {
            let imageURL = Constants.Network.posterBaseURL + "\(posterImagePath)"
            self.posterView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "placeholder.png"))
        }
    }
    
    func setLabelsConstaints(){
        
        // Title Movie Text Label Constraints
        self.titleMovieTextLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.titleMovieTextLabel.leadingAnchor.constraint(equalTo: self.posterView.trailingAnchor, constant: 8),
                                     self.titleMovieTextLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -90),
                                     self.titleMovieTextLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8)
        ])
        
        // Year Text Label Constraints
        self.yearTextLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.yearTextLabel.leadingAnchor.constraint(equalTo: self.posterView.trailingAnchor, constant: 8),
                                     self.yearTextLabel.heightAnchor.constraint(equalToConstant: 15),
                                     self.yearTextLabel.topAnchor.constraint(equalTo: self.titleMovieTextLabel.bottomAnchor, constant: 2)
        ])
        
        // Genres Text Label Constraints
        self.genresTextLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.genresTextLabel.leadingAnchor.constraint(equalTo: self.yearTextLabel.trailingAnchor, constant: 4),
                                     self.genresTextLabel.heightAnchor.constraint(equalToConstant: 15),
                                     self.genresTextLabel.topAnchor.constraint(equalTo: self.titleMovieTextLabel.bottomAnchor, constant: 2)])
    }
    
    func getStarsLevel(starsLevel: Double) {
        starsImageView.image = StarsLevel.movieOrTvShowStarsLevel(level: starsLevel)
    }
}


