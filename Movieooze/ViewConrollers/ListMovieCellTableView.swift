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
    
    func cellConfigure(with index: Int) {
        

        let imageURL = posterBaseURL + "\(arrayOfMovies[index].posterPath ?? "")"
        self.posterView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "placeholder.png"))
        self.posterView.layer.cornerRadius = 8
        
        
        self.titleMovieTextLabel.text = arrayOfMovies[index].title
        self.yearTextLabel.text = dateFormat(date: arrayOfMovies[index].releaseDate ?? "")
        self.rightArrowView.image = UIImage.init(named: "fi-rr-angle-small-right-grey")
        let movieGenresFirstId = arrayOfMovies[index].genreIds?[0]
        self.genresTextLabel.text = dicGenres[movieGenresFirstId ?? 0]?.name
        let starsLevel = arrayOfMovies[index].voteAverage
        self.starsImageView.image = movieStarsLevel(level: starsLevel ?? 0)
    }
    
    func cellRealmConfigure(with index: Int) {
        

        let imageURL = posterBaseURL + "\(arrayOfMoviesForFavorites[index].posterPath )"
        self.posterView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "placeholder.png"))
        self.posterView.layer.cornerRadius = 8
        
        self.titleMovieTextLabel.text = arrayOfMoviesForFavorites[index].title
        self.yearTextLabel.text = dateFormat(date: arrayOfMoviesForFavorites[index].releaseDate )
        self.rightArrowView.image = UIImage.init(named: "fi-rr-angle-small-right-grey")
        let movieGenresFirstId = arrayOfMoviesForFavorites[index].genreIdFirst
        self.genresTextLabel.text = dicGenres[movieGenresFirstId]?.name
        let starsLevel = arrayOfMoviesForFavorites[index].voteAverage
        self.starsImageView.image = movieStarsLevel(level: starsLevel )
    }
    
}



