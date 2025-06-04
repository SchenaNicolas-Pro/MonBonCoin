
import Foundation

// MARK: - SearchElementClass
struct SearchElementClass: Decodable {
    let hasContact: [HasContact]?
    let hasRepresentation: [HasRepresentation]?
    let isLocatedAt: IsLocatedAt?
    let rdfsComment: [String]?
    let rdfsLabel: [String]?
    let schemaOpeningHoursSpecification: [SchemaOpeningHoursSpecification]?
    let startDate, endDate, schemaMaxPrice, schemaMinPrice: [String]?
    let schemaPriceCurrency: [SchemaPriceCurrency]?

    enum CodingKeys: String, CodingKey {
        case hasContact, hasRepresentation, isLocatedAt
        case rdfsComment = "rdfs:comment"
        case rdfsLabel = "rdfs:label"
        case schemaOpeningHoursSpecification = "schema:openingHoursSpecification"
        case endDate
        case schemaMaxPrice = "schema:maxPrice"
        case schemaMinPrice = "schema:minPrice"
        case schemaPriceCurrency = "schema:priceCurrency"
        case startDate
    }
}

// MARK: - HasContact
struct HasContact: Decodable {
    let foafHomepage: [String]?
    let schemaTelephone, schemaEmail: [String]?

    enum CodingKeys: String, CodingKey {
        case foafHomepage = "foaf:homepage"
        case schemaTelephone = "schema:telephone"
        case schemaEmail = "schema:email"
    }
}

// MARK: - HasRepresentation
struct HasRepresentation: Decodable {
    let ebucoreLocator: [String]

    enum CodingKeys: String, CodingKey {
        case ebucoreLocator = "ebucore:locator"
    }
}

// MARK: - IsLocatedAt
struct IsLocatedAt: Decodable {
    let schemaAddressLocality, schemaLatitude, schemaLongitude, schemaPostalCode: [String]?
    let schemaStreetAddress: [String]?

    enum CodingKeys: String, CodingKey {
        case schemaAddressLocality = "schema:addressLocality"
        case schemaLatitude = "schema:latitude"
        case schemaLongitude = "schema:longitude"
        case schemaPostalCode = "schema:postalCode"
        case schemaStreetAddress = "schema:streetAddress"
    }
}

// MARK: - SchemaOpeningHoursSpecification
struct SchemaOpeningHoursSpecification: Decodable {
    let additionalInformation, schemaCloses, schemaOpens, schemaValidFrom: String?
    let schemaValidThrough: String?

    enum CodingKeys: String, CodingKey {
        case additionalInformation
        case schemaCloses = "schema:closes"
        case schemaOpens = "schema:opens"
        case schemaValidFrom = "schema:validFrom"
        case schemaValidThrough = "schema:validThrough"
    }
}

enum SchemaPriceCurrency: String, Decodable {
    case eur = "EUR"
}

typealias SearchElement = [SearchElementClass?]

