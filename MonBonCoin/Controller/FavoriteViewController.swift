//
//  FavoriteViewController.swift
//  MonBonCoin
//
//  Created by Nicolas Schena on 14/08/2023.
//

import UIKit
import CoreData

// MARK: - Filter enumeration
enum FilterType {
    case tag
    case postalCode
    
    func departmentCodeAndName(for codes: [String]) -> [String] {
        let listOfDepartment = Department().listOfDepartment
        
        let departments = codes.compactMap { code -> String? in
            guard let name = listOfDepartment[code] else {
                return nil
            }
            return "\(code) - \(name)"
        }
        
        return departments
    }
    
    func switchTag(for location: [Location]) -> [String] {
        switch self {
        case .tag:
            let selectedCategory = Array(Set(location.map { $0.tag })).sorted()
            return selectedCategory
            
        case .postalCode:
            let selectedCategory = Array(Set(location.map { String($0.postalCode.prefix(2) )})).sorted()
            return selectedCategory
        }
    }
    
    func subFilter(for location: [Location], at index: Int, to compare: [String]) -> [Location] {
        switch self {
        case .tag:
            let result = location.filter { $0.tag == compare[index]}
            return result
            
        case .postalCode:
            let result = location.filter { $0.postalCode.prefix(2) == compare[index]}
            return result
            
        }
    }
}

// MARK: - FavoriteViewController
class FavoriteViewController: UIViewController {
    private let favoriteView = FavoriteView()
    private let popUpController = PopUpViewController()
    
    private var selectedCategory: [String] = []
    private var favoriteArray: [Location] = []
    private var selectedFilter: FilterType = .tag
    private var locationRepository: LocationRepository = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let locationRepository = LocationRepository(coreDataStack: appDelegate.coreDataStack)
        return locationRepository
    }()
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view = favoriteView
        favoriteView.tableView.dataSource = self
        favoriteView.tableView.delegate = self
        
        favoriteView.segmentedControl.addTarget(self, action: #selector(switchFilter), for: .valueChanged)
    }
    
    // MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorite()
        selectedCategory = selectedFilter.switchTag(for: favoriteArray)
        favoriteView.tableView.reloadData()
    }
    
    // MARK: - Function / objc function
    private func getFavorite() {
        do {
            favoriteArray = try locationRepository.getFavorite()
        } catch {
            let errorDescription = (error as? LocalizedError)?.errorDescription ?? "Impossible de charger les données."
            presentAlert(errorDescription)
        }
    }
    
    @objc
    func switchFilter() {
        switch favoriteView.segmentedControl.selectedSegmentIndex
        {
        case 0:
            selectedFilter = .tag
            selectedCategory = selectedFilter.switchTag(for: favoriteArray)
        case 1:
            selectedFilter = .postalCode
            selectedCategory = selectedFilter.switchTag(for: favoriteArray)
        default:
            break
        }
        favoriteView.tableView.reloadData()
    }
}

// MARK: - TableView DataSource - Delegate
extension FavoriteViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if favoriteArray.isEmpty == true {
            return 0
        } else {
            return selectedCategory.count
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = .tableViewColor
        let sectionLabel = UILabel(frame: CGRect(x: 20, y: -10, width:
                                                    tableView.frame.width, height: 50))
        sectionLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        sectionLabel.textColor = UIColor.black
        
        if favoriteArray.isEmpty == true {
            sectionLabel.text = ""
        } else {
            if selectedFilter == .postalCode {
                let department = selectedFilter.departmentCodeAndName(for: selectedCategory).sorted()
                sectionLabel.text = department[section]
            } else {
                sectionLabel.text = selectedCategory[section]
            }
        }
        header.addSubview(sectionLabel)
        return header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let locations = selectedFilter.subFilter(for: favoriteArray, at: section, to: selectedCategory)
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = CustomTableViewCell()
        let locations = selectedFilter.subFilter(for: favoriteArray, at: indexPath.section, to: selectedCategory)
        let list = locations[indexPath.row]
        
        let attributedString = NSMutableAttributedString.init(string: (list.title))
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSRange.init(location: 0, length: attributedString.length))
        cell.textLabel?.attributedText = attributedString
        
        if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            cell.textLabel?.text = list.title
            cell.detailTextLabel?.text = list.locality
        } else {
            cell.textLabel?.text = list.title
            cell.detailTextLabel?.text = list.locality
            cell.bottomBlackBorder.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let locations = selectedFilter.subFilter(for: favoriteArray, at: indexPath.section, to: selectedCategory)
        let eventInformation = locations[indexPath.row]
        popUpController.configure(eventInformation)
        popUpController.locationDetail = eventInformation
        popUpController.delegate = self
        present(popUpController, animated: true)
    }
}

// MARK: - Delegate
extension FavoriteViewController: PopUpViewControllerDelegate {
    func didDeleteAFavorite(happened: Bool) {
        if happened == true {
            getFavorite()
            selectedCategory = selectedFilter.switchTag(for: favoriteArray)
            favoriteView.tableView.reloadData()
        }
    }
}
