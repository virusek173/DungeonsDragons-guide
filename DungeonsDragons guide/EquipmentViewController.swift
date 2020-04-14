//
//  EquipmentViewController.swift
//  DungeonsDragons guide
//
//  Created by Jacek Graczyk on 26/03/2020.
//  Copyright © 2020 Jacek Graczyk. All rights reserved.
//

import UIKit
import WebKit

class EquipmentViewController: DetailsViewController {
    var equipment: Equipment?
    var webView: WKWebView!

    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchEquipment()
    }
    
    func updateEquipment() {
        guard let equipment = equipment else { return }
        
        let name = equipment.name
        let equipmentCategory = equipment.equipment_category
        let description = equipment.desc?.first ?? "-"
        let weight = equipment.weight ?? 0
        let defaultImageLink = "https://files.rebel.pl/images/wydawnictwo/zapowiedzi/DnD/DnD_Bug_1c_Red_V1_XL_RGB.png"
        let imageLink = imageUrl ?? defaultImageLink
        let imageStyle = "display: block; margin-left: auto; margin-right: auto; width: 350px; height: 350px;"

        let html = """
        <html>
            <head>
                <meta name="viewport" content="width=device-width, initial-scale=1">
                <style> body { font-size: 120%; } </style>
            </head>
            <body>
                 <img src="\(imageLink)" alt="\(name)" style="\(imageStyle)">
                 <b>Name:</b> \(name) <br />
                 <b>Category:</b> \(equipmentCategory) <br />
                 <b>Description:</b> \(description) <br />
                 <b>Weight: </b> \(weight)<br />
            </body>
        </html>
        """

        webView.loadHTMLString(html, baseURL: nil)
    }
    
    func fetchEquipment() {
        super.fetchImage()
        
        if let baseUrl = baseUrl {
               if let urlString = details?.url {
                   if let url = URL(string: baseUrl + urlString) {
                       if let data = try? Data(contentsOf: url) {
                           parse(json: data)
                       }
                   }
               }
           }
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()

        if let jsonEquipment = try? decoder.decode(Equipment.self, from: json) {
            equipment = jsonEquipment
            
            updateEquipment()
        }
    }
}
