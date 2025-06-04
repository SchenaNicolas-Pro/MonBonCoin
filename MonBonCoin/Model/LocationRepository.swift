//
//  LocationRepository.swift
//  MonBonCoin
//
//  Created by Nicolas Schena on 19/10/2023.
//

import Foundation
import CoreData

final class LocationRepository {
    
    // MARK: - Properties
    private let coreDataStack: CoreDataStack
    
    // MARK: - Init
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
    }
    
    // MARK: - Favorite
    func manageFavorite(location: Location) throws -> Bool {
        if location.isFavorite == true {
            location.isFavorite = false
            try coreDataStack.viewContext.save()
            return false
        }
        location.isFavorite = true
        try coreDataStack.viewContext.save()
        return true
    }
    
    func getFavorite() throws -> [Location] {
        let request: NSFetchRequest<Location> = Location.fetchRequest()
        let predicate = NSPredicate(format: "isFavorite == %@", NSNumber(value: true))
        request.predicate = predicate
        let location = try coreDataStack.viewContext.fetch(request)
        
        return location
    }
    
    // MARK: - History
    func manageHistory(location: Location) {
        do {
            let historyList = try getHistory()
            if historyList.map({ $0.location }).contains(location) {
                return
            } else if historyList.count > 30 {
                try deleteHistory()
                try saveHistory(location: location)
            } else {
                try saveHistory(location: location)
            }
        } catch {
            print("Error handling history: \(error.localizedDescription)")
        }
    }
    
    func getHistory() throws -> [HistoryRecord] {
        let request: NSFetchRequest<HistoryRecord> = HistoryRecord.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "historyDate", ascending: false)
        request.sortDescriptors = [sortDescriptor]
        
        let history = try coreDataStack.viewContext.fetch(request)
        return history
    }
    
    private func saveHistory(location: Location) throws {
        let currentDate = Date()
        let newHistoryRecord = HistoryRecord(context: coreDataStack.viewContext)
        
        newHistoryRecord.historyDate = currentDate
        newHistoryRecord.location = location
        try coreDataStack.viewContext.save()
    }
    
    private func deleteHistory() throws {
        let request: NSFetchRequest<HistoryRecord> = HistoryRecord.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "historyDate", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        request.fetchLimit = 1
        
        if let oldestVisitRecord = try coreDataStack.viewContext.fetch(request).first {
            coreDataStack.viewContext.delete(oldestVisitRecord)
        }
    }
    
    // MARK: - Location
    func saveLocation(with locationList: [LocationInformation]) async throws {
        let taskContext = coreDataStack.persistentContainer.newBackgroundContext()
        
        try await taskContext.perform {
            let dictionnaries = locationList.map { $0.information}
            let batchInsertRequest = NSBatchInsertRequest(entity: Location.entity(), objects: dictionnaries)
            try taskContext.execute(batchInsertRequest)
        }
    }
    
    func getLocation(forDepartment department: String, withCategory category: [String]) throws -> [Location] {
        let request: NSFetchRequest<Location> = Location.fetchRequest()
        let departmentPredicate = NSPredicate(format: "postalCode BEGINSWITH %@", department)
        let categoryPredicate = NSPredicate(format: "tag IN %@", category)
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [departmentPredicate, categoryPredicate])
        
        let location = try coreDataStack.persistentContainer.viewContext.fetch(request)
        return location
    }
}
