//
//  HistoryRecord+CoreDataProperties.swift
//  MonBonCoin
//
//  Created by Nicolas Schena on 29/12/2023.
//
//

import Foundation
import CoreData


public class HistoryRecord: NSManagedObject {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<HistoryRecord> {
        return NSFetchRequest<HistoryRecord>(entityName: "HistoryRecord")
    }
    
    @NSManaged public var historyDate: Date?
    @NSManaged public var location: Location?
}
