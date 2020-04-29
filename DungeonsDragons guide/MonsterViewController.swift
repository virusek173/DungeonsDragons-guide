//
//  MonsterViewController.swift
//  DungeonsDragons guide
//
//  Created by Jacek Graczyk on 15/03/2020.
//  Copyright © 2020 Jacek Graczyk. All rights reserved.
//

import UIKit

class MonsterViewController: DetailsViewController {
    var monster: Monster?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchMonster()
    }
    
    func updateMonster() {
        guard let monster = monster else { return }
        
        let name = monster.name
        let alignment = monster.alignment
        let languages = monster.languages
        let legendaryActionName = monster.legendary_actions?[0].name ?? "No action"
        let legendaryActionDesc = (monster.legendary_actions?[0].desc != nil) ? "<br />" + (monster.legendary_actions?[0].desc)!: ""
        let actionName = monster.actions?[0].name ?? "No action"
        let actionDesc = (monster.actions?[0].desc != nil) ? "<br />" + (monster.actions?[0].desc)!: ""
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
                 <b>Languages:</b> \(languages) <br />
                 <b>Legendary action: </b> \(legendaryActionName) \(legendaryActionDesc) <br />
                 <b>Action</b> \(actionName) \(actionDesc) <br />
            </body>
        </html>
        """

        self.webView.loadHTMLString(html, baseURL: nil)
    }
    
    func fetchMonster() {
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

        if let jsonMonster = try? decoder.decode(Monster.self, from: json) {
            monster = jsonMonster
            
            updateMonster()
        }
    }
}

//extension MonsterViewController: UIScrollViewDelegate {
//    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
//        scrollView.pinchGestureRecognizer?.isEnabled = false
//        scrollView.showsHorizontalScrollIndicator = false
//        scrollView.maximumZoomScale = 1.0
//        scrollView.minimumZoomScale = 1.0
//    }
//}
