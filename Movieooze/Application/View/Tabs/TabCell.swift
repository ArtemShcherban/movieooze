//
//  TabCell.swift
//  Movieooze
//
//  Created by Artem Shcherban on 19.09.2021.
//

import UIKit

class TabCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: TabCell.self)
    
    private var tabSv: UIStackView!
    
    var tabTitle: UILabel!
    
    var tabIcon: UIImageView!
    
    var indicatorView: UIView!
    
    var indicatorColor: UIColor! = .white
    
    override var isSelected: Bool {
        didSet {
            
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.3) {
                    self.indicatorView.backgroundColor = self.isSelected ? self.indicatorColor : UIColor.clear
                    self.layoutIfNeeded()
                }
            }
        }
    }
    
    var tabViewModel: Tab? {
        didSet {
            tabTitle.text = tabViewModel?.title
            tabIcon.image = tabViewModel?.icon
            
            // Remove stackView spacing if icon is nil
            (tabViewModel?.icon != nil) ? (tabSv.spacing = 10) : (tabSv.spacing = 0)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        tabSv = UIStackView()
        tabSv.axis = .horizontal
        tabSv.distribution = .equalCentering
        tabSv.alignment = .center
        tabSv.spacing = 10.0
        addSubview(tabSv)
        
        // Tab Icon
        tabIcon = UIImageView()
        tabIcon.clipsToBounds = true
        self.tabSv.addArrangedSubview(tabIcon)
        
        // Tab Title
        tabTitle = UILabel()
        tabTitle.textAlignment = .center
        self.tabSv.addArrangedSubview(tabTitle)
        
        // Tab Icon Constraints
        tabIcon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.tabIcon.heightAnchor.constraint(equalToConstant: 18),
                                     self.tabIcon.widthAnchor.constraint(lessThanOrEqualToConstant: 18)])
        
        // Tab Title Constraints
        tabSv.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.tabSv.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                                     self.tabSv.centerXAnchor.constraint(equalTo: self.centerXAnchor)])
        
        setupIndicatorView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        tabTitle.text = ""
        tabIcon.image = nil
    }
    
    func setupIndicatorView() {
        indicatorView = UIView()
        addSubview(indicatorView)
        
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.indicatorView.heightAnchor.constraint(equalToConstant: 1),
                                     self.indicatorView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                                     indicatorView.widthAnchor.constraint(equalTo: self.widthAnchor),
                                     self.indicatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor)])
    }
}
