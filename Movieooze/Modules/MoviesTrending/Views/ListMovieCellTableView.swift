//
//  ListMovieCellTableView.swift
//
//
//  Created by Artem Shcherban on 21.08.2021.
//


import UIKit
import SDWebImage

class ListMovieCellTableView: UITableViewCell {
    
    static let reuseIdentifire = String(describing: ListMovieCellTableView.self)
 
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
        
        // Title Movie Text Label Constraints Customization
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
    

    func cellConfigure(cellViewModel: MoviesTrendingCellViewModel) {
        
        let imageURL = Constants.Network.posterBaseURL + "\(cellViewModel.posterPath )"
        self.posterView.sd_setImage(with: URL(string: imageURL), completed: nil)
        self.posterView.layer.cornerRadius = 8
        
        self.titleMovieTextLabel.text = cellViewModel.title
        self.yearTextLabel.text = cellViewModel.releaseDate
        self.rightArrowView.image = UIImage.init(named: "fi-rr-angle-small-right-grey")
        let starsLevel = cellViewModel.voteAverage
        self.starsImageView.image = movieStarsLevel(level: starsLevel)
        self.genresTextLabel.text = cellViewModel.movieGenres
    }
    
//    func numberOfGenres(movie: Movie) {
//        if movie.genreIds?.count ?? 0 >= 2 {
//            self.genresTextLabel.text = ("\(dicGenres[movie.genreIds?[0] ?? 0]?.name ?? "")" + ", " + "\(dicGenres[movie.genreIds?[1] ?? 0]?.name ?? "")")
//        } else {
//            self.genresTextLabel.text = ("\(dicGenres[movie.genreIds?[0] ?? 0]?.name ?? "")")
//        }
//    }
    
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
    
    func movieStarsLevel(level: Double) -> UIImage? {
       
        var starsLevelResult = UIImage(named: "fi-rr-0_5star_orange")
        
        switch level {
        case 9.5...10:
            starsLevelResult = UIImage(named: "fi-rr-5stars_orange")
        case 8.5..<9.5:
            starsLevelResult = UIImage(named: "fi-rr-4_5stars_orange")
        case 7.5..<8.5:
            starsLevelResult = UIImage(named: "fi-rr-4stars_orange")
        case 6.5..<7.5:
            starsLevelResult = UIImage(named: "fi-rr-3_5stars_orange")
        case 5.5..<6.5:
            starsLevelResult = UIImage(named: "fi-rr-3stars_orange")
        case 4.5..<5.5:
            starsLevelResult = UIImage(named: "fi-rr-2_5stars_orange")
        case 3.5..<4.5:
            starsLevelResult = UIImage(named: "fi-rr-2stars_orange")
        case 2.5..<3.5:
            starsLevelResult = UIImage(named: "fi-rr-1_5stars_orange")
        case 1.5..<2.5:
            starsLevelResult = UIImage(named: "fi-rr-1star_orange")
        case 0.0..<1.5:
            starsLevelResult = UIImage(named: "fi-rr-0_5star_orange")
        default:
            break
        }
        return starsLevelResult
    }
}


