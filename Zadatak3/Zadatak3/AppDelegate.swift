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
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let loginVC = LoginVC()
        let navVC = UINavigationController(rootViewController: loginVC)
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
        
        return true
    }
    
    private func getInitialViewController() -> UIViewController {
        if AuthManager.shared.isLoggedIn {
            return ViewController()
        } else {
            return LoginVC()
        }
    }
    
    func checkAuthAndSetRoot() {
        let rootVC = getInitialViewController()
        let navVC = UINavigationController(rootViewController: rootVC)
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
    }
}
