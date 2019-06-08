//
//  AlbumDetailViewController.swift
//  HeadHunters
//
//  Created by Diego Salas Noain on 6/8/19.
//  Copyright © 2019 CoCuyApps. All rights reserved.
//

import UIKit

class AlbumDetailViewController: UIViewController {
    var album: Album?
    var isFavorite = false
    
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        albumImageView.setImage(fromUrlString: album!.image!,
                                withDefaultImage: "no-image-available",
                                withErrorImage: "no-image-available")
        titleLabel.text = album?.title
        artistLabel.text = album?.artist
        descriptionLabel.text = "Description: " + album!.description!
    }
}
