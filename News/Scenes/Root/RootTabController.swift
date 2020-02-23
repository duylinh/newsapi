//
//  RootTabController.swift
//  News
//
//  Created by Duy Linh Tran on 2/23/20.
//  Copyright © 2020 Duy Linh Tran. All rights reserved.
//

import UIKit
// swiftlint:disable all
class RootTabController: UITabBarController {
    
    internal static func instantiate() -> RootTabController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RootTabController") as! RootTabController
    }
    
    // MARK: - Vars
    
    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    // MARK: - Configure
    fileprivate func configure() {
        self.delegate = self
        
    }
}

// MARK: - UITabBarControllerDelegate
extension RootTabController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {}
}

// MARK: - UIStatusBarStyle / preferredStatusBarStyle
extension RootTabController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return children.first { $0.childForStatusBarStyle != nil }?.childForStatusBarStyle?.preferredStatusBarStyle ?? .default
    }
}
