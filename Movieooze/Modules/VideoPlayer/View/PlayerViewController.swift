//
//  PlayerViewController.swift
//  Movieooze
//
//  Created by Artem Shcherban on 02.09.2021.
//

import UIKit
import youtube_ios_player_helper

class PlayerViewController: UIViewController {
    
    static let reuseIdentifire = String(describing: PlayerViewController.self)
    
    var videoPlayerViewModel: VideoPlayerViewModel!
    var playerView: YTPlayerView!
    var arrayOfTraillers: [String] = []
    var noTrailler: UILabel!
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       
        self.tabBarController?.tabBar.isHidden = false
        
        if (self.isMovingFromParent) {
          UIDevice.current.setValue(Int(UIInterfaceOrientation.portrait.rawValue), forKey: "orientation")
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = true
        arrayOfTraillers = videoPlayerViewModel.arrayOfTraillers
        createPlayerView()
        setPlayerConstraints()
        canRotate()
    }
    
    
    @objc func canRotate() -> Void{}
    
    func createPlayerView()  {
        self.view.backgroundColor = .black
        playerView = YTPlayerView()
        playerView.backgroundColor = .clear
        self.view.addSubview(playerView)
        
        // Check If Array Of Traillers is empty
        if arrayOfTraillers.isEmpty {
        noTrailerFunction()
        } else {
            playerView.load(withVideoId: arrayOfTraillers.randomElement() ?? "", playerVars: ["playsinline": 0 ] )
        playerView.delegate = self
        }
    }
    
    func setPlayerConstraints(){
        playerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.playerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                                     self.playerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                                     self.playerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                                     self.playerView.heightAnchor.constraint(equalTo: self.playerView.widthAnchor, multiplier: 9/16)])
    }
    
    func noTrailerFunction(){
        noTrailler = UILabel()
        noTrailler.backgroundColor = .black
        noTrailler.textColor = .white
        noTrailler.textAlignment = .center
        noTrailler.text = "NO TRAILLER, SORRY"
        self.playerView.addSubview(noTrailler)
        noTrailler.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.noTrailler.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                                     self.noTrailler.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                                     self.noTrailler.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                                     self.noTrailler.heightAnchor.constraint(equalTo: self.noTrailler.widthAnchor, multiplier: 9/16)])
    }
}

extension PlayerViewController: YTPlayerViewDelegate {
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        
        playerView.playVideo()
    }
}
    
    
