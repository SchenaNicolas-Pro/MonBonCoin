//
//  HistoryRecord+CoreDataClass.swift
//  MonBonCoin
//
//  Created by Nicolas Schena on 29/12/2023.
//
//

import Foundation
import CoreData

@objc(HistoryRecord)
public class HistoryRecord: NSManagedObject {

    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<HistoryRecord> {
        return NSFetchRequest<HistoryRecord>(entityName: "HistoryRecord")
    }

    @NSManaged public var historyDate: Date?
    @NSManaged public var locations: NSSet?

    @objc(addLocationsObject:)
    @NSManaged public func addToLocations(_ value: Location)

    @objc(removeLocationsObject:)
    @NSManaged public func removeFromLocations(_ value: Location)

    @objc(addLocations:)
    @NSManaged public func addToLocations(_ values: NSSet)

    @objc(removeLocations:)
    @NSManaged public func removeFromLocations(_ values: NSSet)
}
