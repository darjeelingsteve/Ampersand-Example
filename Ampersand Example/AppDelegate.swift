//
//  AppDelegate.swift
//  Ampersand Example
//
//  Created by Stephen Anthony on 18/10/2019.
//  Copyright © 2019 Darjeeling Apps. All rights reserved.
//

import UIKit
import Ampersand

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Register 'Avenir' as the application font.
        let configurationURL = Bundle.main.url(forResource: "Avenir", withExtension: "json")!
        UIFont.registerApplicationFont(withConfigurationAt: configurationURL)
        
        return true
    }
}
