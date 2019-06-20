//
//  TopHundredViewController.swift
//  HeadHunters
//
//  Created by Diego Salas Noain on 5/25/19.
//  Copyright © 2019 CoCuyApps. All rights reserved.
//

import UIKit
import os
import Firebase

private let reuseIdentifier = "Cell"

class AlbumCell: UICollectionViewCell {
    
    @IBOutlet weak var artistLabel: UILabel!
    
    @IBOutlet weak var albumLabel: UILabel!
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    @IBOutlet weak var bandImageView: UIImageView!
    
    @IBOutlet weak var favoriteImageView: UIImageView!
    
    @IBOutlet weak var addToPlaylist: UIButton!
    
    var referenfe: DatabaseReference!
    
    var currentAlbum: Album!
    
    var songs = [[String:String]]()
    
    func update(from album: Album, ref: DatabaseReference) {
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
        
//        if (!mostrarHabilitado) {
//            addToPlaylist.isEnabled = false
//            addToPlaylist.setTitle("Album agregado", for: .normal)
//        }

        referenfe = ref
        
        currentAlbum = album
    }
    
    @IBAction func addToPlaylist(_ sender: UIButton) {
        let userID : String = (Auth.auth().currentUser?.uid)!
        let newAlbum = self.referenfe?.child("User").child(userID).child("albums").childByAutoId()
        
        for song in currentAlbum!.songs! {
            self.songs.append([
                "artist": song.artist!,
                "title": song.title!,
                "albumArtUrl": song.albumArtUrl!,
                "audioUrl": song.audioUrl!
            ])
        }
        
        let albumObject = [
            "title": currentAlbum!.title as Any,
            "artist": currentAlbum!.artist as Any,
            "url": currentAlbum!.url as Any,
            "thumbnail_image": currentAlbum!.thumbnail_image as Any,
            "image": currentAlbum!.image as Any,
            "genre": currentAlbum!.genre as Any,
            "likes": currentAlbum!.likes as Any,
            "description": currentAlbum!.description as Any,
            "liked": currentAlbum!.liked as Any,
            "songs": self.songs as Any
        ]
        newAlbum?.setValue(albumObject, withCompletionBlock: { error, ref in
            if error == nil {
                print("good")
            } else {
                //handle error
            }
        })
        
        addToPlaylist.isEnabled = false
        addToPlaylist.setTitle("Album agregado", for: .normal)
    }
    
}

class TopHundredViewControllerController: UICollectionViewController {
    
    var albums: [Album] = [Album]()
    var currentRow = 0
    var genre = ""
    var ref: DatabaseReference!
    var dict: [Int:Bool] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        HeadHuntersApi.getAlbums(responseHandler: handleResponse,
                                 errorHandler: handleError, genre: genre)
        
        ref = Database.database().reference()
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
        compareAlbums() { () in
            print("videoUrl")
        }
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
        cell.update(from: albums[indexPath.row], ref: ref)
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
    
    //verificar
    func compareAlbums(completion: @escaping () -> Void) {
        let userID : String = (Auth.auth().currentUser?.uid)!
        var i = 0
        self.ref?.child("User").child(userID).child("albums").observe(.childAdded) {(snapshot: DataSnapshot) in
            if let dict = snapshot.value as? [String: Any] {
                for album in self.albums {
                    if (album.title == dict["title"] as? String) {
                        self.dict[i] = false
                    } else {
                        self.dict[i] = true
                    }
                }
                i += 1
            }
        }
    }
}
