//
//  ArtistViewController.swift
//  HeadHunters
//
//  Created by Alumnos on 6/8/19.
//  Copyright © 2019 CoCuyApps. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "Artist Cell"

class ArtistCell : UICollectionViewCell {
    
    @IBOutlet weak var artistImageView: UIImageView!
    
    @IBOutlet weak var artistNameLabel: UILabel!
    
    func update(from artist: UserProfile){
        artistImageView.setImage(
            fromUrlString:artist.BandImgUrl!,
            withDefaultImage: "nno-image-available",
            withErrorImage: "no-image-available")
        artistNameLabel.text = artist.BandName
    }
}

class ArtistViewController : UICollectionViewController {
    
    var artists: [UserProfile] = [UserProfile]()
    var ref: DatabaseReference!
    var currentRow = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        getArtists()
    }
    func getArtists(){
        self.ref.child("User").queryOrdered(byChild: "BandName").observe(.value) { (snapshot: DataSnapshot) in
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                
                if let dict = child.value as? [String: Any] {
                    if(dict["BandName"] != nil){
                        let bandDescription = dict["BandDescription"] as! String
                        let bandImageUrl = dict["BandImgUrl"] as! String
                        let bandMembers = dict["BandMembers"] as! String
                        let bandName = dict["BandName"] as! String
                        let bandSample = dict["BandSample"] as! String
                        if(dict["UserName"] != nil){
                            let userName = dict["UserName"] as! String
                            let artist = UserProfile(bandDescription: bandDescription, BandImgUrl: bandImageUrl, BandMembers: bandMembers, BandName: bandName, UserName: userName, BandSample: bandSample)
                            self.artists.append(artist)
                            self.collectionView.reloadData()
                        }
                    }
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if artists.count > 0 {
            self.collectionView.reloadItems(at: [IndexPath(item: currentRow,
                                                           section: 0)])
        }
    }
    
    override func numberOfSections(in
        collectionView: UICollectionView) ->
        Int {
            return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return artists.count

    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ArtistCell
        cell.update(from: artists[indexPath.row])
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showArtist" {
            let destination = segue.destination as! ArtistDetailViewController
            destination.artist = artists[currentRow]
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentRow = indexPath.item
        performSegue(withIdentifier: "showArtist", sender: self)
    }
    
}

