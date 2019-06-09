//
//  Album.swift
//  HeadHunters
//
//  Created by Diego Salas Noain on 5/25/19.
//  Copyright © 2019 CoCuyApps. All rights reserved.
//

import Foundation

struct Album: Codable {
    var id: String?
    var title: String?
    var artist: String?
    var url: String?
    var thumbnail_image: String?
    var image: String?
    var songs: Array<Song>?
    var genre: String?
    var likes: Int?
    var description: String?
    var liked: Int?
    
    init(title: String,
        artist: String,
        url: String,
        thumbnail_image: String,
        image: String,
        songs: Array<Song>,
        genre: String,
        likes: Int,
        description: String,
        liked: Int) {
        self.title = title
        self.artist = artist
        self.url = url
        self.thumbnail_image = thumbnail_image
        self.image = image
        self.songs = songs
        self.genre = genre
        self.likes = likes
        self.description = description
        self.liked = liked
        
    }
    
    var isFavorite: Bool {
        get {
            return HeadHuntersStore.shared.isFavorite(album: self)
        }
        set {
            HeadHuntersStore.shared.setFavorite(newValue, for: self)
        }
    }
}
