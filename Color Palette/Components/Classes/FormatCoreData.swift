//
//  FormatCoreData.swift
//  Color Palette
//
//  Created by mac on 04/03/2025.
//

import CoreData

func deleteAllData(in context: NSManagedObjectContext) {
    do {
        // Get the persistent store coordinator
        guard let persistentStoreCoordinator = context.persistentStoreCoordinator else { return }
        
        // Get all entity descriptions from the managed object model
        let entities = persistentStoreCoordinator.managedObjectModel.entities
        
        for entity in entities {
            guard let entityName = entity.name else { continue }
            
            // Create a fetch request for the entity
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            
            // Execute the batch delete request
            try context.execute(batchDeleteRequest)
        }
        
        // Save the context to persist changes
        try context.save()
        print("All data deleted successfully.")
    } catch {
        print("Failed to delete data: \(error)")
    }
}
