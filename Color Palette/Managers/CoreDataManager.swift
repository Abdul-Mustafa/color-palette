//
//  CoreDataManager.swift
//  Color Palette
//
//  Created by mac on 03/03/2025.
//

import CoreData
import UIKit

class CoreDataManager {
    static let shared = CoreDataManager()
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Color_Palette") // Make sure the name matches your xcdatamodeld file
        container.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func savePalette(_ palette: ColorPalette, in context: NSManagedObjectContext? = nil) {
            let saveContext = context ?? self.context // Use provided context or default to viewContext
            do {
                let fetchRequest = NSFetchRequest<FavoritePalette>(entityName: "FavoritePalette")
                fetchRequest.predicate = NSPredicate(format: "name == %@", palette.name)
                fetchRequest.fetchLimit = 1
                
                let results = try saveContext.fetch(fetchRequest)
                
                if results.isEmpty {
                    let favorite = FavoritePalette(context: saveContext)
                    favorite.name = palette.name
                    favorite.colors = palette.colors as NSObject // Adjust if colors is [String]
                    try saveContext.save()
                    print("Palette '\(palette.name)' saved successfully.")
                } else {
                    print("Palette '\(palette.name)' already exists.")
                }
            } catch {
                print("Error saving palette: \(error)")
            }
        }
    
    func fetchFavorites() -> [FavoritePalette] {
        let request: NSFetchRequest<FavoritePalette> = FavoritePalette.fetchRequest()
        
        do {
            return try context.fetch(request)
        } catch {
            print("Failed to fetch favorites: \(error)")
            return []
        }
    }
    
    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Failed to save: \(error)")
        }
    }
}
