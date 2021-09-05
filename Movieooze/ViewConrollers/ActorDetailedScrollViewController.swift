//
//  ActorDetailedScrollViewController.swift
//  Movieooze
//
//  Created by Artem Shcherban on 28.08.2021.
//

import UIKit
import Alamofire
import SDWebImage
import RealmSwift

class ActorDetailedScrollViewController: UIViewController, UIScrollViewDelegate {
    static let reuseIdentifire = String(describing: ActorDetailedScrollViewController.self)
    
    var scrollView: UIScrollView!
    var headerContainerView: UIView!
    var actorsPhotoImageView: UIImageView!
    var gradientView: UIView!
    var mainContainerView: UIView!
    var nameTextLable, biographyTextLabel, dateOfBirthTextLabel, dateOfDeathTextLabel: UILabel!
    var biographyClearButton: UIButton!
    var biographyButtonPressed = false
    var actorID: Int!
    var actor: ActorDetails? = nil
    var moviesView: UIView!
    var nameOfActorMoviesCollectionViewLabel: UILabel!
    var actorMoviesCollectionView: UICollectionView!
    var layoutActorMovies: UICollectionViewFlowLayout!
    var dividerTopLineView, dividerBottomLineView: UIView!
    var arrayOfActorMovies: [MovieWithActor] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alamofireActorDetailsRequest()
        alamofireActorMoviesRequest()
        createViews()
        setViewConstraints()
        
        // Name Text Lable Customization
        self.nameTextLable.backgroundColor = .clear
        self.nameTextLable.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        self.nameTextLable.textColor = .white
        
        // Biography Text Label Customization
        self.biographyTextLabel.backgroundColor = .clear
        self.biographyTextLabel.font = UIFont.systemFont(ofSize: 15)
        self.biographyTextLabel.textColor = .white
        
        // Date Of Birth Label Customization
        self.dateOfBirthTextLabel.backgroundColor = .clear
        self.dateOfBirthTextLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        self.dateOfBirthTextLabel.textColor = myLightGreyColor
        
        // Date Of Death Text Label Customization
        self.dateOfDeathTextLabel.backgroundColor = .clear
        self.dateOfDeathTextLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        self.dateOfDeathTextLabel.textColor = myLightGreyColor
        
        // Movies View Customization
        self.moviesView.backgroundColor = .clear
        
        
        // Name Of Actor Movies Collection View
        self.nameOfActorMoviesCollectionViewLabel.backgroundColor = .clear
        self.nameOfActorMoviesCollectionViewLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        self.nameOfActorMoviesCollectionViewLabel.textColor = myLightGreyColor
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        // Make the Navigation Bar background transparent
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = .white
        
    }
    
    func createViews() {
        
        // Scroll View
        scrollView = UIScrollView()
        scrollView.backgroundColor = myDarkGreyColor
        scrollView.delegate = self
        self.view.addSubview(scrollView)
        
        // Main Container View
        mainContainerView = UIView()
        mainContainerView.backgroundColor = .clear
        self.scrollView.addSubview(mainContainerView)
        
        // Head Conteiner View
        headerContainerView = UIView()
        headerContainerView.backgroundColor = .black
        self.scrollView.addSubview(headerContainerView)
        
        // Poster View
        actorsPhotoImageView = UIImageView()
        actorsPhotoImageView.clipsToBounds = true
        actorsPhotoImageView.backgroundColor = .black
        actorsPhotoImageView.contentMode = .scaleAspectFill
        self.headerContainerView.addSubview(actorsPhotoImageView)
        
        // Gradient View
        gradientView = UIView()
        
        let newLayer = CAGradientLayer()
        newLayer.colors = [UIColor.clear.cgColor,
                           myDarkGreyColor.cgColor]
        newLayer.endPoint = CGPoint(x: 0.5, y: 0.40)
        newLayer.frame = self.view.frame
        self.gradientView.layer.addSublayer(newLayer)
        self.scrollView.addSubview(gradientView)
        
        
        // Name Text Lable
        nameTextLable = UILabel()
        nameTextLable.numberOfLines = 0
        nameTextLable.baselineAdjustment = .alignBaselines
        self.scrollView.addSubview(nameTextLable)
        
        // Date Of Birth Text Label
        dateOfBirthTextLabel = UILabel()
        dateOfBirthTextLabel.numberOfLines = 1
        dateOfBirthTextLabel.baselineAdjustment = .alignBaselines
        self.scrollView.addSubview(dateOfBirthTextLabel)
        
        // Date Of Death Text Label
        dateOfDeathTextLabel = UILabel()
        dateOfDeathTextLabel.numberOfLines = 1
        dateOfDeathTextLabel.baselineAdjustment = .alignBaselines
        self.scrollView.addSubview(dateOfDeathTextLabel)
        
        // Biography Text Label
        biographyTextLabel = UILabel()
        biographyTextLabel.numberOfLines = 3
        biographyTextLabel.baselineAdjustment = .alignBaselines
        self.scrollView.addSubview(biographyTextLabel)
        
        // Biography Clear Button
        biographyClearButton = UIButton()
        self.biographyClearButton.backgroundColor = .clear
        self.biographyClearButton.addTarget(self, action: #selector(openOverviewLabel), for: .touchUpInside)
        self.scrollView.addSubview(biographyClearButton)
        
        // Movies View
        self.moviesView = UIView()
        self.scrollView.addSubview(moviesView)
        
        // Name Of Collection View Movies
        nameOfActorMoviesCollectionViewLabel = UILabel()
        nameOfActorMoviesCollectionViewLabel.numberOfLines = 1
        nameOfActorMoviesCollectionViewLabel.baselineAdjustment = .alignBaselines
        self.moviesView.addSubview(nameOfActorMoviesCollectionViewLabel)
        
        // Layout Movies
        self.layoutActorMovies = UICollectionViewFlowLayout()
        self.layoutActorMovies.sectionInset = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
        self.layoutActorMovies.itemSize = CGSize(width: 80, height: 160)
        self.layoutActorMovies.scrollDirection = UICollectionView.ScrollDirection.horizontal
        
        // Divider Top Line Actors View
        self.dividerTopLineView = UIView()
        self.dividerTopLineView.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        self.moviesView.addSubview(dividerTopLineView)
        
        // Divider Bottom Line Movies View
        self.dividerBottomLineView = UIView()
        self.dividerBottomLineView.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        self.moviesView.addSubview(dividerBottomLineView)
        
        // Movies Collection View
        self.actorMoviesCollectionView = UICollectionView(frame: self.moviesView.frame, collectionViewLayout: layoutActorMovies)
        self.actorMoviesCollectionView.dataSource = self
        self.actorMoviesCollectionView.delegate = self
        self.actorMoviesCollectionView.register(ActorMoviesCollectionViewCell.self, forCellWithReuseIdentifier: ActorMoviesCollectionViewCell.reuseIndetifire)
        self.actorMoviesCollectionView.backgroundColor = .clear
        self.moviesView.addSubview(actorMoviesCollectionView)
    }
    
    func setViewConstraints() {
        
        // Scroll View Constraints
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
                                     self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                                     self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                                     self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)])
        
        // Main Container View Constraints
        self.mainContainerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.mainContainerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                                     self.mainContainerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                                     self.mainContainerView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 500),
                                     self.mainContainerView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor)])
        
        // Head Conteiner View Constraints
        let headerContainerViewBottom : NSLayoutConstraint!
        self.headerContainerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.headerContainerView.topAnchor.constraint(equalTo: self.view.topAnchor),
                                     self.headerContainerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                                     self.headerContainerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)])
        headerContainerViewBottom = self.headerContainerView.bottomAnchor.constraint(equalTo: self.mainContainerView.topAnchor, constant: -10)
        headerContainerViewBottom.priority = UILayoutPriority(rawValue: 900)
        headerContainerViewBottom.isActive = true
        
        // Poster View Constraints
        let actorsPhotoImageViewTopConstraint: NSLayoutConstraint!
        self.actorsPhotoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.actorsPhotoImageView.leadingAnchor.constraint(equalTo: self.headerContainerView.leadingAnchor),
                                     self.actorsPhotoImageView.trailingAnchor.constraint(equalTo: self.headerContainerView.trailingAnchor),
                                     self.actorsPhotoImageView.bottomAnchor.constraint(equalTo: self.headerContainerView.bottomAnchor)])
        actorsPhotoImageViewTopConstraint = self.actorsPhotoImageView.topAnchor.constraint(equalTo: self.view.topAnchor)
        actorsPhotoImageViewTopConstraint.priority = UILayoutPriority(rawValue: 900)
        actorsPhotoImageViewTopConstraint.isActive = true
        
        // Gradient View Constraints
        self.gradientView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.gradientView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                                     self.gradientView.trailingAnchor.constraint(equalTo: self.view.leadingAnchor),
                                     self.gradientView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
                                     self.gradientView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor)])
        
        // Name Text Lable Constraints
        self.nameTextLable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.nameTextLable.bottomAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 320),
                                     self.nameTextLable.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
                                     self.nameTextLable.widthAnchor.constraint(equalToConstant: 250)])
        
        // Date Of Birth Text Label Constraints
        self.dateOfBirthTextLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.dateOfBirthTextLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
                                     self.dateOfBirthTextLabel.widthAnchor.constraint(equalToConstant: 73),
                                     self.dateOfBirthTextLabel.topAnchor.constraint(equalTo: self.nameTextLable.bottomAnchor, constant: 5)])
        
        // Date Of Death Text Label Constraints
        self.dateOfDeathTextLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.dateOfDeathTextLabel.leadingAnchor.constraint(equalTo: self.dateOfBirthTextLabel.trailingAnchor, constant: 0),
                                     self.dateOfDeathTextLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 60),
                                     self.dateOfDeathTextLabel.topAnchor.constraint(equalTo: self.nameTextLable.bottomAnchor, constant: 5)])
        
        // Biography Text Label Constraints
        self.biographyTextLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.biographyTextLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
                                     self.biographyTextLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
                                     self.biographyTextLabel.topAnchor.constraint(equalTo: self.dateOfBirthTextLabel.bottomAnchor, constant: 16)])
        
        // Overview Clear Button Constraints
        self.biographyClearButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.biographyClearButton.leadingAnchor.constraint(equalTo: self.biographyTextLabel.leadingAnchor),
                                     self.biographyClearButton.trailingAnchor.constraint(equalTo: self.biographyTextLabel.trailingAnchor),
                                     self.biographyClearButton.topAnchor.constraint(equalTo: self.biographyTextLabel.topAnchor),
                                     self.biographyClearButton.bottomAnchor.constraint(equalTo: self.biographyTextLabel.bottomAnchor)])
        
        // Divider Top Line View Constraints
        dividerTopLineView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.dividerTopLineView.leadingAnchor.constraint(equalTo: self.moviesView.leadingAnchor, constant: 18),
                                     self.dividerTopLineView.trailingAnchor.constraint(equalTo: self.moviesView.trailingAnchor),
                                     self.dividerTopLineView.topAnchor.constraint(equalTo: self.moviesView.topAnchor, constant: 8 ),
                                     self.dividerTopLineView.heightAnchor.constraint(equalToConstant: 0.5)])
        
        // Movies View Constraints
        moviesView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.moviesView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                                     self.moviesView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
                                     self.moviesView.topAnchor.constraint(equalTo: self.biographyTextLabel.bottomAnchor, constant: 2 ),
                                     self.moviesView.heightAnchor.constraint(equalToConstant: 190),
                                     self.moviesView.bottomAnchor.constraint(equalTo: self.gradientView.bottomAnchor, constant: -10 )])
        
        // Name Of Collection View Movies Constraints
        nameOfActorMoviesCollectionViewLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.nameOfActorMoviesCollectionViewLabel.leadingAnchor.constraint(equalTo: self.moviesView.leadingAnchor, constant: 18),
                                     self.nameOfActorMoviesCollectionViewLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
                                     self.nameOfActorMoviesCollectionViewLabel.bottomAnchor.constraint(equalTo: self.actorMoviesCollectionView.topAnchor),
                                     self.nameOfActorMoviesCollectionViewLabel.heightAnchor.constraint(equalToConstant: 20)])
        
        // Movies Collection View Constraints
        actorMoviesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.actorMoviesCollectionView.leadingAnchor.constraint(equalTo: self.moviesView.leadingAnchor, constant: 18),
                                     self.actorMoviesCollectionView.trailingAnchor.constraint(equalTo: self.moviesView.trailingAnchor),
                                     self.actorMoviesCollectionView.topAnchor.constraint(equalTo: self.moviesView.topAnchor, constant: 30),
                                     self.actorMoviesCollectionView.bottomAnchor.constraint(equalTo: self.moviesView.bottomAnchor)])
        
        // Divider Bottom Line View Constraints
        dividerBottomLineView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.dividerBottomLineView.leadingAnchor.constraint(equalTo: self.moviesView.leadingAnchor, constant: 18),
                                     self.dividerBottomLineView.trailingAnchor.constraint(equalTo: self.moviesView.trailingAnchor),
                                     self.dividerBottomLineView.topAnchor.constraint(equalTo: self.moviesView.bottomAnchor, constant: 2 ),
                                     self.dividerBottomLineView.heightAnchor.constraint(equalToConstant: 0.5)])
        
    }
    
    func getActorPhoto() {
        var imageURL = ""
        imageURL = posterBaseURL + "\(actor?.profile_path ?? "")"
        self.actorsPhotoImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "placeholder.png"))
    }
    
    func fillActorDetails() {
        
        nameTextLable.text = actor?.name
        biographyTextLabel.text = actor?.biography
        dateOfBirthTextLabel.text = dateFormatDDMMYY(date: actor?.birthday ?? "")
        if actor?.deathday != nil {
            dateOfDeathTextLabel.text = " - \(dateFormatDDMMYY(date: actor?.deathday ?? ""))"
        } else {
            dateOfDeathTextLabel.text = ""
        }
        nameOfActorMoviesCollectionViewLabel.text = "Actor's movies:"
    }
    
    @objc func openOverviewLabel() {
        
        if             biographyButtonPressed == false {
            self.biographyTextLabel.numberOfLines = 0
            biographyButtonPressed = true
            view.layoutIfNeeded()
        } else if             biographyButtonPressed == true {
            self.biographyTextLabel.numberOfLines = 3
            biographyButtonPressed = false
            view.layoutIfNeeded()
        }
    }
    func alamofireActorDetailsRequest() {
        
        AF.request("https://api.themoviedb.org/3/person/\(actorID ?? 0)?api_key=86b8d80830ef6774289e25cad39e4fbd").responseJSON { [self] myJSONresponse in
            
            let decoder = JSONDecoder()
            if let dataOfActor = try? decoder.decode(ActorDetails.self, from: myJSONresponse.data!) {
                self.actor = dataOfActor
                
                self.getActorPhoto()
                self.fillActorDetails()
            }
        }
    }
    
    func alamofireActorMoviesRequest() {
        
        AF.request("https://api.themoviedb.org/3/person/\(actorID ?? 0)/movie_credits?api_key=86b8d80830ef6774289e25cad39e4fbd").responseJSON { [self] myJSONresponse in
            
            let decoder = JSONDecoder()
            if let dataMovies = try? decoder.decode(ResultActor.self, from: myJSONresponse.data!) {
                
                arrayOfActorMovies = dataMovies.cast ?? []
                self.actorMoviesCollectionView.reloadData()
            }
        }
    }
}

extension ActorDetailedScrollViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return  arrayOfActorMovies.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: ActorMoviesCollectionViewCell.reuseIndetifire, for: indexPath) as? ActorMoviesCollectionViewCell  else {return UICollectionViewCell()}
        movieCell.cellConfigure(actorMovie: arrayOfActorMovies[indexPath.row])
        return movieCell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if let movieDetailedScrollViewController = storyboard.instantiateViewController(withIdentifier: MovieDetailedScrollViewController.reuseIdentifire) as? MovieDetailedScrollViewController {
            
            movieDetailedScrollViewController.movieID = arrayOfActorMovies[indexPath.row].id
            
            navigationController?.pushViewController(movieDetailedScrollViewController, animated: true)
        }
    }
}
