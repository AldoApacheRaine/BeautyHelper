//
//  CoreDataManager.swift
//  BeautyHelper
//
//  Created by Максим Хмелев on 16.01.2023.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    private init() {}
    
    lazy var context: NSManagedObjectContext = {
        persistentContainer.viewContext
    }()
    
    func entityForName(_ entityName: String) -> NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: entityName, in: context)!
    }
    
    func getSavedProducts() -> [Product] {
        var products = [Product]()
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        do {
            products = try CoreDataManager.shared.context.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return products
    }
    
    func delete(_ product : Product){
        let managedContext = persistentContainer.viewContext
        managedContext.delete(product)
        do {
            try managedContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "History")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
