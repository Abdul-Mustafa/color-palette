//
//  CoreDataManager.swift
//  Color Palette
//
//  Created by mac on 03/03/2025.
//

//import CoreData
//import UIKit

//class CoreDataManager {
//    static let shared = CoreDataManager()
//    
//    private init() {}
//    
//    lazy var persistentContainer: NSPersistentContainer = {
//        let container = NSPersistentContainer(name: "Color_Palette") // Make sure the name matches your xcdatamodeld file
//        container.loadPersistentStores { (_, error) in
//            if let error = error {
//                fatalError("Failed to load Core Data stack: \(error)")
//            }
//        }
//        return container
//    }()
//    
//    var context: NSManagedObjectContext {
//        return persistentContainer.viewContext
//    }
//    
//    func savePalette(_ palette: ColorPalette, in context: NSManagedObjectContext? = nil) {
//            let saveContext = context ?? self.context // Use provided context or default to viewContext
//            do {
//                let fetchRequest = NSFetchRequest<FavNamedColorPalettes>(entityName: "FavNamedColorPalettes")
//                fetchRequest.predicate = NSPredicate(format: "name == %@", palette.name)
//                fetchRequest.fetchLimit = 1
//                
//                let results = try saveContext.fetch(fetchRequest)
//                
//                if results.isEmpty {
//                    let favorite = FavNamedColorPalettes(context: saveContext)
//                    favorite.name = palette.name
//                    favorite.colors = palette.colors as NSObject // Adjust if colors is [String]
//                    try saveContext.save()
//                    print("Palette '\(palette.name)' saved successfully.")
//                } else {
//                    print("Palette '\(palette.name)' already exists.")
//                }
//            } catch {
//                print("Error saving palette: \(error)")
//            }
//        }
//    
//    func fetchFavorites() -> [FavNamedColorPalettes] {
//        let request: NSFetchRequest<FavNamedColorPalettes> = FavNamedColorPalettes.fetchRequest()
//        
//        do {
//            let favorites = try context.fetch(request)
//            
//            // Force load faulted data
//            for favorite in favorites {
//                context.refresh(favorite, mergeChanges: true) // Ensures attributes are loaded
//                _ = favorite.colors // Access colors to trigger fetching
//            }
//            
//            return favorites
//        } catch {
//            print("Failed to fetch favorites: \(error)")
//            return []
//        }
//    }
//
//    
//    private func saveContext() {
//        do {
//            try context.save()
//        } catch {
//            print("Failed to save: \(error)")
//        }
//    }
//}
//
//  CoreDataManager.swift
//  Color Palette
//
//  Created by mac on 03/03/2025.
//

//import CoreData
//import UIKit
//
//class CoreDataManager {
//    static let shared = CoreDataManager()
//    
//    private init() {}
//    
//    lazy var persistentContainer: NSPersistentContainer = {
//        let container = NSPersistentContainer(name: "Color_Palette") // Make sure the name matches your xcdatamodeld file
//        container.loadPersistentStores { (_, error) in
//            if let error = error {
//                fatalError("Failed to load Core Data stack: \(error)")
//            }
//        }
//        return container
//    }()
//    
//    var context: NSManagedObjectContext {
//        return persistentContainer.viewContext
//    }
//    
//    func savePalette(_ palette: ColorPalette, in context: NSManagedObjectContext? = nil) {
//        let saveContext = context ?? self.context // Use provided context or default to viewContext
//        do {
//            let fetchRequest = NSFetchRequest<FavNamedColorPalettes>(entityName: "FavNamedColorPalettes")
//            fetchRequest.predicate = NSPredicate(format: "name == %@", palette.name)
//            fetchRequest.fetchLimit = 1
//            
//            let results = try saveContext.fetch(fetchRequest)
//            
//            if results.isEmpty {
//                let favorite = FavNamedColorPalettes(context: saveContext)
//                favorite.name = palette.name
//                favorite.colors = palette.colors as NSObject // Adjust if colors is [String]
//                try saveContext.save()
//                print("Palette '\(palette.name)' saved successfully.")
//            } else {
//                print("Palette '\(palette.name)' already exists.")
//            }
//        } catch {
//            print("Error saving palette: \(error)")
//        }
//    }
//    
//    func fetchFavorites() -> [FavNamedColorPalettes] {
//        let request: NSFetchRequest<FavNamedColorPalettes> = FavNamedColorPalettes.fetchRequest()
//        
//        do {
//            let favorites = try context.fetch(request)
//            
//            // Force load faulted data
//            for favorite in favorites {
//                context.refresh(favorite, mergeChanges: true) // Ensures attributes are loaded
//                _ = favorite.colors // Access colors to trigger fetching
//            }
//            
//            return favorites
//        } catch {
//            print("Failed to fetch favorites: \(error)")
//            return []
//        }
//    }
//    
//    // New method to delete a palette
//    func deletePalette(_ palette: ColorPalette) {
//        let deleteContext = context
//        let fetchRequest = NSFetchRequest<FavNamedColorPalettes>(entityName: "FavNamedColorPalettes")
//        fetchRequest.predicate = NSPredicate(format: "name == %@", palette.name ?? "")
//        fetchRequest.fetchLimit = 1
//        
//        do {
//            let results = try deleteContext.fetch(fetchRequest)
//            if let favoriteToDelete = results.first {
//                deleteContext.delete(favoriteToDelete)
//                try deleteContext.save()
//                print("Palette '\(palette.name ?? "unknown")' deleted successfully.")
//            } else {
//                print("No favorite found with name: \(palette.name ?? "unknown")")
//            }
//        } catch {
//            print("Failed to delete palette: \(error)")
//        }
//    }
//    
//    private func saveContext() {
//        do {
//            try context.save()
//        } catch {
//            print("Failed to save: \(error)")
//        }
//    }
//}


import CoreData
import UIKit

class CoreDataManager {
    static let shared = CoreDataManager()
    
    // Notification name for palette changes
    static let paletteDidChangeNotification = Notification.Name("PaletteDidChangeNotification")
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Color_Palette")
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
        let saveContext = context ?? self.context
        do {
            let fetchRequest = NSFetchRequest<FavNamedColorPalettes>(entityName: "FavNamedColorPalettes")
            fetchRequest.predicate = NSPredicate(format: "name == %@", palette.name)
            fetchRequest.fetchLimit = 1
            
            let results = try saveContext.fetch(fetchRequest)
            
            if results.isEmpty {
                let favorite = FavNamedColorPalettes(context: saveContext)
                favorite.name = palette.name
                favorite.colors = palette.colors as NSObject // Assuming colors is [String]
                try saveContext.save()
                print("Palette '\(palette.name)' saved successfully.")
                
                // Notify other view controllers
                NotificationCenter.default.post(name: CoreDataManager.paletteDidChangeNotification, object: nil)
            } else {
                print("Palette '\(palette.name)' already exists.")
            }
        } catch {
            print("Error saving palette: \(error)")
        }
    }
    
    func deletePalette(_ palette: ColorPalette) {
        let deleteContext = context
        let fetchRequest = NSFetchRequest<FavNamedColorPalettes>(entityName: "FavNamedColorPalettes")
        fetchRequest.predicate = NSPredicate(format: "name == %@", palette.name ?? "")
        fetchRequest.fetchLimit = 1
        
        do {
            let results = try deleteContext.fetch(fetchRequest)
            if let favoriteToDelete = results.first {
                deleteContext.delete(favoriteToDelete)
                try deleteContext.save()
                print("Palette '\(palette.name ?? "unknown")' deleted successfully.")
                
                // Notify other view controllers
                NotificationCenter.default.post(name: CoreDataManager.paletteDidChangeNotification, object: nil)
            } else {
                print("No favorite found with name: \(palette.name ?? "unknown")")
            }
        } catch {
            print("Failed to delete palette: \(error)")
        }
    }
    
    func fetchFavorites() -> [FavNamedColorPalettes] {
        let request: NSFetchRequest<FavNamedColorPalettes> = FavNamedColorPalettes.fetchRequest()
        do {
            let favorites = try context.fetch(request)
            for favorite in favorites {
                context.refresh(favorite, mergeChanges: true)
                _ = favorite.colors
            }
            return favorites
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
