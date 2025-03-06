//
//  FetechingCoreData.swift
//  Color Palette
//
//  Created by mac on 03/03/2025.
//

import CoreData
import UIKit

func fetchSavedData() {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let context = appDelegate.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavNamedColorPalettes")

    do {
        let results = try context.fetch(fetchRequest)
        
        for result in results {
            //print(result)  // Print the entire object
            print(result.value(forKey: "colors") ?? "No data")  // Print specific attribute
        }
    } catch {
        print("Failed to fetch data: \(error)")
    }
}
