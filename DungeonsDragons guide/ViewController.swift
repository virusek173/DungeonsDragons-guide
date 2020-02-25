//
//  ViewController.swift
//  DungeonsDragons guide
//
//  Created by Jacek Graczyk on 12/02/2020.
//  Copyright © 2020 Jacek Graczyk. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var elements = [ListElement]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let baseApi: String = "https://www.dnd5eapi.co/api/"
        let endpointUrlList: [String] = ["monsters", "races", "spells", "equipment"]
        let tabBarTag: Int = navigationController?.tabBarItem.tag ?? 0
        let api: String = baseApi + endpointUrlList[tabBarTag]

        if let url = URL(string: api) {
            if let data = try? Data(contentsOf: url) {
                parse(data: data)
                return
            }
        }

        showError()
    }
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let element = elements[indexPath.row]
        cell.textLabel?.text = element.name
        
        return cell
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
}

