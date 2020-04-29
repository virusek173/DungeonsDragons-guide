//
//  RaceViewController.swift
//  DungeonsDragons guide
//
//  Created by Jacek Graczyk on 15/03/2020.
//  Copyright © 2020 Jacek Graczyk. All rights reserved.
//

import UIKit

class RaceViewController: DetailsViewController {
    var race: Race?

    override func viewDidLoad() {
        super.viewDidLoad()
                
        fetchRace()
    }
    
    func updateRace() {
        guard let race = race else { return }
        let name = race.name
        let alignment = race.alignment
        let speed = race.speed
        let age = race.age
        let sizeDescription = race.size_description
        let defaultImageLink = "https://files.rebel.pl/images/wydawnictwo/zapowiedzi/DnD/DnD_Bug_1c_Red_V1_XL_RGB.png"
       let imageLink = imageUrl ?? defaultImageLink
       let imageStyle = "display: block; margin-left: auto; margin-right: auto; width: 350px; height: 350px;"

        let html = """
        <html>
            <head>
                <meta name="viewport" content="width=device-width, initial-scale=1">
                <style> body { font-size: 120%; } </style>
            </head>
        <body style="color: \(self.htmlFontColor)">
                <img src="\(imageLink)" alt="\(name)" style="\(imageStyle)">
                 <b>Name:</b> \(name) <br />
                 <b>Alignment:</b> \(alignment) <br />
                 <b>Speed:</b> \(speed) <br />
                 <b>Age: </b> \(age) <br />
                 <b>Size description</b> \(sizeDescription) <br />
            </body>
        </html>
        """

        self.webView.loadHTMLString(html, baseURL: nil)
    }
    
    func fetchRace() {
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

        if let jsonRace = try? decoder.decode(Race.self, from: json) {
            race = jsonRace
            
            updateRace()
        }
    }
}
