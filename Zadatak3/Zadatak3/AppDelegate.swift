//
//  AppDelegate.swift
//  Zadatak3
//
//  Created by akademija on 18.03.2026..
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        try? DatabaseManager.shared.setup()
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let rootVC: UIViewController
        if AuthManager.shared.isLoggedIn {
            rootVC = ViewController()
        } else {
            rootVC = LoginVC()
        }
        
        let navController = UINavigationController(rootViewController: rootVC)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        
        return true
    }
}
