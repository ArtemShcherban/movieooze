//
//  ActorDetailedScrollViewController.swift
//  Movieooze
//
//  Created by Artem Shcherban on 28.08.2021.
//

import UIKit
import SDWebImage
import RealmSwift

class ActorDetailedScrollViewController: UIViewController, UIScrollViewDelegate {
    static let reuseIdentifire = String(describing: ActorDetailedScrollViewController.self)
    
    var actorDetailedViewModel: ActorDetailedViewModel!
    var actorMoviesCollectionViewModel: ActorMoviesCollectionViewModel!
    var scrollView: UIScrollView!
    var headerContainerView: UIView!
    var actorsPhotoImageView: UIImageView!
    var gradientView: UIView!
    var mainContainerView: UIView!
    var nameTextLable, biographyTextLabel, dateOfBirthTextLabel, dateOfDeathTextLabel, placeOfBirth: UILabel!
    var arrayOfTextLabels: [UILabel] = []
    var biographyClearButton: UIButton!
    var biographyButtonPressed = false
    var actorID: Int!
    var moviesView: UIView!
    var nameOfActorMoviesCollectionViewLabel: UILabel!
    var actorMoviesCollectionView: UICollectionView!
    var layoutActorMovies: UICollectionViewFlowLayout!
    var dividerTopLineMoviesView, dividerBottomLineMoviesView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.actorDetailedViewModel = ActorDetailedViewModel()
        self.actorMoviesCollectionViewModel = ActorMoviesCollectionViewModel()
        
        actorDetailedViewModel.actorDetailsRequest(actorID: actorID, completion: {
                            self.getActorPhoto()
                            self.fillActorDetails()
                            self.setTitleForBackButton()
        })
        actorMoviesCollectionViewModel.actorMoviesRequest(actorID: actorID, completion: {
            self.actorMoviesCollectionView.reloadData()
        })
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
        
        // Date Of Birth Label, Date Of Death Text Label, Place Of Birth Label Customization
        for textLabel in arrayOfTextLabels {
            textLabel.backgroundColor = .clear
            textLabel.font = UIFont.systemFont(ofSize: 13, weight: .thin)
            textLabel.textColor = .white
        }

        // Movies View Customization
        self.moviesView.backgroundColor = .clear
        
        
        // Name Of Actor Movies Collection View
        self.nameOfActorMoviesCollectionViewLabel.backgroundColor = .clear
        self.nameOfActorMoviesCollectionViewLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        self.nameOfActorMoviesCollectionViewLabel.textColor = Constants.MyColors.myLightGreyColor
        
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
        scrollView.backgroundColor = Constants.MyColors.myDarkGreyColor
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
                           Constants.MyColors.myDarkGreyColor.cgColor]
        newLayer.endPoint = CGPoint(x: 0.5, y: 0.40)
        newLayer.frame = self.view.frame
        self.gradientView.layer.addSublayer(newLayer)
        self.scrollView.addSubview(gradientView)
        
        
        // Name Text Lable
        nameTextLable = UILabel()
        nameTextLable.numberOfLines = 0
        nameTextLable.baselineAdjustment = .alignBaselines
        self.scrollView.addSubview(nameTextLable)
        
        // Date Of Birth Text Label, Date Of Death Text Label, Place Of Birth Text Label
        dateOfBirthTextLabel = UILabel(); dateOfDeathTextLabel = UILabel(); placeOfBirth = UILabel()
        arrayOfTextLabels = [dateOfBirthTextLabel, dateOfDeathTextLabel, placeOfBirth]
        for textLabel in arrayOfTextLabels {
            textLabel.numberOfLines = 1
            textLabel.baselineAdjustment = .alignBaselines
            self.scrollView.addSubview(textLabel)
        }

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
        self.layoutActorMovies.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 4)
        self.layoutActorMovies.itemSize = CGSize(width: 80, height: 150)
        self.layoutActorMovies.scrollDirection = UICollectionView.ScrollDirection.horizontal
        
        // Divider Top Line Movies View
        self.dividerTopLineMoviesView = UIView()
        self.dividerTopLineMoviesView.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        self.moviesView.addSubview(dividerTopLineMoviesView)
                
        // Movies Collection View
        self.actorMoviesCollectionView = UICollectionView(frame: self.moviesView.frame, collectionViewLayout: layoutActorMovies)
        self.actorMoviesCollectionView.dataSource = self
        self.actorMoviesCollectionView.delegate = self
        self.actorMoviesCollectionView.register(ActorMoviesCollectionViewCell.self, forCellWithReuseIdentifier: ActorMoviesCollectionViewCell.reuseIndetifire)
        self.actorMoviesCollectionView.backgroundColor = .clear
        self.moviesView.addSubview(actorMoviesCollectionView)
        
        // Divider Bottom Line Movies View
        self.dividerBottomLineMoviesView = UIView()
        self.dividerBottomLineMoviesView.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        self.moviesView.addSubview(dividerBottomLineMoviesView)
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
                                     self.mainContainerView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 400),
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
                                     self.nameTextLable.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 12),
                                     self.nameTextLable.widthAnchor.constraint(equalToConstant: 250)])
        
        // Date Of Birth Text Label Constraints
        self.dateOfBirthTextLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.dateOfBirthTextLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 12),
                                     self.dateOfBirthTextLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 0),
                                     self.dateOfBirthTextLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 13),
                                     self.dateOfBirthTextLabel.topAnchor.constraint(equalTo: self.nameTextLable.bottomAnchor, constant: 5)])
        
        // Date Of Death Text Label Constraints
        self.dateOfDeathTextLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.dateOfDeathTextLabel.leadingAnchor.constraint(equalTo: self.dateOfBirthTextLabel.trailingAnchor, constant: 0),
                                     self.dateOfDeathTextLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 0),
                                     self.dateOfDeathTextLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 13),
                                     self.dateOfDeathTextLabel.topAnchor.constraint(equalTo: self.nameTextLable.bottomAnchor, constant: 5)])
        
        // Place of Birth Text Label Constraints
        self.placeOfBirth.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.placeOfBirth.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 12),
                                     self.placeOfBirth.widthAnchor.constraint(lessThanOrEqualTo: self.view.widthAnchor, constant: -40),
                                     self.placeOfBirth.heightAnchor.constraint(lessThanOrEqualToConstant: 13),
                                     self.placeOfBirth.topAnchor.constraint(equalTo: self.dateOfBirthTextLabel.bottomAnchor, constant: 4)])
        
        // Biography Text Label Constraints
        self.biographyTextLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.biographyTextLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 12),
                                     self.biographyTextLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
                                     self.biographyTextLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0),
                                     self.biographyTextLabel.topAnchor.constraint(equalTo: self.placeOfBirth.bottomAnchor, constant: 8)])
        
        // Biography Clear Button Constraints
        self.biographyClearButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.biographyClearButton.leadingAnchor.constraint(equalTo: self.biographyTextLabel.leadingAnchor),
                                     self.biographyClearButton.trailingAnchor.constraint(equalTo: self.biographyTextLabel.trailingAnchor),
                                     self.biographyClearButton.topAnchor.constraint(equalTo: self.biographyTextLabel.topAnchor),
                                     self.biographyClearButton.bottomAnchor.constraint(equalTo: self.biographyTextLabel.bottomAnchor)])
        
        // Movies View Constraints
        moviesView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.moviesView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                                     self.moviesView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -12),
                                     self.moviesView.topAnchor.constraint(equalTo: self.biographyTextLabel.bottomAnchor, constant: 4),
                                     self.moviesView.heightAnchor.constraint(equalToConstant: 180),
                                     self.moviesView.bottomAnchor.constraint(equalTo: self.gradientView.bottomAnchor, constant: -10)])
        
        // Divider Top Line Movies View Constraints
        dividerTopLineMoviesView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.dividerTopLineMoviesView.leadingAnchor.constraint(equalTo: self.moviesView.leadingAnchor, constant: 12),
                                     self.dividerTopLineMoviesView.trailingAnchor.constraint(equalTo: self.moviesView.trailingAnchor),
                                     self.dividerTopLineMoviesView.topAnchor.constraint(equalTo: self.moviesView.topAnchor, constant: 4 ),
                                     self.dividerTopLineMoviesView.heightAnchor.constraint(equalToConstant: 0.5)])
        
        // Name Of Collection View Movies Constraints
        nameOfActorMoviesCollectionViewLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.nameOfActorMoviesCollectionViewLabel.leadingAnchor.constraint(equalTo: self.moviesView.leadingAnchor, constant: 12),
                                     self.nameOfActorMoviesCollectionViewLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -12),
                                     self.nameOfActorMoviesCollectionViewLabel.bottomAnchor.constraint(equalTo: self.actorMoviesCollectionView.topAnchor, constant: -4),
                                     self.nameOfActorMoviesCollectionViewLabel.heightAnchor.constraint(equalToConstant: 20)])
        
        // Movies Collection View Constraints
        actorMoviesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.actorMoviesCollectionView.leadingAnchor.constraint(equalTo: self.moviesView.leadingAnchor, constant: 12),
                                     self.actorMoviesCollectionView.trailingAnchor.constraint(equalTo: self.moviesView.trailingAnchor),
                                     self.actorMoviesCollectionView.topAnchor.constraint(equalTo: self.moviesView.topAnchor, constant: 30),
                                     self.actorMoviesCollectionView.bottomAnchor.constraint(equalTo: self.moviesView.bottomAnchor)])
        
        // Divider Bottom Line Movies View Constraints
        dividerBottomLineMoviesView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.dividerBottomLineMoviesView.leadingAnchor.constraint(equalTo: self.moviesView.leadingAnchor, constant: 12),
                                     self.dividerBottomLineMoviesView.trailingAnchor.constraint(equalTo: self.moviesView.trailingAnchor),
                                     self.dividerBottomLineMoviesView.topAnchor.constraint(equalTo: self.moviesView.bottomAnchor, constant: 4),
                                     self.dividerBottomLineMoviesView.heightAnchor.constraint(equalToConstant: 0.5)])
        
    }
    
    func setTitleForBackButton() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: self.actorDetailedViewModel.name[0..<25] , style: .plain, target: self, action: nil)
        
    }
    
    func getActorPhoto() {
        var imageURL = ""
        imageURL = Constants.Network.posterBaseURL + "\(actorDetailedViewModel.profile_path)"
        self.actorsPhotoImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "placeholder.png"))
    }
    
    func fillActorDetails() {
        
        nameTextLable.text = actorDetailedViewModel.name
        biographyTextLabel.text = actorDetailedViewModel.biography
        dateOfBirthTextLabel.text = actorDetailedViewModel.birthday
        dateOfDeathTextLabel.text = actorDetailedViewModel.deathday
        placeOfBirth.text = actorDetailedViewModel.place_of_birth
        nameOfActorMoviesCollectionViewLabel.text = "Actor's movies:"

    }
    
    @objc func openOverviewLabel() {
        
        if  biographyButtonPressed == false {
            self.biographyTextLabel.numberOfLines = 0
            biographyButtonPressed = true
            view.layoutIfNeeded()
        } else if             biographyButtonPressed == true {
            self.biographyTextLabel.numberOfLines = 3
            biographyButtonPressed = false
            view.layoutIfNeeded()
        }
    }
}

extension ActorDetailedScrollViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return  actorMoviesCollectionViewModel.numberOfRows()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: ActorMoviesCollectionViewCell.reuseIndetifire, for: indexPath) as? ActorMoviesCollectionViewCell  else {return UICollectionViewCell()}
        let cellViewModel = actorMoviesCollectionViewModel.createCellViewModel(indexPath: indexPath)
        movieCell.cellConfigure(cellViewModel: cellViewModel)
        return movieCell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if let movieDetailedScrollViewController = storyboard.instantiateViewController(withIdentifier: MovieDetailedScrollViewController.reuseIdentifire) as? MovieDetailedScrollViewController {
            
            movieDetailedScrollViewController.movieID = actorMoviesCollectionViewModel.arrayOfActorMovies[indexPath.row].id
            
            navigationController?.pushViewController(movieDetailedScrollViewController, animated: true)
        }
    }
}
