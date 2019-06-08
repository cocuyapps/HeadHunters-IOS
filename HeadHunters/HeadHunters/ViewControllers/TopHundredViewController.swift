//
//  TopHundredViewController.swift
//  HeadHunters
//
//  Created by Diego Salas Noain on 5/25/19.
//  Copyright © 2019 CoCuyApps. All rights reserved.
//

import UIKit
import os

private let reuseIdentifier = "Cell"

class AlbumCell: UICollectionViewCell {
    

    @IBOutlet weak var artistLabel: UILabel!
    
    @IBOutlet weak var albumLabel: UILabel!
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    @IBOutlet weak var bandImageView: UIImageView!
    
    @IBOutlet weak var favoriteImageView: UIImageView!
    
    func update(from album: Album) {
        thumbnailImageView.setImage(
            fromUrlString: album.thumbnail_image!,
            withDefaultImage: "no-image-available",
            withErrorImage: "no-image-available")

        bandImageView.setImage(
            fromUrlString: album.image!,
            withDefaultImage: "no-image-available",
            withErrorImage: "no-image-available")

        artistLabel.text = album.artist

        albumLabel.text = album.title

        favoriteImageView.setImage(fromAsset: "heartblank")
    }
    
    @IBAction func addToPlaylist(_ sender: UIButton) {
        
    }
    
}

class TopHundredViewControllerController: UICollectionViewController {
    
    var albums: [Album] = [Album]()
    var currentRow = 0
    var genre = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        HeadHuntersApi.getAlbums(responseHandler: handleResponse,
                                 errorHandler: handleError, genre: genre)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if albums.count > 0 {
            self.collectionView.reloadItems(at: [IndexPath(item: currentRow, section: 0)])
        }
    }
    
    func handleResponse(response: AlbumsResponse) {
        guard let albums = response.albums else {
            self.albums = [Album]()
            return
        }
        self.albums = albums
        self.collectionView.reloadData()
    }
    
    func handleError(error: Error) {
        let message = "Error while requesting Sources: \(error.localizedDescription)"
        os_log("%@", message)
    }
    
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! AlbumCell
        
        // Configure the cell
        cell.layer.shadowColor = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.7).cgColor
        cell.layer.shadowRadius = 1
        cell.layer.shadowOpacity = 0.6
        cell.clipsToBounds = false
        cell.layer.zPosition = 10
        cell.update(from: albums[indexPath.row])
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAlbum" {
            let destination = segue.destination as! AlbumDetailViewController
            destination.album = albums[currentRow]
        }
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentRow = indexPath.item
        performSegue(withIdentifier: "showAlbum", sender: self)
    }
}
