//
//  FavNamedColorPalettes+CoreDataProperties.swift
//  Color Palette
//
//  Created by mac on 05/03/2025.
//
//

import Foundation
import CoreData


extension FavNamedColorPalettes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavNamedColorPalettes> {
        return NSFetchRequest<FavNamedColorPalettes>(entityName: "FavNamedColorPalettes")
    }

    @NSManaged public var colors: NSObject?
    @NSManaged public var name: String?

}

extension FavNamedColorPalettes : Identifiable {

}
