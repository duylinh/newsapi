//
//  CoreDataMigrationVersion.swift
//  News
//
//  Created by Duy Linh Tran on 2/24/20.
//  Copyright © 2020 Duy Linh Tran. All rights reserved.
//

import Foundation
import CoreData

enum CoreDataMigrationVersion: String, CaseIterable {
    case version1 = "News"
    case version2 = "News 2"
//    case version3 = "News 3"
//    case version4 = "News 4"
    
    // MARK: - Current
    
    static var current: CoreDataMigrationVersion {
        guard let latest = allCases.last else {
            fatalError("no model versions found")
        }
        
        return latest
    }
    
    // MARK: - Migration
    
    func nextVersion() -> CoreDataMigrationVersion? {
        switch self {
        case .version1:
            return .version2
        case .version2:
            return nil
//            return .version3
//        case .version3:
//            return .version4
//        case .version4:
//            return nil
        }
    }
}

