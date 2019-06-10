//
//  MediaPlayerViewController.swift
//  HeadHunters
//
//  Created by Diego Salas Noain on 6/9/19.
//  Copyright © 2019 CoCuyApps. All rights reserved.
//

import UIKit

class MediaPlayerViewController: UIViewController {
    var album: Album?
    
    @IBOutlet weak var artImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var skipBackImageView: UIImageView!
    @IBOutlet weak var playPauseImageView: UIImageView!
    @IBOutlet weak var skipNextImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        artImageView.setImage(fromUrlString: (album?.songs![0].albumArtUrl)!,
                                withDefaultImage: "no-image-available",
                                withErrorImage: "no-image-available")
        titleLabel.text = album?.songs![0].title
        artistLabel.text = album?.songs![0].artist
    }
}
