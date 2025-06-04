//
//  PopUpViewController.swift
//  MonBonCoin
//
//  Created by Nicolas Schena on 14/08/2023.
//

import UIKit
import CoreData
import Firebase

protocol PopUpViewControllerDelegate: AnyObject {
    func didDeleteAFavorite(happened: Bool)
}

class PopUpViewController: UIViewController {
    private let popUpView = PopUpView()
    private let tableViewTextLabel = ["- Nom :", "- Date :", "- Addresse :", "- Prix :", "- Horaire :", "- Téléphone :", "- Mail :", "- Description :"]
    
    var locationDetail: Location?
    weak var delegate: PopUpViewControllerDelegate?
    private var homepage = [String]()
    private var informationArray = [String]()
    private var locationRepository: LocationRepository = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let locationRepository = LocationRepository(coreDataStack: appDelegate.coreDataStack)
        return locationRepository
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = popUpView
        popUpView.tableView.dataSource = self
        
        popUpView.backButton.addTarget(self, action: #selector(closeButton), for: .touchUpInside)
        popUpView.goButton.addTarget(self, action: #selector(getDirection), for: .touchUpInside)
        popUpView.favoriteButton.addTarget(self, action: #selector(pushFavoriteButton), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if locationDetail?.isFavorite == true {
            popUpView.favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            popUpView.favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        locationRepository.manageHistory(location: locationDetail!)
        informationArray.removeAll()
    }
    
    @objc
    func pushFavoriteButton() {
        do {
            let isFavorite = try locationRepository.manageFavorite(location: locationDetail!)
            if isFavorite == true {
                popUpView.favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                Analytics.logEvent("isFavorite", parameters: ["value": locationDetail?.title as Any])
            } else {
                popUpView.favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
                delegate?.didDeleteAFavorite(happened: true)
                Analytics.logEvent("isNotFavorite", parameters: ["value": locationDetail?.title as Any])
            }
        } catch {
            let errorDescription = (error as? LocalizedError)?.errorDescription ?? "Impossible d'enregistrer votre favoris."
            presentAlert(errorDescription)
        }
    }
    
    @objc
    func closeButton() {
        locationRepository.manageHistory(location: locationDetail!)
        informationArray.removeAll()
        dismiss(animated: true)
    }
    
    @objc
    func getDirection() {
        guard let url = homepage.first else {
            presentAlert("Pas de lien disponible")
            return
        }
        guard url != "" else {
            presentAlert("Pas de lien disponible")
            return
        }
        UIApplication.shared.open(URL(string: url)!, completionHandler: nil)
    }
    
    // MARK: - Configure function
    func configure(_ information: Location) {
        popUpView.title.text = popUpView.titleDictionnary[information.tag]
        let streetAddress = information.streetAddress
        let locality = information.locality
        let postalCode = information.postalCode
        
        informationArray.append(information.title)
        informationArray.append(information.additionalSchedule)
        informationArray.append("\(streetAddress),\n\(locality), \(postalCode)")
        informationArray.append(information.price)
        informationArray.append(information.openingHours)
        informationArray.append(information.phone)
        informationArray.append(information.email)
        informationArray.append(information.describe)
        
        popUpView.tableView.reloadData()
        homepage.append(information.homepage)
        guard information.image != "" else {
            self.popUpView.closedConstraint.isActive = true
            self.popUpView.openedConstraint.isActive = false
            return }
        self.popUpView.closedConstraint.isActive = false
        self.popUpView.openedConstraint.isActive = true
        let imageURL = (information.image)
        popUpView.image.load(url: URL(string: imageURL)!)
    }
}

// MARK: - TableView DataSource - Delegate
extension PopUpViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewTextLabel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = PopUpTableViewCell()
        
        cell.categoryText.text = tableViewTextLabel[indexPath.row]
        cell.informationText.text = informationArray[indexPath.row]
        
        
        let attributedString = NSMutableAttributedString.init(string: cell.categoryText.text!)
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSRange.init(location: 2, length: attributedString.length - 4))
        cell.categoryText.attributedText = attributedString
        
        if indexPath.row == 6 {
            let emailText = cell.informationText.text ?? ""
            let attributedString = NSMutableAttributedString(string: emailText)

            attributedString.addAttributes([
                .foregroundColor: UIColor.systemBlue,
                .underlineStyle: NSUnderlineStyle.single.rawValue
            ], range: NSRange(location: 0, length: attributedString.length))

            cell.informationText.attributedText = attributedString
        }
        
        return cell
    }
}
