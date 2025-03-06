//
//  SavedAsSingleColor+CoreDataProperties.swift
//  Color Palette
//
//  Created by mac on 06/03/2025.
//
//

import Foundation
import CoreData


extension SavedAsSingleColor {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedAsSingleColor> {
        return NSFetchRequest<SavedAsSingleColor>(entityName: "SavedAsSingleColor")
    }

    @NSManaged public var name: String?

}

extension SavedAsSingleColor : Identifiable {

}
