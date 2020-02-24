//
//  CoreDataEntity.swift
//  News
//
//  Created by Duy Linh Tran on 2/23/20.
//  Copyright © 2020 Duy Linh Tran. All rights reserved.
//

import CoreData

// swiftlint:disable all
// MARK: - CoreDataEntity
class CoreDataEntity: CoreDataManager {
    public let _entity: String
    
    public init(_ entity: String) {
        self._entity = entity
        super.init()
    }
}

// MARK: - Add your entities here
extension CoreDataManager {
    static let Keyword = CoreDataEntity("Keyword")
}
