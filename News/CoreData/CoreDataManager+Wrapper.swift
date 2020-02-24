//
//  CoreDataManager+Wrapper.swift
//  News
//
//  Created by Duy Linh Tran on 2/23/20.
//  Copyright © 2020 Duy Linh Tran. All rights reserved.
//

import CoreData
// swiftlint:disable all

// MARK: - CoreDataManager Wrapper
extension CoreDataManager {
    
    func getNewObject(entityName: CoreDataEntity) -> NSManagedObject {
        return NSEntityDescription.insertNewObject(forEntityName: entityName._entity, into: mainContext)
    }
    
    func fetchRecords(entityName: CoreDataEntity, predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil, completion: @escaping (_ records: Any?) -> ()) {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName._entity)
        
        if let predicate_ = predicate {
            fetchRequest.predicate = predicate_
        }
        
        fetchRequest.sortDescriptors = sortDescriptors
        do {
            let result = try mainContext.fetch(fetchRequest)
            if result.count > 0 {
                completion(result)
            }
            else {
                completion(nil)
            }
        } catch let error as NSError {
            print("CoreData - Fetch failed: \(error.localizedDescription)")
        }
    }
    
    func deleteRecord(_ object: NSManagedObject){
         mainContext.delete(object)
    }
    
    func deleteAllRecords(entity: CoreDataEntity){
        if #available(iOS 9.0, *) {
            let req = NSFetchRequest<NSFetchRequestResult>(entityName: entity._entity)
            let batchReq = NSBatchDeleteRequest(fetchRequest: req)
            execute(batchReq)
        } else {
            fetchRecords(entityName: entity, completion: { (results) in
                if let records = results as? [NSManagedObject] {
                    for record in records {
                        self.deleteRecord(record)
                    }
                } else {
                    print("CoreData - No records found to delete")
                }
            })
            
        }
    }
    
    func updateRecords(entity: CoreDataEntity, properties: [AnyHashable : Any]) {
        let batchRequest = NSBatchUpdateRequest(entityName: entity._entity)
        batchRequest.propertiesToUpdate = properties
        batchRequest.resultType = .updatedObjectsCountResultType
        execute(batchRequest)
    }
    
    func execute(_ request: NSPersistentStoreRequest) {
        do {
            try mainContext.execute(request)
        } catch {
            print(error)
        }
    }
}
