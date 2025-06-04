//
//  CoreDataTestCase.swift
//  MonBonCoinTests
//
//  Created by Nicolas Schena on 16/01/2024.
//

import XCTest
import CoreData
@testable import MonBonCoin

final class CoreDataTestCase: XCTestCase {
    private func setupCoreDataStub() -> LocationRepository {
        let testableCoreData = CoreDataStack()
        testableCoreData.persistentContainer = fakeContainer()
        let repository = LocationRepository(coreDataStack: testableCoreData)
        
        return repository
    }
    
    private func createLocation(from locationInfo: LocationInformation, context: NSManagedObjectContext) -> Location {
        let location = Location(context: context)
        
        location.title = locationInfo.information["title"] ?? ""
        location.phone = locationInfo.information["phone"] ?? ""
        location.email = locationInfo.information["email"] ?? ""
        location.homepage = locationInfo.information["homepage"] ?? ""
        location.image = locationInfo.information["image"] ?? ""
        location.streetAddress = locationInfo.information["streetAddress"] ?? ""
        location.postalCode = locationInfo.information["postalCode"] ?? ""
        location.locality = locationInfo.information["locality"] ?? ""
        location.describe = locationInfo.information["describe"] ?? ""
        location.openingHours = locationInfo.information["openingHours"] ?? ""
        location.additionalSchedule = locationInfo.information["additionalSchedule"] ?? ""
        location.price = locationInfo.information["price"] ?? ""
        location.tag = locationInfo.information["tag"] ?? ""
        
        return location
    }
    
    // MARK: - Registration
    func testGivenCoreDataIsEmptyWhenGetLocationThenLocationIsSavedInCoreData() async {
        let repository = setupCoreDataStub()
        
        let locationFirstAttempt = try? repository.getLocation(forDepartment: "01", withCategory: ["Restauration"])
        
        XCTAssertEqual(locationFirstAttempt, [])
        
        try? await repository.saveLocation(with: [StaticLocationInformationDataResponse.firstLocation])
        
        let locationSecondAttempt = try? repository.getLocation(forDepartment: "01", withCategory: ["Restauration"])
        
        XCTAssertEqual(locationSecondAttempt?[0].title, StaticLocationInformationDataResponse.firstLocation.information["title"])
    }
    
    // MARK: - History
    func testGivenHistoryIsEmptyWhenManageHistoryWithLocationThenHistoryAddedLocation() async {
        let testableCoreData = CoreDataStack()
        testableCoreData.persistentContainer = fakeContainer()
        let repository = LocationRepository(coreDataStack: testableCoreData)
        
        let managedObject = createLocation(from: StaticLocationInformationDataResponse.firstLocation, context: testableCoreData.viewContext)
        
        let locationHistoryFirstAttempt = try? repository.getHistory()
        
        XCTAssertEqual(locationHistoryFirstAttempt, [])
        
        repository.manageHistory(location: managedObject)
        
        let locationHistorySecondAttempt = try? repository.getHistory()
        
        XCTAssertEqual(locationHistorySecondAttempt?[0].location?.title, StaticLocationInformationDataResponse.firstLocation.information["title"])
    }
    
    func testGivenHistorySavedLocationWhenManageSameThenNoDuplicate() async {
        let testableCoreData = CoreDataStack()
        testableCoreData.persistentContainer = fakeContainer()
        let repository = LocationRepository(coreDataStack: testableCoreData)
        
        let managedObject = createLocation(from: StaticLocationInformationDataResponse.firstLocation, context: testableCoreData.viewContext)
        
        repository.manageHistory(location: managedObject)
        
        let locationHistoryFirstAttempt = try? repository.getHistory()
        
        XCTAssertEqual(locationHistoryFirstAttempt?[0].location?.title, StaticLocationInformationDataResponse.firstLocation.information["title"])
        
        repository.manageHistory(location: managedObject)
        
        let locationHistorySecondAttempt = try? repository.getHistory()
        
        XCTAssertEqual(locationHistorySecondAttempt?.count, 1)
    }
    
    func testGivenHistoryIsEmptyWhenAddingFourLocationThenFirstIsDeleted() async {
        let testableCoreData = CoreDataStack()
        testableCoreData.persistentContainer = fakeContainer()
        let repository = LocationRepository(coreDataStack: testableCoreData)
        
        let firstLocation = createLocation(from: StaticLocationInformationDataResponse.firstLocation, context: testableCoreData.viewContext)
        
        let secondLocation = createLocation(from: StaticLocationInformationDataResponse.secondLocation, context: testableCoreData.viewContext)
        
        let thirdLocation = createLocation(from: StaticLocationInformationDataResponse.thirdLocation, context: testableCoreData.viewContext)
        
        let fourthLocation = createLocation(from: StaticLocationInformationDataResponse.fourthLocation, context: testableCoreData.viewContext)
        
        let locationHistoryFirstAttempt = try? repository.getHistory()
        
        XCTAssertEqual(locationHistoryFirstAttempt, [])
        
        repository.manageHistory(location: firstLocation)
        repository.manageHistory(location: secondLocation)
        repository.manageHistory(location: thirdLocation)
        repository.manageHistory(location: fourthLocation)
        
        let locationHistorySecondAttempt = try? repository.getHistory()
        
        XCTAssertNotEqual(locationHistorySecondAttempt?[0].location?.title, StaticLocationInformationDataResponse.firstLocation.information["title"])
        
        XCTAssertEqual(locationHistorySecondAttempt?[0].location?.title, StaticLocationInformationDataResponse.fourthLocation.information["title"])
    }
    
    // MARK: - Favorite
    
    func testGivenFavoriteIsEmptyWhenAddingLocationThenLocationIsAdded() async {
        let testableCoreData = CoreDataStack()
        testableCoreData.persistentContainer = fakeContainer()
        let repository = LocationRepository(coreDataStack: testableCoreData)
        
        let managedObject = createLocation(from: StaticLocationInformationDataResponse.firstLocation, context: testableCoreData.viewContext)
        
        let favoriteLocationFirstAttempt = try? repository.getFavorite()
        
        XCTAssertEqual(favoriteLocationFirstAttempt, [])
        
        try? repository.manageFavorite(location: managedObject)
        
        let favoriteLocationSecondAttempt = try? repository.getFavorite()
        
        XCTAssertEqual(favoriteLocationSecondAttempt?[0].title, managedObject.title)
    }
    
    func testGivenAddLocationWhenManageFavoriteThenLocationIsDelete() async {
        let testableCoreData = CoreDataStack()
        testableCoreData.persistentContainer = fakeContainer()
        let repository = LocationRepository(coreDataStack: testableCoreData)
        
        let managedObject = createLocation(from: StaticLocationInformationDataResponse.firstLocation, context: testableCoreData.viewContext)
        
        try? repository.manageFavorite(location: managedObject)
        
        let favoriteLocationFirstAttempt = try? repository.getFavorite()
        
        XCTAssertEqual(favoriteLocationFirstAttempt?[0].title, managedObject.title)
        
        try? repository.manageFavorite(location: managedObject)
        
        let favoriteLocationSecondAttempt = try? repository.getFavorite()
        
        XCTAssertEqual(favoriteLocationSecondAttempt, [])
    }
}

extension CoreDataTestCase {
    func fakeContainer() -> NSPersistentContainer {
        let container = NSPersistentContainer(name: "MonBonCoin")
        let fileURL = URL(fileURLWithPath: "/dev/null")
        let description = NSPersistentStoreDescription(url: fileURL)
        container.persistentStoreDescriptions = [description]
        
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo) for: \(storeDescription.description)")
            }
        }
        return container
    }
}
