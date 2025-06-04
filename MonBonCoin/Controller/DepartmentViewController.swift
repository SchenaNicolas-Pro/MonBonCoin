//
//  DepartmentViewController.swift
//  MonBonCoin
//
//  Created by Nicolas Schena on 30/10/2023.
//

import UIKit
import Firebase

protocol DepartmentViewControllerDelegate: AnyObject {
    func didSelectDepartment(selection: String, key: String)
}

class DepartmentViewController: UIViewController {
    let departmentView = DepartmentView()
    let listOfDepartment = Department().listOfDepartment.sorted { $0.0 < $1.0}
    weak var delegate: DepartmentViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view = departmentView
        departmentView.tableView.dataSource = self
        departmentView.tableView.delegate = self
        
        departmentView.returnButton.addTarget(self, action: #selector(closeButton), for: .touchUpInside)
    }

    @objc
    func closeButton() {
        dismiss(animated: true)
    }
}

extension DepartmentViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfDepartment.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CustomTableViewCell()
        let (code, name) = listOfDepartment[indexPath.row]
        cell.textLabel?.text = "\(code) - \(name)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let (code, name) = listOfDepartment[indexPath.row]
        let chosenDepartment = "\(code) - \(name)"
        Analytics.logEvent("Department", parameters: ["value": chosenDepartment])
        delegate?.didSelectDepartment(selection: chosenDepartment, key: code)
        dismiss(animated: true)
    }
}
