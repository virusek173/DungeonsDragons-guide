//
//  ViewController.swift
//  DungeonsDragons guide
//
//  Created by Jacek Graczyk on 12/02/2020.
//  Copyright © 2020 Jacek Graczyk. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
    var elements: [ListElement] = []
    var filteredElements: [ListElement] = []
    var baseUrl: String = "https://www.dnd5eapi.co"
    var searchController = UISearchController(searchResultsController: nil)
    var titleList: [String] = ["List of monsters", "List of races", "List of spells", "List of equipments"]
    let listTypeNames: [String] = ["monsters", "races", "spells", "equipment"]
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabBarTag: Int = navigationController?.tabBarItem.tag ?? 0
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search \(listTypeNames[tabBarTag])"
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = true
        self.navigationItem.title = titleList[tabBarTag]
        
        let baseApi: String = baseUrl + "/api/"
        let api: String = baseApi + listTypeNames[tabBarTag]

        if let url = URL(string: api) {
            if let data = try? Data(contentsOf: url) {
                parse(data: data)
                return
            }
        }

        showError()
    }
            
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfElements: Int = isFiltering ? self.filteredElements.count : self.elements.count
        
        return numberOfElements
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let element: ListElement = isFiltering ? self.filteredElements[indexPath.row] : self.elements[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = element.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vcArray = [MonsterViewController(), RaceViewController(), SpellViewController(), EquipmentViewController()]
        let tabBarTag: Int = navigationController?.tabBarItem.tag ?? 0
        
        if (vcArray.indices.contains(tabBarTag)) {
            let vc = vcArray[tabBarTag]
            vc.details = isFiltering ? self.filteredElements[indexPath.row] : self.elements[indexPath.row]
            vc.baseUrl = baseUrl
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func parse(data: Data) {
        let decoder = JSONDecoder()
        
        if let jsonElements = try? decoder.decode(ListElements.self, from: data) {
            elements = jsonElements.results
            tableView.reloadData()
        }
    }
    
    func showError() {
        let title = "Error with fetching data"
        let message = "Check your internet connection."
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        ac.addAction(action)
        present(ac, animated: true)
    }
    
    func filterContentForSearchText(_ searchText: String) {
        
        self.filteredElements = elements.filter { (element: ListElement) -> Bool in
            return element.name.lowercased().contains(searchText.lowercased())
        }
      
        tableView.reloadData()
    }
}

extension MasterViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    filterContentForSearchText(searchBar.text!)
  }
}
