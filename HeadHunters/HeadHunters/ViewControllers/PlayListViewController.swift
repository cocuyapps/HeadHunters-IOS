//
//  PlayListViewController.swift
//  HeadHunters
//
//  Created by Diego Salas Noain on 6/9/19.
//  Copyright © 2019 CoCuyApps. All rights reserved.
//

import UIKit
import os
import Firebase

private let reuseIdentifier = "PlayListCell"

class PlayListCell: UICollectionViewCell {
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func update(from album: Album) {
        albumImageView.setImage(fromUrlString: album.image!, withDefaultImage: "no-image-available",
                                withErrorImage: "no-image-available")
        titleLabel.text = album.artist
        
    }
}

class PlayListViewController: UICollectionViewController {

    var albums: [Album] = [Album]()
    var songs: [Song] = [Song]()
    var currentRow = 0
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        getUserPlayList()
    }
    
    func getUserPlayList() {
        
        let userID : String = (Auth.auth().currentUser?.uid)!
        self.ref?.child("User").child(userID).child("albums").observe(.childAdded) {(snapshot: DataSnapshot) in
            if let dict = snapshot.value as? [String: Any] {
                let title = dict["title"] as! String
                let artist = dict["artist"] as! String
                let url = dict["url"] as! String
                let thumbnail_image = dict["thumbnail_image"] as! String
                let image = dict["image"] as! String
                let genre = dict["genre"] as! String
                let description = dict["description"] as! String
                let songs = dict["songs"] as! [[String:Any]]
                for song in songs {
                    let artist2 = song["artist"] as! String
                    let title2 = song["title"] as! String
                    let albumArtUrl = song["albumArtUrl"] as! String
                    let audioUrl = song["audioUrl"] as! String
                    let song = Song(artist: artist2, title: title2, albumArtUrl: albumArtUrl, audioUrl: audioUrl)
                    self.songs.append(song)
                }
            
                let album = Album(title: title, artist: artist, url: url, thumbnail_image: thumbnail_image, image: image, songs: self.songs, genre: genre, likes: 0, description: description, liked: 0)
                self.albums.append(album)
                self.songs = [Song]()
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if albums.count > 0 {
            self.collectionView.reloadItems(at: [IndexPath(item: currentRow, section: 0)])
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PlayListCell

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
        if segue.identifier == "showMediaPlayer" {
            let destination = segue.destination as! MediaPlayerViewController
            destination.songs = albums[currentRow].songs!
        }
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentRow = indexPath.item
        performSegue(withIdentifier: "showMediaPlayer", sender: self)
    }
}
