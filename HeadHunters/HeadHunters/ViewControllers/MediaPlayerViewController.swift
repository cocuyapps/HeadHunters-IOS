//
//  MediaPlayerViewController.swift
//  HeadHunters
//
//  Created by Diego Salas Noain on 6/9/19.
//  Copyright © 2019 CoCuyApps. All rights reserved.
//

import UIKit
import AVFoundation

class MediaPlayerViewController: UIViewController {
    var songs: [Song] = [Song]()
    
    var player: AVPlayer!
    var playerItem: AVPlayerItem!
    var playerLayer: AVPlayerLayer!
    var currentSong = 0
    
    @IBOutlet weak var artImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var PausePlayButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        artImageView.setImage(fromUrlString: (songs[0].albumArtUrl)!,
                                withDefaultImage: "no-image-available",
                                withErrorImage: "no-image-available")
        titleLabel.text = songs[0].title
        artistLabel.text = songs[0].artist
        setPlayer()
    }
    
    func setPlayer() {
        let url = URL(string: songs[currentSong].audioUrl!)!
        let playerItem: AVPlayerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        
        playerLayer=AVPlayerLayer(player: player!)
        self.view.layer.addSublayer(playerLayer!)
    }
}
