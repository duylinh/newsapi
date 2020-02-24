//
//  CoreDataManager.swift
//  News
//
//  Created by Duy Linh Tran on 2/23/20.
//  Copyright © 2020 Duy Linh Tran. All rights reserved.
//

import Foundation
import CoreData

enum CDSaveState {
    case main
    case background
}

// swiftlint:disable all

class CoreDataManager {
    
    let migrator: CoreDataMigratorProtocol
    private let storeType: String
    
    lazy var persistentContainer: NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer(name: "News")
        let description = persistentContainer.persistentStoreDescriptions.first
        description?.shouldInferMappingModelAutomatically = false //inferred mapping will be handled else where
        description?.shouldMigrateStoreAutomatically = false
        description?.type = storeType
        
        return persistentContainer
    }()
    
    lazy var backgroundContext: NSManagedObjectContext = {
        let context = self.persistentContainer.newBackgroundContext()
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        return context
    }()
    
    lazy var mainContext: NSManagedObjectContext = {
        let context = self.persistentContainer.viewContext
        context.automaticallyMergesChangesFromParent = true
        
        return context
    }()
    
    private(set) var isInitial: Bool {
        get {
            if UserDefaults.standard.object(forKey: Constants.CoreData.isInitial) == nil {
                UserDefaults.standard.set(false, forKey: Constants.CoreData.isInitial)
                UserDefaults.standard.synchronize()
                return true
            }
            return UserDefaults.standard.bool(forKey: Constants.CoreData.isInitial)
        }
        set {}
    }
    
    // MARK: - Singleton
    
    static let shared = CoreDataManager()
    
    // MARK: - Init
    
    init(storeType: String = NSSQLiteStoreType, migrator: CoreDataMigratorProtocol = CoreDataMigrator()) {
        self.storeType = storeType
        self.migrator = migrator
    }
    
    // MARK: - SetUp
    
    func setup(completion: @escaping (_ isInitial: Bool) -> Void) {
        loadPersistentStore {
            completion(self.isInitial)
        }
    }
    
    // MARK: - Loading
    
    private func loadPersistentStore(completion: @escaping () -> Void) {
        migrateStoreIfNeeded {
            self.persistentContainer.loadPersistentStores { description, error in
                guard error == nil else {
                    fatalError("was unable to load store \(error!)")
                }
                
                completion()
            }
        }
    }
    
    private func migrateStoreIfNeeded(completion: @escaping () -> Void) {
        guard let storeURL = persistentContainer.persistentStoreDescriptions.first?.url else {
            fatalError("persistentContainer was not set up properly")
        }
        
        if migrator.requiresMigration(at: storeURL, toVersion: CoreDataMigrationVersion.current) {
            DispatchQueue.global(qos: .userInitiated).async {
                self.migrator.migrateStore(at: storeURL, toVersion: CoreDataMigrationVersion.current)
                
                DispatchQueue.main.async {
                    completion()
                }
            }
        } else {
            completion()
        }
    }
    
    // MARK: - Core Data Saving support
    func saveContext(_ state: CDSaveState = .main) {
        switch state {
        case .main:
            let context = CoreDataManager.shared.mainContext
            if context.hasChanges {
                context.perform {
                    do {
                        try context.save()
                    } catch {
                        print("Could not synchonize data. \(error), \(error.localizedDescription)")
                    }
                }
            }
        case .background:
            let context = CoreDataManager.shared.backgroundContext
            context.performAndWait {
                do {
                    try context.save()
                } catch {
                    print("Could not synchonize data. \(error), \(error.localizedDescription)")
                }
            }
        }
    }
}
