//
//  CustomNavigationController.swift
//  DungeonsDragons guide
//
//  Created by Jacek Graczyk on 02/05/2020.
//  Copyright © 2020 Jacek Graczyk. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let displaySplashScreen = !SplashScreenViewController.splashScreenWasLaunched
        let controllerNameToGo = displaySplashScreen ? "SplashScreen" : "MasterView"
        
        self.goToView(controller: controllerNameToGo)
    }
    
    func goToView(controller: String = "MasterView") {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: controller) {
            self.setViewControllers([vc], animated: false)
        }
    }
}
