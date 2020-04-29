//
//  DetailsViewController.swift
//  DungeonsDragons guide
//
//  Created by Jacek Graczyk on 25/03/2020.
//  Copyright © 2020 Jacek Graczyk. All rights reserved.
//

import UIKit
import Keys
import WebKit

class DetailsViewController: UIViewController {
    var details: ListElement?
    var baseUrl: String?
    var imageUrl: String?
    var webView: WKWebView!
    var htmlFontColor = "#000"
    
    override func loadView() {
        super.loadView()
        
        webView = WKWebView()
        webView.scrollView.delegate = self
        webView.isOpaque = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let title = details?.name
        let interfaceStyle = traitCollection.userInterfaceStyle
        let blackColor = UIColor(red: 0, green: 0, blue: 0, alpha:1)
        let whiteColor = UIColor(red: 255, green: 255, blue: 255, alpha:1)
        let webkitBackgroundColor = interfaceStyle == .dark ? blackColor : whiteColor
        
        self.navigationItem.title = title
        self.navigationItem.largeTitleDisplayMode = .never
        self.htmlFontColor = interfaceStyle == .dark ? "#fff" : htmlFontColor
        webView.backgroundColor = webkitBackgroundColor
        
        view = webView
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

extension DetailsViewController: UIScrollViewDelegate {
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        scrollView.pinchGestureRecognizer?.isEnabled = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.maximumZoomScale = 1.0
        scrollView.minimumZoomScale = 1.0
    }
}
