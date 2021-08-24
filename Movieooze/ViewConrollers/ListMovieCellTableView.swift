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

    
    
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleMovieTextLabel: UILabel!
    @IBOutlet weak var rightArrowView: UIImageView!
    @IBOutlet weak var yearTextLabel: UILabel!
    @IBOutlet weak var genresTextLabel: UILabel!
    @IBOutlet weak var starsImageView: UIImageView!
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func cellConfigure(movie: Movie) {
        

        let imageURL = posterBaseURL + "\(movie.posterPath ?? "")"
        self.posterView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "placeholder.png"))
        self.posterView.layer.cornerRadius = 8

        self.titleMovieTextLabel.text = movie.title
        self.yearTextLabel.text = dateFormat(date: movie.releaseDate ?? "")
        self.rightArrowView.image = UIImage.init(named: "fi-rr-angle-small-right-grey")
        self.genresTextLabel.text = ("\(dicGenres[movie.genreIds?[0] ?? 0]?.name ?? "")" + ", " + "\(dicGenres[movie.genreIds?[1] ?? 0]?.name ?? "")")
        let starsLevel = movie.voteAverage
        self.starsImageView.image = movieStarsLevel(level: starsLevel ?? 0)
    }
}



