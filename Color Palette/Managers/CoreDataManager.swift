//
//import CoreData
//import UIKit
//
//class CoreDataManager {
//    static let shared = CoreDataManager()
//    
//    static let paletteDidChangeNotification = Notification.Name("PaletteDidChangeNotification")
//    
//    private init() {}
//    
//    lazy var persistentContainer: NSPersistentContainer = {
//        let container = NSPersistentContainer(name: "Color_Palette")
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
//    // Existing methods for FavNamedColorPalettes
//    func savePalette(_ palette: ColorPalette, in context: NSManagedObjectContext? = nil) {
//        let saveContext = context ?? self.context
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
//                favorite.colors = palette.colors as NSObject
//                try saveContext.save()
//                print("Palette '\(palette.name)' saved successfully.")
//                NotificationCenter.default.post(name: CoreDataManager.paletteDidChangeNotification, object: nil)
//            } else {
//                print("Palette '\(palette.name)' already exists.")
//            }
//        } catch {
//            print("Error saving palette: \(error)")
//        }
//    }
//    
//    func deletePalette(_ palette: ColorPalette) {
//        let deleteContext = context
//        let fetchRequest = NSFetchRequest<FavNamedColorPalettes>(entityName: "FavNamedColorPalettes")
//        fetchRequest.predicate = NSPredicate(format: "name == %@", palette.name )
//        fetchRequest.fetchLimit = 1
//        
//        do {
//            let results = try deleteContext.fetch(fetchRequest)
//            if let favoriteToDelete = results.first {
//                deleteContext.delete(favoriteToDelete)
//                try deleteContext.save()
//                print("Palette '\(palette.name)' deleted successfully.")
//                NotificationCenter.default.post(name: CoreDataManager.paletteDidChangeNotification, object: nil)
//            } else {
//                print("No favorite found with name: \(palette.name)")
//            }
//        } catch {
//            print("Failed to delete palette: \(error)")
//        }
//    }
//    
//    func fetchFavorites() -> [FavNamedColorPalettes] {
//        let request: NSFetchRequest<FavNamedColorPalettes> = FavNamedColorPalettes.fetchRequest()
//        do {
//            let favorites = try context.fetch(request)
//            for favorite in favorites {
//                context.refresh(favorite, mergeChanges: true)
//                _ = favorite.colors
//            }
//            return favorites
//        } catch {
//            print("Failed to fetch favorites: \(error)")
//            return []
//        }
//    }
//    
//    // New methods for SingleColor
//    func saveSingleColor(name: String) {
//        let saveContext = context
//        do {
//            let fetchRequest = NSFetchRequest<SingleColor>(entityName: "SingleColor")
//            fetchRequest.predicate = NSPredicate(format: "name == %@", name)
//            fetchRequest.fetchLimit = 1
//            
//            let results = try saveContext.fetch(fetchRequest)
//            
//            if results.isEmpty {
//                let singleColor = SingleColor(context: saveContext)
//                singleColor.name = name
//                try saveContext.save()
//                print("SingleColor '\(name)' saved successfully.")
//                NotificationCenter.default.post(name: CoreDataManager.paletteDidChangeNotification, object: nil)
//            } else {
//                print("SingleColor '\(name)' already exists.")
//            }
//        } catch {
//            print("Error saving SingleColor: \(error)")
//        }
//    }
//    
//    func deleteSingleColor(name: String) {
//        let deleteContext = context
//        let fetchRequest = NSFetchRequest<SingleColor>(entityName: "SingleColor")
//        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
//        fetchRequest.fetchLimit = 1
//        
//        do {
//            let results = try deleteContext.fetch(fetchRequest)
//            if let colorToDelete = results.first {
//                deleteContext.delete(colorToDelete)
//                try deleteContext.save()
//                print("SingleColor '\(name)' deleted successfully.")
//                NotificationCenter.default.post(name: CoreDataManager.paletteDidChangeNotification, object: nil)
//            } else {
//                print("No SingleColor found with name: \(name)")
//            }
//        } catch {
//            print("Failed to delete SingleColor: \(error)")
//        }
//    }
//    
//    func fetchSingleColors() -> [SingleColor] {
//        let request: NSFetchRequest<SingleColor> = SingleColor.fetchRequest()
//        do {
//            let colors = try context.fetch(request)
//            return colors
//        } catch {
//            print("Failed to fetch SingleColors: \(error)")
//            return []
//        }
//    }
//    
//    func isSingleColorSaved(name: String) -> Bool {
//        let fetchRequest = NSFetchRequest<SingleColor>(entityName: "SingleColor")
//        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
//        fetchRequest.fetchLimit = 1
//        
//        do {
//            let results = try context.fetch(fetchRequest)
//            return !results.isEmpty
//        } catch {
//            print("Error checking SingleColor: \(error)")
//            return false
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
//    func deleteAllData(in context: NSManagedObjectContext) {
//            do {
//                // Get the persistent store coordinator
//                guard let persistentStoreCoordinator = context.persistentStoreCoordinator else { return }
//                
//                // Get all entity descriptions from the managed object model
//                let entities = persistentStoreCoordinator.managedObjectModel.entities
//                
//                for entity in entities {
//                    guard let entityName = entity.name else { continue }
//                    
//                    // Create a fetch request for the entity
//                    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
//                    let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
//                    
//                    // Execute the batch delete request
//                    try context.execute(batchDeleteRequest)
//                }
//                
//                // Save the context to persist changes
//                try context.save()
//                print("All data deleted successfully.")
//                NotificationCenter.default.post(name: CoreDataManager.paletteDidChangeNotification, object: nil)
//            } catch {
//                print("Failed to delete data: \(error)")
//            }
//        }
//    
//    func deleteAllData() {
//            deleteAllData(in: context)
//        }
//    
//    
//}

import CoreData
import UIKit

class CoreDataManager {
    static let shared = CoreDataManager()
    static let paletteDidChangeNotification = Notification.Name("PaletteDidChangeNotification")
    static let showPremiumScreenNotification = Notification.Name("ShowPremiumScreenNotification")
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Color_Palette")
        container.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
            print("Core Data stack loaded successfully.")
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func savePalette(_ palette: ColorPalette, in context: NSManagedObjectContext? = nil) {
        let saveContext = context ?? self.context
        do {
            // Check current count for non-premium users
            let fetchRequestCount = NSFetchRequest<FavNamedColorPalettes>(entityName: "FavNamedColorPalettes")
            let currentPalettes = try saveContext.fetch(fetchRequestCount)
            if !isPremiumUser() && currentPalettes.count >= 2 {
                print("Non-premium user limit reached: \(currentPalettes.count) palettes already saved.")
                NotificationCenter.default.post(name: CoreDataManager.showPremiumScreenNotification, object: nil)
                return
            }
            
            // Check for duplicates
            let fetchRequest = NSFetchRequest<FavNamedColorPalettes>(entityName: "FavNamedColorPalettes")
            fetchRequest.predicate = NSPredicate(format: "name == %@", palette.name)
            fetchRequest.fetchLimit = 1
            
            let results = try saveContext.fetch(fetchRequest)
            
            if results.isEmpty {
                let favorite = FavNamedColorPalettes(context: saveContext)
                favorite.name = palette.name
                favorite.colors = palette.colors as NSObject
                try saveContext.save()
                print("Palette '\(palette.name)' saved successfully.")
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
        fetchRequest.predicate = NSPredicate(format: "name == %@", palette.name)
        fetchRequest.fetchLimit = 1
        
        do {
            let results = try deleteContext.fetch(fetchRequest)
            if let favoriteToDelete = results.first {
                deleteContext.delete(favoriteToDelete)
                try deleteContext.save()
                print("Palette '\(palette.name)' deleted successfully.")
                NotificationCenter.default.post(name: CoreDataManager.paletteDidChangeNotification, object: nil)
            } else {
                print("No favorite found with name: \(palette.name)")
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
            print("Fetched \(favorites.count) favorite palettes.")
            return favorites
        } catch {
            print("Failed to fetch favorites: \(error)")
            return []
        }
    }
    
    func saveSingleColor(name: String) {
        let saveContext = context
        do {
            // Check current count for non-premium users
            let fetchRequestCount = NSFetchRequest<SingleColor>(entityName: "SingleColor")
            let currentColors = try saveContext.fetch(fetchRequestCount)
            if !isPremiumUser() && currentColors.count >= 2 {
                print("Non-premium user limit reached: \(currentColors.count) single colors already saved.")
                NotificationCenter.default.post(name: CoreDataManager.showPremiumScreenNotification, object: nil)
                return
            }
            
            // Check for duplicates
            let fetchRequest = NSFetchRequest<SingleColor>(entityName: "SingleColor")
            fetchRequest.predicate = NSPredicate(format: "name == %@", name)
            fetchRequest.fetchLimit = 1
            
            let results = try saveContext.fetch(fetchRequest)
            
            if results.isEmpty {
                let singleColor = SingleColor(context: saveContext)
                singleColor.name = name
                try saveContext.save()
                print("SingleColor '\(name)' saved successfully.")
                NotificationCenter.default.post(name: CoreDataManager.paletteDidChangeNotification, object: nil)
            } else {
                print("SingleColor '\(name)' already exists.")
            }
        } catch {
            print("Error saving SingleColor: \(error)")
        }
    }
    
    func deleteSingleColor(name: String) {
        let deleteContext = context
        let fetchRequest = NSFetchRequest<SingleColor>(entityName: "SingleColor")
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        fetchRequest.fetchLimit = 1
        
        do {
            let results = try deleteContext.fetch(fetchRequest)
            if let colorToDelete = results.first {
                deleteContext.delete(colorToDelete)
                try deleteContext.save()
                print("SingleColor '\(name)' deleted successfully.")
                NotificationCenter.default.post(name: CoreDataManager.paletteDidChangeNotification, object: nil)
            } else {
                print("No SingleColor found with name: \(name)")
            }
        } catch {
            print("Failed to delete SingleColor: \(error)")
        }
    }
    
    func fetchSingleColors() -> [SingleColor] {
        let request: NSFetchRequest<SingleColor> = SingleColor.fetchRequest()
        do {
            let colors = try context.fetch(request)
            print("Fetched \(colors.count) single colors.")
            return colors
        } catch {
            print("Failed to fetch SingleColors: \(error)")
            return []
        }
    }
    
    func isSingleColorSaved(name: String) -> Bool {
        let fetchRequest = NSFetchRequest<SingleColor>(entityName: "SingleColor")
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        fetchRequest.fetchLimit = 1
        
        do {
            let results = try context.fetch(fetchRequest)
            return !results.isEmpty
        } catch {
            print("Error checking SingleColor: \(error)")
            return false
        }
    }
    
    private func saveContext() {
        do {
            try context.save()
            print("Context saved successfully.")
        } catch {
            print("Failed to save context: \(error)")
        }
    }
    
    func deleteAllData(in context: NSManagedObjectContext) {
        do {
            guard let persistentStoreCoordinator = context.persistentStoreCoordinator else { return }
            let entities = persistentStoreCoordinator.managedObjectModel.entities
            for entity in entities {
                guard let entityName = entity.name else { continue }
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
                let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
                try context.execute(batchDeleteRequest)
            }
            try context.save()
            print("All data deleted successfully.")
            NotificationCenter.default.post(name: CoreDataManager.paletteDidChangeNotification, object: nil)
        } catch {
            print("Failed to delete data: \(error)")
        }
    }
    
    func deleteAllData() {
        deleteAllData(in: context)
    }
    
    private func isPremiumUser() -> Bool {
        // Check premium status using UserDefaults keys from ProScreenVC
        return UserDefaults.standard.bool(forKey: "IS_LIFETIME_USER") ||
               UserDefaults.standard.bool(forKey: "IS_SUBSCRIBED_USER")
    }
}
