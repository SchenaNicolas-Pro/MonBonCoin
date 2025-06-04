//
//  PopUpInformationScrollView.swift
//  MonBonCoin
//
//  Created by Nicolas Schena on 24/09/2023.
//

import UIKit

class PopUpInformationScrollView: UIScrollView {
    let maxWidth = UIScreen.main.bounds.width - 10
    
    let eventLabel = PopUpInformationView(title: "Event")
    let dateLabel = PopUpInformationView(title: "Date")
    let adressLabel = PopUpInformationView(title: "Adress")
    let priceLabel = PopUpInformationView(title: "Price")
    let scheduleLabel = PopUpInformationView(title: "Schedule")
    let phoneLabel = PopUpInformationView(title: "Phone")
    let emailLabel = PopUpInformationView(title: "E-Mail")
    let descriptionLabel = PopUpInformationView(title: "Description")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .popUpBackgroundColor
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(eventLabel)
        addSubview(dateLabel)
        addSubview(adressLabel)
        addSubview(priceLabel)
        addSubview(scheduleLabel)
        addSubview(phoneLabel)
        addSubview(emailLabel)
        addSubview(descriptionLabel)
    
        NSLayoutConstraint.activate([
            eventLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            eventLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            eventLabel.widthAnchor.constraint(equalToConstant: maxWidth)
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: eventLabel.bottomAnchor, constant: 10),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            dateLabel.widthAnchor.constraint(equalToConstant: maxWidth)
        ])
        
        NSLayoutConstraint.activate([
            adressLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
            adressLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            adressLabel.widthAnchor.constraint(equalToConstant: maxWidth)
        ])
        
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: adressLabel.bottomAnchor, constant: 10),
            priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            priceLabel.widthAnchor.constraint(equalToConstant: maxWidth)
        ])
        
        NSLayoutConstraint.activate([
            scheduleLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10),
            scheduleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            scheduleLabel.widthAnchor.constraint(equalToConstant: maxWidth)
        ])
        
        NSLayoutConstraint.activate([
            phoneLabel.topAnchor.constraint(equalTo: scheduleLabel.bottomAnchor, constant: 10),
            phoneLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            phoneLabel.widthAnchor.constraint(equalToConstant: maxWidth)
        ])
        
        NSLayoutConstraint.activate([
            emailLabel.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 10),
            emailLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            emailLabel.widthAnchor.constraint(equalToConstant: maxWidth)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            descriptionLabel.widthAnchor.constraint(equalToConstant: maxWidth),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
