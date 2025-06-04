//
//  FirstLaunchViewController.swift
//  MonBonCoin
//
//  Created by Nicolas Schena on 30/10/2023.
//

import UIKit

protocol FirstLaunchViewControllerDelegate: AnyObject {
    func configureSearchView()
}

class FirstLaunchViewController: UIViewController {
    let firstLaunchView = FirstLaunchView()
    let departmentViewController = DepartmentViewController()
    let searchService = SearchService()
    let category = ["Restauration" ,"Cultural", "Sport", "Ride", "Event"]
    
    weak var delegate: FirstLaunchViewControllerDelegate?
    private var departmentKey = ""
    private var locationRepository: LocationRepository = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let locationRepository = LocationRepository(coreDataStack: appDelegate.coreDataStack)
        return locationRepository
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = firstLaunchView
        firstLaunchView.tableView.dataSource = self
        firstLaunchView.tableView.delegate = self
        
        firstLaunchView.nextButton.addTarget(self, action: #selector(closeButton), for: .touchUpInside)
    }
    
    @objc
    func closeButton() {
        Task {
            await APICall()
            delegate?.configureSearchView()
            dismiss(animated: true)
        }
    }
    
    private func APICall() async {
        for category in category {
            let url = URLBuilder.department(category: category).url(departmentNumber: departmentKey)
            do {
                let information = try await searchService.getInformation(url: url, tag: category)
                guard !information.isEmpty else { return }
                try await locationRepository.saveLocation(with: information)
            } catch {
                let errorDescription = (error as? LocalizedError)?.errorDescription ?? "Il y a une erreur avec la base de Donnée."
                presentAlert(errorDescription)
            }
        }
    }
}

extension FirstLaunchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return departmentViewController.listOfDepartment.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CustomTableViewCell()
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = .backgroundColor
        cell.selectedBackgroundView = selectedBackgroundView

        let (code, name) = departmentViewController.listOfDepartment[indexPath.row]
        cell.textLabel?.text = "\(code) - \(name)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let (code, name) = departmentViewController.listOfDepartment[indexPath.row]
        let chosenDepartment = "\(code) - \(name)"
        departmentKey = code
        departmentViewController.delegate?.didSelectDepartment(selection: chosenDepartment, key: code)
        firstLaunchView.nextButton.isEnabled = true
        firstLaunchView.nextButton.backgroundColor = .tableViewColor
        firstLaunchView.nextButton.setTitleColor(.black, for: .normal)
    }
}
