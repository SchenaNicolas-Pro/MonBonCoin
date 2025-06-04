//
//  HistoryViewController.swift
//  MonBonCoin
//
//  Created by Nicolas Schena on 14/08/2023.
//

import UIKit
import CoreData

class HistoryViewController: UIViewController {
    private let historyView = HistoryView()
    private let popUpController = PopUpViewController()
    
    private var historyArray: [HistoryRecord] = []
    private var locationRepository: LocationRepository = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let locationRepository = LocationRepository(coreDataStack: appDelegate.coreDataStack)
        return locationRepository
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = historyView
        historyView.tableView.dataSource = self
        historyView.tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getHistory()
        historyView.tableView.reloadData()
    }
    
    private func getHistory() {
        do {
            historyArray = try locationRepository.getHistory()
        } catch {
            let errorDescription = (error as? LocalizedError)?.errorDescription ?? "Impossible de charger les données."
            presentAlert(errorDescription)
        }
    }
}

// MARK: - TableView DataSource
extension HistoryViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = CustomTableViewCell()
        
        let list = historyArray[indexPath.row]
        
        cell.textLabel?.text = list.location?.title
        cell.detailTextLabel?.text = list.location?.locality
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let eventInformation = historyArray[indexPath.row].location else { return }
        popUpController.configure(eventInformation)
        popUpController.locationDetail = eventInformation
        present(popUpController, animated: true)
    }
}
