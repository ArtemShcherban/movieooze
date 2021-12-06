//
//  PersonTableViewCell.swift
//  Movieooze
//
//  Created by Artem Shcherban on 05.12.2021.
//

import UIKit

class PersonTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = String(describing: PersonTableViewCell.self)

    @IBOutlet weak var personImageView: UIImageView!
    @IBOutlet weak var rightArrowView: UIImageView!
    
    var personNameTextLabel: UILabel!
    var personKnownForDepTextLabel: UILabel!
    var personKnownForTextLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .systemTeal
        
        setLabels()
        setConstraints()
        
        // Person Name Text Label Customization
        self.personNameTextLabel.backgroundColor = .clear
        self.personNameTextLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        self.personNameTextLabel.textColor = .white
        
        // Person Known For Department Text Label Customization
        self.personKnownForDepTextLabel.backgroundColor = .clear
        self.personKnownForDepTextLabel.font = UIFont.systemFont(ofSize: 16)
        self.personKnownForDepTextLabel.textColor = Constants.MyColors.myLightGreyColor
        
        // Person Known For Text Label Customization
        self.personKnownForTextLabel.backgroundColor = .clear
        self.personKnownForTextLabel.font = UIFont.systemFont(ofSize: 12)
        self.personKnownForTextLabel.textColor = Constants.MyColors.myLightGreyColor
        
    }
    
    func cellConfigure(cellViewModel: PersonCellViewModel) {
        self.getProfile(profileePath: cellViewModel.profilePath)
        personImageView.layer.cornerRadius = 8
        self.personNameTextLabel.text = cellViewModel.name
        self.personKnownForDepTextLabel.text = cellViewModel.knownForDepartment
        self.personKnownForTextLabel.text = self.getKnownForString(cellViewModel.knownFor)
        self.rightArrowView.image = UIImage.init(named: "fi-rr-angle-small-right-grey")
        
        print("\(cellViewModel.name) -- \(cellViewModel.popularity)")
//        print("\(cellViewModel.name) -- \(cellViewModel.knownForDepartment)")
//        print(cellViewModel.knownFor.count, cellViewModel.knownFor[0].title ?? "")
    }
    
    func getKnownForString(_ array: [KnownFor]) -> String {
        var bufferString: String = ""
        
        if array.isEmpty != true {
            bufferString.append((array[0].title != nil ? array[0].title : array[0].name) ?? "")
            if array.count >= 3 {
                for each in 1...2 {
                    bufferString.append(", \((array[each].title != nil ? array[each].title : array[each].name) ?? "") ")
                }
            }
        }

       let stringWithTitles = bufferString[0..<40]
        return stringWithTitles ?? ""
    }
    
    func getProfile(profileePath: String) {
        self.personImageView.layer.borderColor = nil
        if profileePath == "" {
            self.personImageView.image = UIImage(named: "question-mark")
            self.personImageView.layer.borderWidth = 1
            self.personImageView.layer.borderColor = Constants.MyColors.myLightGreyColor.cgColor
        } else {
            let imageURL = Constants.Network.posterBaseURL + "\(profileePath)"
            self.personImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "placeholder.png"))
        }
    }
    
    func setLabels() {
        // Person Name Text Label
        personNameTextLabel = UILabel()
        personNameTextLabel.baselineAdjustment = .alignBaselines
        self.contentView.addSubview(personNameTextLabel)
        
        // Person Known For Department Text Label
        personKnownForDepTextLabel = UILabel()
        personKnownForDepTextLabel.baselineAdjustment = .alignBaselines
        self.contentView.addSubview(personKnownForDepTextLabel)
        
        // Person Known For Text Labe
        personKnownForTextLabel = UILabel()
        personKnownForTextLabel.baselineAdjustment = .alignBaselines
        self.contentView.addSubview(personKnownForTextLabel)
    }
    
    func setConstraints() {
        //    Person Name Text Label Constraints
        
        self.personNameTextLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.personNameTextLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8), self.personNameTextLabel.leadingAnchor.constraint(equalTo: personImageView.trailingAnchor, constant: 8),
                                     self.personNameTextLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -90)])
        
        self.personKnownForDepTextLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.personKnownForDepTextLabel.leadingAnchor.constraint(equalTo: personImageView.trailingAnchor, constant: 8), self.personKnownForDepTextLabel.heightAnchor.constraint(equalToConstant: 20), self.personKnownForDepTextLabel.topAnchor.constraint(equalTo: self.personNameTextLabel.bottomAnchor, constant: 2)])
        
        self.personKnownForTextLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.personKnownForTextLabel.leadingAnchor.constraint(equalTo: self.personImageView.trailingAnchor, constant: 8), self.personKnownForTextLabel.heightAnchor.constraint(equalToConstant: 15), self.personKnownForTextLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8)])
    }
}
