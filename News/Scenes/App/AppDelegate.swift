//
//  AppDelegate.swift
//  News
//
//  Created by Duy Linh Tran on 2/23/20.
//  Copyright © 2020 Duy Linh Tran. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Vars
    var window: UIWindow?
    
    // MARK: - App lifecycle
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
//        APIService.shared.getEverything(with: "bitcoin") { (results) in
//            print(results)
//        }
        self.window?.isHidden = true
        let rootController = RootTabController.instantiate()
        self.setRootController(rootController, animated: true)
        self.window?.isHidden = false
        return true
    }

    // MARK: - fileprivate
    fileprivate func setRootController(_ controller: UIViewController, animated: Bool = true) {
        guard animated else {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = controller
            self.window?.makeKeyAndVisible()
            return
        }
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = controller
        window?.makeKeyAndVisible()
        guard let window = self.window else { return }
        UIView.transition(with: window,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
    }
}
