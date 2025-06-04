//
//  ConformateService.swift
//  MonBonCoin
//
//  Created by Nicolas Schena on 18/09/2023.
//

import Foundation

final class ConformateMethod {
    func conformate(_ responseJSON: SearchElement, tag: String) -> [LocationInformation] {
        let conformInformation = responseJSON.compactMap({
            LocationInformation(title: $0?.rdfsLabel?.conformWithLineBreak() ?? "",
                                phone: $0?.hasContact?.compactMap{ $0.schemaTelephone?.conformWithLineBreak()}.conformWithLineBreak() ?? "",
                                email: $0?.hasContact?.compactMap{ $0.schemaEmail?.conformWithLineBreak()}.conformWithLineBreak() ?? "",
                                homepage: $0?.hasContact?.compactMap{ $0.foafHomepage?.conformWithLineBreak()}.conformWithLineBreak() ?? "",
                                image: $0?.hasRepresentation?.first?.ebucoreLocator.first ?? "",
                                streetAddress: $0?.isLocatedAt?.schemaStreetAddress?.conformWithLineBreak() ?? "",
                                postalCode: $0?.isLocatedAt?.schemaPostalCode?.conformWithLineBreak() ?? "",
                                locality: $0?.isLocatedAt?.schemaAddressLocality?.conformWithLineBreak() ?? "",
                                describe: $0?.rdfsComment?.conformWithLineBreak() ?? "",
                                openingHours: openingHours(hours: $0),
                                additionalSchedule: $0?.schemaOpeningHoursSpecification?.compactMap{ $0.additionalInformation}.conformWithLineBreak() ?? "",
                                price: price(prices: $0),
                                tag: tag)
        })
        return conformInformation
    }
    
    // Set max decimal to 1
    private func formatDecimal(number: Double) -> String {
        let format = NumberFormatter()
        format.minimumFractionDigits = 0
        format.maximumFractionDigits = 1
        format.decimalSeparator = "."
        guard let value = format.string(from: NSNumber(value: number)) else { return ""}
        return value
    }
    
    private func price(prices: SearchElementClass?) -> String {
        let maxPrice = prices?.schemaMaxPrice?.compactMap{ Double($0) } ?? []
        let minPrice = prices?.schemaMinPrice?.compactMap{ Double($0) } ?? []
        
        let sortedMaxPrice = sortedPrice(price: maxPrice)
        let sortedMinPrice = sortedPrice(price: minPrice)
        
        let combinedArray = zip(sortedMinPrice, sortedMaxPrice)
        if sortedMinPrice.first == "" || sortedMaxPrice.first == "" { return "" }
        let prices = combinedArray.compactMap { minPrice, maxPrice in
            return "\(minPrice)€ - \(maxPrice)€"
        }
        
        let allPrice = prices.conformWithLineBreak()
        return allPrice
    }
    
    private func sortedPrice(price: [Double]) -> [String] {
        let sortedPrice = price.sorted().map{ formatDecimal(number: $0)}
        return sortedPrice
    }
    
    private func openingHours(hours: SearchElementClass?) -> String {
        let openHoursSet = hours?.schemaOpeningHoursSpecification?.compactMap{ formatHour($0.schemaOpens ?? "") } ?? []
        let closeHoursSet = hours?.schemaOpeningHoursSpecification?.compactMap{ formatHour($0.schemaCloses ?? "") } ?? []
        
        if openHoursSet.first == "" || closeHoursSet.first == "" { return "" }
        
        let combinedArray = zip(openHoursSet, closeHoursSet)
        let formattedHours = Set(combinedArray.compactMap { openHour, closeHour in
            return "\(openHour) - \(closeHour)"
        })
        
        let openingHours = formattedHours.joined(separator: "\n")
        return openingHours
    }
    
    private func formatHour(_ hour: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        
        if let date = dateFormatter.date(from: hour) {
            dateFormatter.dateFormat = "HH:mm"
            return dateFormatter.string(from: date)
        }
        
        return hour
    }
}
