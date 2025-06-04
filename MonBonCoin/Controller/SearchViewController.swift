//
//  SearchViewController.swift
//  MonBonCoin
//
//  Created by Nicolas Schena on 09/08/2023.
//

import UIKit
import CoreData
import Firebase

class SearchViewController: UIViewController {
    //MARK: - Properties
    private let tapGesture = UITapGestureRecognizer()
    private let searchView = SearchView()
    private let departmentController = DepartmentViewController()
    private let popUpController = PopUpViewController()
    private let searchService = SearchService()
    
    private var departmentKey = ""
    /// Used to add tag to Data and APICall
    private var selectedTag = [String]()
    /// Used to give name for header
    private var selectedCategory = [String]()
    private var informationArray: [Location] = []
    private var locationRepository: LocationRepository = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let locationRepository = LocationRepository(coreDataStack: appDelegate.coreDataStack)
        return locationRepository
    }()
    
    private lazy var sideMenuButtons: [SideMenuButton] = {
        return [searchView.menuView.allSiteButton,
                searchView.menuView.restaurationButton,
                searchView.menuView.culturalSiteButton,
                searchView.menuView.sportSiteButton,
                searchView.menuView.walkBikeSiteButton,
                searchView.menuView.eventSiteButton]
    }()
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view = searchView
        view.addGestureRecognizer(tapGesture)
        tapGesture.isEnabled = false
        searchView.tableView.dataSource = self
        searchView.tableView.delegate = self
        searchView.tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        configureSideMenuButtons()
        
        tapGesture.addTarget(self, action: #selector(closeTypeMenu))
        searchView.typeButton.addTarget(self, action: #selector(typeButtonTapIn), for: .touchUpInside)
        searchView.departmentButton.addTarget(self, action: #selector(departmentButtonTapIn), for: .touchUpInside)
        searchView.shuffleButton.addTarget(self, action: #selector(shuffleButtonTapIn), for: .touchUpInside)
        searchView.searchButton.addTarget(self, action: #selector(goButtonTapIn), for: .touchUpInside)
    }
    
    // MARK: - Function
    private func configureSideMenuButtons() {
        for button in sideMenuButtons {
            button.addTarget(self, action: #selector(selectedCategory(_:)), for: .touchUpInside)
        }
    }
    
    private func toggleButtonState(_ btn: SideMenuButton) {
        let newState = (btn.image.image == UIImage(systemName: "square.split.diagonal.2x2")) ? UIImage(systemName: "square") : UIImage(systemName: "square.split.diagonal.2x2")
        btn.image.image = newState
    }
    
    private func updateSelectedEventTags() {
        selectedTag.removeAll()
        selectedCategory.removeAll()
        
        for btn in sideMenuButtons {
            if btn != searchView.menuView.allSiteButton,
               btn.image.image == UIImage(systemName: "square.split.diagonal.2x2"),
               let eventTag = btn.categoryTag.text,
               let eventCategory = btn.textLabel.text {
                selectedTag.append(eventTag)
                selectedCategory.append(eventCategory)
            }
        }
    }
    
    private func preventError() -> Bool {
        updateSelectedEventTags()
        guard selectedTag.isEmpty == false else {
            self.informationArray.removeAll()
            self.searchView.tableView.reloadData()
            presentAlert("Pas de catégorie choisi, veuillez en sélectionner une")
            return true
        }
        guard departmentKey.isEmpty == false else {
            presentAlert("Pas de département choisi, veuillez en sélectionner un")
            return true
        }
        return false
    }
    
    private func APICall() async {
        let allCategory = sideMenuButtons.compactMap{ $0.categoryTag.text }
        
        for category in allCategory {
            let url = URLBuilder.department(category: category).url(departmentNumber: departmentKey)
            do {
                let information = try await searchService.getInformation(url: url, tag: category)
                guard !information.isEmpty else { return }
                try await locationRepository.saveLocation(with: information)
            } catch {
                let errorDescription = (error as? LocalizedError)?.errorDescription ?? "Ce département n’est pas encore disponible. Les données sont en cours d’intégration."
                presentAlert(errorDescription)
            }
        }
    }
    
    private func analyticsCategory() {
        for category in selectedTag {
            Analytics.logEvent("Category", parameters: ["value": category])
        }
    }
    
    // MARK: - objc Function
    @objc
    func closeTypeMenu(_ sender: UITapGestureRecognizer) {
        let tapLocation = sender.location(in: searchView.menuView)
        if  !searchView.menuView.bounds.contains(tapLocation){
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0) {
                self.searchView.openedConstraint.isActive = false
                self.searchView.closedConstraint.isActive = true
                self.view.layoutIfNeeded()
            }
        }
        searchView.shuffleButton.isEnabled = true
        searchView.searchButton.isEnabled = true
        tapGesture.isEnabled = false
    }
    
    @objc
    func selectedCategory(_ button: SideMenuButton) {
        if button == searchView.menuView.allSiteButton {
            toggleButtonState(searchView.menuView.allSiteButton)
            for btn in sideMenuButtons {
                btn.image.image = searchView.menuView.allSiteButton.image.image
            }
        } else {
            toggleButtonState(button)
        }
    }
    
    @objc
    func typeButtonTapIn() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0) {
            self.searchView.closedConstraint.isActive = false
            self.searchView.openedConstraint.isActive = true
            self.view.layoutIfNeeded()
        }
        searchView.shuffleButton.isEnabled = false
        searchView.searchButton.isEnabled = false
        tapGesture.isEnabled = true
    }
    
    @objc
    func goButtonTapIn() {
        if preventError() == true { return }
        
        Task {
            let data = try self.locationRepository.getLocation(forDepartment: departmentKey, withCategory: selectedTag)
            
            if data.isEmpty == true {
                await APICall()
                let newData = try self.locationRepository.getLocation(forDepartment: self.departmentKey, withCategory: self.selectedTag)
                self.informationArray = newData
                self.searchView.tableView.reloadData()
                analyticsCategory()
            } else {
                self.informationArray = data
                self.searchView.tableView.reloadData()
                analyticsCategory()
            }
        }
    }
    
    @objc
    func departmentButtonTapIn() {
        departmentController.delegate = self
        present(departmentController, animated: true)
    }
    
    @objc
    func shuffleButtonTapIn() {
        guard informationArray.isEmpty == false else {
            presentAlert("Aucune donnée chargées")
            return
        }
        Analytics.logEvent("press_shuffle", parameters: nil)
        let randomEvent = informationArray.randomElement()
        popUpController.configure(randomEvent!)
        popUpController.locationDetail = randomEvent!
        present(popUpController, animated: true)
    }
}

// MARK: - TableView DataSource - Delegate
extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if informationArray.isEmpty == true {
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
        
        if informationArray.isEmpty == true {
            sectionLabel.text = ""
        } else {
            sectionLabel.text = selectedCategory[section]
        }
        header.addSubview(sectionLabel)
        return header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let locations = informationArray.filter { $0.tag == selectedTag[section]}
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else {
            return UITableViewCell()
        }
                
                
        let locations = informationArray.filter { $0.tag == selectedTag[indexPath.section]}
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
        let locations = informationArray.filter { $0.tag == selectedTag[indexPath.section]}
        let eventInformation = locations[indexPath.row]
        popUpController.configure(eventInformation)
        popUpController.locationDetail = eventInformation
        present(popUpController, animated: true)
    }
}

// MARK: - Department delegate
extension SearchViewController: DepartmentViewControllerDelegate {
    func didSelectDepartment(selection: String, key: String) {
        searchView.locationLabel.text = selection
        departmentKey = key
    }
}

// MARK: - First launch delegate
extension SearchViewController: FirstLaunchViewControllerDelegate {
    func configureSearchView() {
        let allCategory = sideMenuButtons.compactMap{ $0.categoryTag.text }
        selectedCategory = allCategory
        selectedTag = allCategory
        
        for btn in sideMenuButtons {
            btn.image.image = UIImage(systemName: "square.split.diagonal.2x2")
        }
        
        Task {
            let data = try self.locationRepository.getLocation(forDepartment: departmentKey, withCategory: allCategory)
            self.informationArray = data
            self.searchView.tableView.reloadData()
        }
    }
}
