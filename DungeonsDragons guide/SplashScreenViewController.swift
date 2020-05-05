//
//  SplashScreenViewController.swift
//  DungeonsDragons guide
//
//  Created by Jacek Graczyk on 30/04/2020.
//  Copyright © 2020 Jacek Graczyk. All rights reserved.
//

import UIKit
import Lottie

class SplashScreenViewController: UIViewController {
    static var shpashScreenWasLaunched: Bool = false

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.hideNavElements(hide: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setToolbarHidden(true, animated: false)
        SplashScreenViewController.shpashScreenWasLaunched = true

        let animationView = AnimationView()
        if let animation = Animation.named("dice-animation") {
            animationView.animation = animation
            animationView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
            animationView.center = self.view.center
            animationView.contentMode = .scaleAspectFill
            view.addSubview(animationView)

            animationView.play { (finished) in
                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "MasterView") as? MasterViewController {
                    self.hideNavElements(hide: false)
                    self.navigationController?.setViewControllers([vc], animated: false)
                }
            }
        }
    }
    
    func hideNavElements(hide: Bool) {
        self.navigationController?.setNavigationBarHidden(hide, animated: false)
        self.tabBarController?.tabBar.isHidden = hide
    }
}
