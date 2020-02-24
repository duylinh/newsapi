//
//  Constants.swift
//  News
//
//  Created by Duy Linh Tran on 2/23/20.
//  Copyright © 2020 Duy Linh Tran. All rights reserved.
//

import UIKit

// swiftlint:disable all


let statusBarStyle: UIStatusBarStyle = .default
let defaultBackgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.937254902, alpha: 1)
let navTextColor = #colorLiteral(red: 0.05490196078, green: 0.1333333333, blue: 0.2392156863, alpha: 1)

enum Screen {
    static let Width = UIScreen.main.bounds.size.width
    static let Height = UIScreen.main.bounds.size.height
    static let Bounds = UIScreen.main.bounds
    static let Center = CGPoint(x: UIScreen.main.bounds.size.width*0.5, y: UIScreen.main.bounds.size.height*0.5)
    static let MAX_LENGTH    = max(Screen.Width, Screen.Height)
    static let MIN_LENGTH    = min(Screen.Width, Screen.Height)
}
