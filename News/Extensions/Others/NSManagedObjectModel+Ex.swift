//
//  NSManagedObjectModel+Ex.swift
//  News
//
//  Created by Duy Linh Tran on 2/24/20.
//  Copyright © 2020 Duy Linh Tran. All rights reserved.
//

import CoreData
// swiftlint:disable all

// MARK: - Resource
extension NSManagedObjectModel {
    static func managedObjectModel(forResource resource: String) -> NSManagedObjectModel {
        let mainBundle = Bundle.main
        let subdirectory = "News.momd"
        
        var omoURL: URL?
        if #available(iOS 11, *) {
            omoURL = mainBundle.url(forResource: resource, withExtension: "omo", subdirectory: subdirectory) // optimized model file
        }
        let momURL = mainBundle.url(forResource: resource, withExtension: "mom", subdirectory: subdirectory)
        
        guard let url = omoURL ?? momURL else {
            fatalError("unable to find model in bundle")
        }
        
        guard let model = NSManagedObjectModel(contentsOf: url) else {
            fatalError("unable to load model in bundle")
        }
        
        return model
    }
}

// MARK: - Compatible
extension NSManagedObjectModel {
    static func compatibleModelForStoreMetadata(_ metadata: [String : Any]) -> NSManagedObjectModel? {
        let mainBundle = Bundle.main
        return NSManagedObjectModel.mergedModel(from: [mainBundle], forStoreMetadata: metadata)
    }
}
