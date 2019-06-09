//
//  Song.swift
//  HeadHunters
//
//  Created by Diego Salas Noain on 5/25/19.
//  Copyright © 2019 CoCuyApps. All rights reserved.
//

import Foundation

struct Song: Codable {
    var artist: String?
    var title: String?
    var albumArtUrl: String?
    var audioUrl: String?
    
    init(artist: String, title: String, albumArtUrl: String, audioUrl: String) {
        self.artist = artist
        self.title = title
        self.albumArtUrl = albumArtUrl
        self.audioUrl = audioUrl
    }
}
