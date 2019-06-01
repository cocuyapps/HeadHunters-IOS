//
//  HeadHuntersStore.swift
//  HeadHunters
//
//  Created by Diego Salas Noain on 6/1/19.
//  Copyright © 2019 CoCuyApps. All rights reserved.
//

import Foundation

class HeadHuntersStore {
    private let favoritesEntity = FavoritesEntity()
    static let shared = HeadHuntersStore()
    private init() {}
    
    func isFavorite(album: Album) -> Bool {
        return favoritesEntity.isFavorite(album: album)
    }
    
    func setFavorite(_ isFavorite: Bool, for album: Album) {
        if isFavorite == favoritesEntity.isFavorite(album: album) {
            return
        }
        if isFavorite {
            favoritesEntity.add(from: album)
        } else {
            favoritesEntity.delete(for: album)
        }
    }
    
    func albumsIdsAsString() -> String? {
        return favoritesEntity.albumsIdsAsString()
    }
}
