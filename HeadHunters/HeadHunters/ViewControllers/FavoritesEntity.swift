//
//  FavoritesEntity.swift
//  HeadHunters
//
//  Created by Diego Salas Noain on 6/1/19.
//  Copyright © 2019 CoCuyApps. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class FavoritesEntity {
    let delegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let entityName = "AlbumEntity"
    
    func add(from album: Album) {
        if let entity = NSEntityDescription.entity(
            forEntityName: entityName, in: context) {
            let newObject = NSManagedObject(entity: entity, insertInto: context)
            newObject.setValue(album.id, forKey: "albumId")
            newObject.setValue(album.title, forKey: "albumTitle")
            save()
        }
    }
    
    func save() {
        delegate.saveContext()
    }
    
    func all() -> [NSManagedObject]? {
        return find(withPredicate: nil)
    }
    
    func find(withPredicate predicate: NSPredicate?) -> [NSManagedObject]? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        if let predicate = predicate {
            request.predicate = predicate
        }
        do {
            let result = try context.fetch(request)
            return result as? [NSManagedObject]
        } catch {
            print("Error while querying: \(error.localizedDescription)")
        }
        return nil
    }
    
    func find(byId id: String) -> NSManagedObject? {
        let predicate = NSPredicate(format: "albumId = %@", id)
        if let result = find(withPredicate: predicate) {
            return result.first
        }
        return nil
    }
    
    func find(byTitle title: String) -> NSManagedObject? {
        let predicate = NSPredicate(format: "albumTitle = %@", title)
        if let result = find(withPredicate: predicate) {
            return result.first
        }
        return nil
    }
    
    func isFavorite(album: Album) -> Bool {
        return find(byId: album.id!) != nil
    }
    
    func delete(for album: Album) {
        if let favorite = find(byId: album.id!) {
            do {
                try favorite.validateForDelete()
                context.delete(favorite)
                save()
            } catch {
                print("Error while deleting: \(error.localizedDescription)")
            }
        }
    }
    
    func albumsIdsAsString() -> String? {
        if let favorites = all() {
            return favorites.map({$0.value(forKey: "albumId") as! String}).joined()
        }
        return nil
    }
    
    
}
