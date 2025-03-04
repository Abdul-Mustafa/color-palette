//
//  FavoritePalette+CoreDataProperties.swift
//  Color Palette
//
//  Created by mac on 03/03/2025.
//
//

import Foundation
import CoreData


extension FavoritePalette {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoritePalette> {
        return NSFetchRequest<FavoritePalette>(entityName: "FavoritePalette")
        
    }

    @NSManaged public var name: String?
    @NSManaged public var colors: NSObject?

}

extension FavoritePalette : Identifiable {

}
