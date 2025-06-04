//
//  StaticSearchDataResponse.swift
//  MonBonCoinTests
//
//  Created by Nicolas Schena on 16/01/2024.
//

import Foundation
@testable import MonBonCoin

class StaticSearchDataResponse {
    static let title = "Hôtel Le Relais Nordique"
    static let phone = "+33 4 50 59 81 25"
    static let email = "le.relais.nordique@gmail.com"
    static let homepage = "http://www.le-relais-nordique.com/"
    static let image = "https://upload.wikimedia.org/wikipedia/commons/b/b6/Maison_Monsieur_Beynier_-_Ch%C3%A2tillon-sur-Chalaronne_%28FR01%29_-_2023-07-18_-_1.jpg"
    static let streetAddress = "50 route de la Pesse"
    static let postalCode = "01130"
    static let locality = "Giron"
    static let describe = "Hôtel de montagne entièrement rénové : de la chambre single à la suite familiale de 6 places. Lieu idéal pour étape et séjour en famille ou groupe. Chambres spacieuses de 18 à 45m² entièrement équipée : WIFI, TV, salle de bains et wcséparés."
    static let openingHours = "07:00 - 00:00"
    static let wrongOpeningHours = ""
    static let additionalSchedule = "Fermé le dimanche soir."
    static let price = "7€ - 10€"
    static let wrongPrice = ""
}

class StaticLocationInformationDataResponse {
    static let firstLocation = LocationInformation(title: "Hôtel Le Relais Nordique",
                                                   phone: "+33 4 50 59 81 25",
                                                   email: "le.relais.nordique@gmail.com",
                                                   homepage: "http://www.le-relais-nordique.com/",
                                                   image: "https://upload.wikimedia.org/wikipedia/commons/b/b6/Maison_Monsieur_Beynier_-_Ch%C3%A2tillon-sur-Chalaronne_%28FR01%29_-_2023-07-18_-_1.jpg",
                                                   streetAddress: "50 route de la Pesse",
                                                   postalCode: "01130",
                                                   locality: "Giron",
                                                   describe: "Hôtel de montagne entièrement rénové : de la chambre single à la suite familiale de 6 places. Lieu idéal pour étape et séjour en famille ou groupe. Chambres spacieuses de 18 à 45m² entièrement équipée : WIFI, TV, salle de bains et wcséparés.",
                                                   openingHours: "07:00 - 00:00",
                                                   additionalSchedule: "Fermé le dimanche soir.",
                                                   price: "7€ - 10€",
                                                   tag: "Restauration")
    
    static let secondLocation = LocationInformation(title: "Chez le Père Durdu",
                                                    phone: "+33 6 88 70 32 47",
                                                    email: "hakan.durdu@orange.fr",
                                                    homepage: "http://www.restaurant-nantua.com/",
                                                    image: "",
                                                    streetAddress: "3 route de la Cluse",
                                                    postalCode: "01130",
                                                    locality: "Nantua",
                                                    describe: "Une cuisine soignée et un emplacement idéal au bord du lac ont fait la réputation de cet établissement familial. On vient pour y déguster aussi bien le fameux \"gratin du lac\" (excellente quenelle de Nantua tranchée).",
                                                    openingHours: "",
                                                    additionalSchedule: "Fermé le lundi, le mardi soir et le dimanche soir.",
                                                    price: "",
                                                    tag: "Restauration")
    
    static let thirdLocation = LocationInformation(title: "Bar - Restaurant by FTH",
                                                   phone: "+33 9 81 83 97 87",
                                                   email: "fatih.ugur.pro@gmail.com",
                                                   homepage: "https://www.by-fth.fr/",
                                                   image: "",
                                                   streetAddress: "12 Place de la république",
                                                   postalCode: "01400",
                                                   locality: "Châtillon-sur-Chalaronne",
                                                   describe: "By FTH vous propose une sélection de tapas, burgers et tacos\r\nLes plats sont accompagnés de frites et de sauces pour toutes les envies gourmandes. Découvrez également leurs délicieux cocktails faits maison.",
                                                   openingHours: "07:00 - 00:00",
                                                   additionalSchedule: "",
                                                   price: "12€ - 16€",
                                                   tag: "Restauration")
    
    static let fourthLocation = LocationInformation(title: "Bar glacier Le Kiosque",
                                                    phone: "+33 6 99 70 40 23",
                                                    email: "thibert.laurent0178@orange.fr",
                                                    homepage: "http://lekiosque-nantua.fr/",
                                                    image: "",
                                                    streetAddress: "2 Avenue du Lac",
                                                    postalCode: "01130",
                                                    locality: "Nantua",
                                                    describe: "Dès les beaux jours et pendant les 3 mois d'été, la terrasse ne désemplit pas. Confortablement installé au bord du lac de Nantua, la tentation est grande : boissons fraîches, glaces délicieuses ou gaufres moelleuses ...  Egalement location de pédal'eau.",
                                                    openingHours: "09:00 - 23:45",
                                                    additionalSchedule: "Fermeture à 1h à partir du 15juin\r\nOuvert l'après midi seulement le reste de l'année",
                                                    price: "",
                                                    tag: "Restauration")
}
