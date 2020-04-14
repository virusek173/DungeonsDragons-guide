//
//  DetailsViewController.swift
//  DungeonsDragons guide
//
//  Created by Jacek Graczyk on 25/03/2020.
//  Copyright © 2020 Jacek Graczyk. All rights reserved.
//

import UIKit
import Keys

class DetailsViewController: UIViewController {
    var details: ListElement?
    var baseUrl: String?
    var imageUrl: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let title = details?.name
        self.navigationItem.title = title
        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    func fetchImage(additional: String = "") {
        if imageUrl != nil { return }

        let keys = DungeonsDragonsKeys()
        let googleApiKey = keys.googleApiKey
        var imageName = details?.index ?? "logo"
        imageName += additional
        let googleCustomSearchUrl = "https://www.googleapis.com/customsearch/v1?q=\(imageName)-dungeons-and-dragons&key=\(googleApiKey)&cx=017663620470495640824%3A3gyica0r5wy&lr=lang_en&num=1&searchType=image&start=0&imgSize=xlarge"

        if let url = URL(string: googleCustomSearchUrl) {
            if let data = try? Data(contentsOf: url) {
                imageParse(json: data)
            }
        }
    }
    
    func imageParse(json: Data) {
        let decoder = JSONDecoder()
        if let jsonImage = try? decoder.decode(GoogleImage.self, from: json) {
            imageUrl = jsonImage.items[0].link
        }
    }
}
