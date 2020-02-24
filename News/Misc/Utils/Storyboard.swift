//
//  Storyboard.swift
//  News
//
//  Created by Duy Linh Tran on 2/23/20.
//  Copyright © 2020 Duy Linh Tran. All rights reserved.
//

import UIKit
// swiftlint:disable all

public enum Storyboard: String {
    case LaunchScreen
    case Main
    case Headline
    case News
    case Profile
    case Article
    
    public func instantiate<VC: UIViewController>(type: VC.Type) -> VC {
        var storyboardId = ""
        
        let components = "\(type)".components(separatedBy: ".")
        
        if !components.isEmpty {
            storyboardId = components[0]
        }
        
        let storyboad = UIStoryboard(name: self.rawValue, bundle: nil)
        
        guard let controller = storyboad.instantiateViewController(withIdentifier: storyboardId) as? VC
            else { fatalError("Couldn't instantiate \(storyboardId) from \(self.rawValue)") }
        
        return controller
    }
}
