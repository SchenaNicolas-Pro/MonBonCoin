//
//  CoreDataStack.swift
//  MonBonCoin
//
//  Created by Nicolas Schena on 03/10/2023.
//

import Foundation
import CoreData

final class CoreDataStack {

    //MARK: - Properties
    private let persistentContainerName = "MonBonCoin"
    
    //MARK: - Public
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    //MARK: - Private
    lazy var persistentContainer: NSPersistentContainer = {
       let container = NSPersistentContainer(name: persistentContainerName)
        container.loadPersistentStores(completionHandler: { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo) for: \(storeDescription.description)")
            }
        })
        return container
    }()
}
