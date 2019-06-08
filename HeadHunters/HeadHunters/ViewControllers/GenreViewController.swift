//
//  GenreViewController.swift
//  HeadHunters
//
//  Created by Miguel Delgado on 6/8/19.
//  Copyright © 2019 CoCuyApps. All rights reserved.
//

import UIKit
import os

private let reuseIdentifier = "Genre Cell"

class GenreCell: UICollectionViewCell {
    
    @IBOutlet weak var genreImageView: UIImageView!
    @IBOutlet weak var genreLabel: UILabel!
    
    func update(from genre: Genre) {
        genreImageView.setImage(fromUrlString: genre.genreimg!, withDefaultImage: "no-image-available",
                                withErrorImage: "no-image-available")
        genreLabel.text = genre.genre
        
    }
}


class GenreViewController: UICollectionViewController {
    
    var genres: [Genre] = [Genre]()
    var currentRow = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HeadHuntersApi.getGenres(responseHandler: handleResponse, errorHandler: handleError)
    }
    
    func handleResponse(response: GenreResponse){
        guard let genres = response.genres else {
            self.genres = [Genre]()
            return
        }
        self.genres = genres
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
        return genres.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! GenreCell
        
        // Configure the cell
        cell.layer.shadowColor = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.7).cgColor
        cell.layer.shadowRadius = 1
        cell.layer.shadowOpacity = 0.6
        cell.clipsToBounds = false
        cell.layer.zPosition = 10
        cell.update(from: genres[indexPath.row])
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAlbumsGenre" {
            if let destination = segue.destination as? TopHundredViewControllerController {
                destination.genre = genres[currentRow].genre!
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentRow = indexPath.item
        performSegue(withIdentifier: "showAlbumsGenre", sender: self)
    }
}
