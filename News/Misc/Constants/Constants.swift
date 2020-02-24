//
//  Constants.swift
//  News
//
//  Created by Duy Linh Tran on 2/23/20.
//  Copyright © 2020 Duy Linh Tran. All rights reserved.
//

import UIKit

// swiftlint:disable all

enum Screen {
    static let Width = UIScreen.main.bounds.size.width
    static let Height = UIScreen.main.bounds.size.height
    static let Bounds = UIScreen.main.bounds
    static let Center = CGPoint(x: UIScreen.main.bounds.size.width*0.5, y: UIScreen.main.bounds.size.height*0.5)
    static let MAX_LENGTH    = max(Screen.Width, Screen.Height)
    static let MIN_LENGTH    = min(Screen.Width, Screen.Height)
}


struct Constants {
    struct KeySearch {
        static let bitcoin = "bitcoin"
        static let apple = "apple"
        static let earthquake = "earthquake"
        static let animal = "animal"
    }
    
    struct CoreData {
        static let SQLiteStoreName = "News.sqlite"
        static let isInitial = "News.CoreData.isInitial"
    }
}
