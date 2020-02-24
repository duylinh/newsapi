//
//  NSPersistentStoreDescription+Ex.swift
//  News
//
//  Created by Duy Linh Tran on 2/24/20.
//  Copyright © 2020 Duy Linh Tran. All rights reserved.
//

import CoreData
// swiftlint:disable all

extension NSPersistentStoreDescription {
    
    static func createSQLiteStore(model: String, oldVersionName: String, blank: Bool = false) -> NSPersistentStoreDescription? {
        let storeURL = URL.applicationDocumentsDirectory()

        if blank {
            try? FileManager.default.removeItem(at: storeURL)
        }
        
        let description = NSPersistentStoreDescription(url: storeURL)
        description.type = NSSQLiteStoreType
        
        return description
    }
}
