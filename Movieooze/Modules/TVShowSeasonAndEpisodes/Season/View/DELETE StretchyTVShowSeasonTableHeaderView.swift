//
//  StretchyTVShowSeasonTableHeaderView.swift
//  Movieooze
//
//  Created by Artem Shcherban on 04.10.2021.
//

import Foundation
import UIKit

class StretchyTVShowSeasonTableHeaderView: UIView {
    var seasonPosterView: UIImageView!
    var seasonPosterViewHeight = NSLayoutConstraint()
    var seasonPosterViewBottom = NSLayoutConstraint()
    
    var headContainerView: UIView!
    var headContainerViewHeight = NSLayoutConstraint()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createViews()
        setViewConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func createViews() {
        // Head Container View
        headContainerView = UIView()
        self.addSubview(headContainerView)

        // Season Poster Image View
        seasonPosterView = UIImageView()
        seasonPosterView.clipsToBounds = true
        seasonPosterView.backgroundColor = .yellow
        seasonPosterView.contentMode = .scaleAspectFill
        headContainerView.addSubview(seasonPosterView)
    }
    
    func setViewConstraints() {
        // UIView Constraints
        NSLayoutConstraint.activate([self.widthAnchor.constraint(equalTo: headContainerView.widthAnchor), self.centerXAnchor.constraint(equalTo: headContainerView.centerXAnchor), self.heightAnchor.constraint(equalTo: headContainerView.heightAnchor)])
        
        // Head Container View Constraints
        headContainerView.translatesAutoresizingMaskIntoConstraints = false
        headContainerView.widthAnchor.constraint(equalTo: seasonPosterView.widthAnchor).isActive = true
        headContainerViewHeight = headContainerView.heightAnchor.constraint(equalTo: self.heightAnchor)
        headContainerViewHeight.isActive = true
        
        // Season Poster Image View Constraints
        seasonPosterView.translatesAutoresizingMaskIntoConstraints = false
        seasonPosterViewBottom = seasonPosterView.bottomAnchor.constraint(equalTo: headContainerView.bottomAnchor)
        seasonPosterViewBottom.isActive = true
        seasonPosterViewHeight = seasonPosterView.heightAnchor.constraint(equalTo: headContainerView.heightAnchor)
        seasonPosterViewHeight.isActive = true
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        headContainerViewHeight.constant = scrollView.contentInset.top
        let offsetY = -(scrollView.contentOffset.y + scrollView.contentInset.top)
        headContainerView.clipsToBounds = offsetY <= 0
        seasonPosterViewBottom.constant = offsetY >= 0 ? 0 : -offsetY / 2
        seasonPosterViewHeight.constant = max(offsetY + scrollView.contentInset.top, scrollView.contentInset.top)
    }
}
