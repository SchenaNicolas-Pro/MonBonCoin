//
//  SideMenuView.swift
//  MonBonCoin
//
//  Created by Nicolas Schena on 11/09/2023.
//

import UIKit

class SideMenuView: UIView {

    let allSiteButton = SideMenuButton(title: "Tout", eventTitle: nil)
    let restaurationButton = SideMenuButton(title: "Restauration", eventTitle: "Restauration")
    let culturalSiteButton = SideMenuButton(title: "Site Culturel", eventTitle: "Cultural")
    let sportSiteButton = SideMenuButton(title: "Sport et Divertissement", eventTitle: "Sport")
    let walkBikeSiteButton = SideMenuButton(title: "Promenade et Vélo", eventTitle: "Ride")
    let eventSiteButton = SideMenuButton(title: "Événements", eventTitle: "Event")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        addSubview(allSiteButton)
        addSubview(restaurationButton)
        addSubview(culturalSiteButton)
        addSubview(sportSiteButton)
        addSubview(walkBikeSiteButton)
        addSubview(eventSiteButton)
        
        eventSiteButton.bottomBlackBorder.isHidden = true

        NSLayoutConstraint.activate([
            allSiteButton.topAnchor.constraint(equalTo: topAnchor),
            allSiteButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            allSiteButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            allSiteButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            restaurationButton.topAnchor.constraint(equalTo: allSiteButton.bottomAnchor, constant: 2),
            restaurationButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            restaurationButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            restaurationButton.heightAnchor.constraint(equalToConstant: 60)
        ])

        NSLayoutConstraint.activate([
            culturalSiteButton.topAnchor.constraint(equalTo: restaurationButton.bottomAnchor, constant: 2),
            culturalSiteButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            culturalSiteButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            culturalSiteButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            sportSiteButton.topAnchor.constraint(equalTo: culturalSiteButton.bottomAnchor, constant: 2),
            sportSiteButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            sportSiteButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            sportSiteButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            walkBikeSiteButton.topAnchor.constraint(equalTo: sportSiteButton.bottomAnchor, constant: 2),
            walkBikeSiteButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            walkBikeSiteButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            walkBikeSiteButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            eventSiteButton.topAnchor.constraint(equalTo: walkBikeSiteButton.bottomAnchor, constant: 2),
            eventSiteButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            eventSiteButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            eventSiteButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureView() {
        backgroundColor = UIColor.menuColor
        layer.cornerRadius = 8.0
        layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        layer.borderWidth = 2
        layer.borderColor = UIColor.black.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
