//
//  AppDelegate.swift
//  News
//
//  Created by Duy Linh Tran on 2/23/20.
//  Copyright © 2020 Duy Linh Tran. All rights reserved.
//

import UIKit
import CoreData

// swiftlint:disable all

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Vars
    var window: UIWindow?
    var coreDataManager: CoreDataManager =  CoreDataManager.shared
    
    // MARK: - App lifecycle
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        guard ProcessInfo.processInfo.environment["runningTests"] == nil else {
            FileManager.clearApplicationSupportDirectoryContents()
            return true
        }
        
        coreDataManager.setup { (isInitial) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.window?.isHidden = true
                let rootController = RootTabController.instantiate()
                self.setRootController(rootController, animated: true)
                self.window?.isHidden = false
                
                if isInitial {
                    delay(0.01) {
                        self.coreDataManager.createKeyword(keyword: "bitcoin", isSelected: true) { (_) in }
                        self.coreDataManager.createKeyword(keyword: "apple", isSelected: true) { (_) in }
                        self.coreDataManager.createKeyword(keyword: "earthquake", isSelected: true) { (_) in }
                        self.coreDataManager.createKeyword(keyword: "animal", isSelected: true) { (_) in }
                    }
                }
            }
        }
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        
        try? CoreDataManager.shared.mainContext.save()
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
