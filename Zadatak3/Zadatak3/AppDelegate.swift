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
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let controller = ViewController()
        let navVC = UINavigationController(rootViewController: controller)
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
        return true
    }


}
