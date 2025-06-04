//
//  Location+CoreDataClass.swift
//  MonBonCoin
//
//  Created by Nicolas Schena on 13/11/2023.
//
//

import Foundation
import CoreData


public class Location: NSManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location")
    }

    @NSManaged public var additionalSchedule: String
    @NSManaged public var openingHours: String
    @NSManaged public var describe: String
    @NSManaged public var email: String
    @NSManaged public var homepage: String
    @NSManaged public var image: String
    @NSManaged public var locality: String
    @NSManaged public var phone: String
    @NSManaged public var postalCode: String
    @NSManaged public var price: String
    @NSManaged public var streetAddress: String
    @NSManaged public var title: String
    @NSManaged public var tag: String
    @NSManaged public var isFavorite: Bool
}
