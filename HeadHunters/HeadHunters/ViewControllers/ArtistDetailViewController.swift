//
//  ArtistDetailViewController.swift
//  HeadHunters
//
//  Created by Alumnos on 6/18/19.
//  Copyright © 2019 CoCuyApps. All rights reserved.
//

import UIKit

class ArtistDetailViewController: UIViewController {
    var artist: UserProfile?
    

    @IBOutlet weak var artistImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var membersLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var musicLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        artistImageView.setImage(fromUrlString: artist!.BandImgUrl!, withDefaultImage: "no-image-available", withErrorImage: "no-image-available")
        titleLabel.text = "Band name: " + artist!.BandName!
        membersLabel.text = "Band members: " + artist!.BandMembers!
        descriptionLabel.text = "Description: " + artist!.bandDescription!
        musicLabel.text = "Music source: " + artist!.BandSample!
    }
}
