//
//  SingleColor+CoreDataProperties.swift
//  Color Palette
//
//  Created by mac on 06/03/2025.
//
//

import Foundation
import CoreData


extension SingleColor {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SingleColor> {
        return NSFetchRequest<SingleColor>(entityName: "SingleColor")
    }

    @NSManaged public var name: String?

}

extension SingleColor : Identifiable {

}
