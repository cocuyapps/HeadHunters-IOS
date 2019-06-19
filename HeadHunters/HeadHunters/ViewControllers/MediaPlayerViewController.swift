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
    @IBOutlet weak var playPauseBtn: UIButton!
    @IBOutlet weak var skipNextBtn: UIButton!
    @IBOutlet weak var skipPreviousBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        artImageView.setImage(fromUrlString: (songs[0].albumArtUrl)!,
                                withDefaultImage: "no-image-available",
                                withErrorImage: "no-image-available")
        titleLabel.text = songs[0].title
        artistLabel.text = songs[0].artist
        setPlayer()
    }
    
    @IBAction func PlayPause(_ sender: UIButton) {
        if player?.rate == 0
        {
            player!.play()
            playPauseBtn.setBackgroundImage(UIImage(named: "ic_pause_white_48pt"), for: .normal)
        } else {
            player!.pause()
            playPauseBtn.setBackgroundImage(UIImage(named: "ic_play_arrow_white_48pt"), for: .normal)
        }
    }
    
    @IBAction func skipNext(_ sender: UIButton) {
        if(currentSong < songs.count - 1){
            currentSong = currentSong + 1;
            player!.pause()
            player = nil
            
            setPlayer();
            if player?.rate == 0
            {
                titleLabel.text = "Loading..."
                artistLabel.text = "Loading..."
                player!.play()
                playPauseBtn.setBackgroundImage(UIImage(named: "ic_pause_white_48pt"), for: .normal)
                titleLabel.text = songs[currentSong].title
                artistLabel.text = songs[currentSong].artist
            }
        }
    }
    
    
    @IBAction func skipPrevious(_ sender: UIButton) {
        if(currentSong > 0){
            currentSong = currentSong - 1;
            player!.pause()
            player = nil
            
            setPlayer();
            if player?.rate == 0
            {
                titleLabel.text = "Loading..."
                artistLabel.text = "Loading..."
                player!.play()
                playPauseBtn.setBackgroundImage(UIImage(named: "ic_pause_white_48pt"), for: .normal)
                titleLabel.text = songs[currentSong].title
                artistLabel.text = songs[currentSong].artist
            }
        }
    }
    
    func setPlayer() {
        let url = URL(string: songs[currentSong].audioUrl!)!
        let playerItem: AVPlayerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        
        playerLayer=AVPlayerLayer(player: player!)
        self.view.layer.addSublayer(playerLayer!)
    }
    
    func contPlay(){
        
        if(currentSong < songs.count - 1){
            currentSong = currentSong + 1
            player!.pause()
            player = nil
            
            setPlayer();
            if player?.rate == 0
            {
                titleLabel.text = "Loading..."
                artistLabel.text = "Loading..."
                player!.play()
                playPauseBtn.setBackgroundImage(UIImage(named: "ic_pause_white_48pt"), for: .normal)
                titleLabel.text = songs[currentSong].title
                artistLabel.text = songs[currentSong].artist
            }
            
        }
    }
}
