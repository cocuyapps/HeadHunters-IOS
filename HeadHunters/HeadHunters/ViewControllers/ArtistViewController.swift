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
    
    func update(artistImage: String, artistName: String){
        artistImageView.setImage(
            fromUrlString:artistImage,
            withDefaultImage: "no-image-avaible",
            withErrorImage: "no-image-avaible")
        artistNameLabel.text = artistName
    }
}

class ArtistViewController : UICollectionViewController {
    
    var ref: DatabaseReference!
    var image: String!
    var name: String!
    var count = 0
    var currentRow = 0
    
    
    override func viewDidLoad() {
        ref = Database.database().reference()
        getArtists()
    }
    
    func getArtists(){
        self.ref.child("User").queryOrdered(byChild: "BandName").observeSingleEvent(of: .value, with: {
            DataSnapshot in
            print(DataSnapshot.childrenCount)
            for child in DataSnapshot.children.allObjects as! [DataSnapshot]{
                print(child.value)
                for value in child.children.allObjects {
                    print(value)
                }
            }
        } )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if count > 0 {
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
        return count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ArtistCell
        
        return cell
    }
    
    
}

