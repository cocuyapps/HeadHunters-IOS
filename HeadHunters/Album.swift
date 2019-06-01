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
    
    var isFavorite: Bool {
        get {
            return HeadHuntersStore.shared.isFavorite(album: self)
        }
        set {
            HeadHuntersStore.shared.setFavorite(newValue, for: self)
        }
    }
}
