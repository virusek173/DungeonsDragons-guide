//
//  SpellViewController.swift
//  DungeonsDragons guide
//
//  Created by Jacek Graczyk on 15/03/2020.
//  Copyright © 2020 Jacek Graczyk. All rights reserved.
//

import UIKit
import WebKit

class SpellViewController: DetailsViewController {
    var spell: Spell?
    var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchSpell()
    }
    
    func updateSpell() {
        guard let spell = spell else { return }
        
//        TODO
        let name = spell.name
        let desc = spell.desc.first ?? "No description"
        let range = spell.range
        let duration = spell.duration
        let level = spell.level
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
                 <b>Description:</b> \(desc) <br />
                 <b>Range:</b> \(range) <br />
                 <b>Duration:</b> \(duration) <br />
                 <b>level: </b> \(level) <br />
            </body>
        </html>
        """

        webView.loadHTMLString(html, baseURL: nil)
    }
    
    func fetchSpell() {
        super.fetchImage(additional: "-spell")
        
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

        if let jsonRace = try? decoder.decode(Spell.self, from: json) {
            spell = jsonRace
            
            updateSpell()
        }
    }
}
