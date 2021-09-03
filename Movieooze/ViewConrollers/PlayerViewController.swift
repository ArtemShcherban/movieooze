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
    
    var playerView: YTPlayerView!
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (self.isMovingFromParent) {
          UIDevice.current.setValue(Int(UIInterfaceOrientation.portrait.rawValue), forKey: "orientation")
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        playerView.load(withVideoId: "aSiDu3Ywi8E")
        playerView.delegate = self
    }
    
    
    func setPlayerConstraints(){
        playerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.playerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                                     self.playerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                                     self.playerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                                     self.playerView.heightAnchor.constraint(equalTo: self.playerView.widthAnchor, multiplier: 9/16)])
    }


}

extension PlayerViewController: YTPlayerViewDelegate {
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playerView.playVideo()
    }
}
    
    
