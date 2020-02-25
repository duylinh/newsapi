//
//  CoreDataManager+User.swift
//  News
//
//  Created by Duy Linh Tran on 2/25/20.
//  Copyright © 2020 Duy Linh Tran. All rights reserved.
//

import Foundation
// swiftlint:disable all
extension CoreDataManager {
    
    func fetchAllUser(completion: @escaping (_ users: [User]) -> ()) {
        self.fetchRecords(entityName: .User, predicate: nil, sortDescriptors: [], completion: { (results) in
            guard let users = results as? [User], users.count > 0 else {
                completion([])
                return
            }
            completion(users)
        })
    }
    
    func updateUsername(with object: User,
                         newName name: String,
                         completion: ( @escaping() -> Void)) {
        object.username = name
        self.saveContext()
        completion()
    }
    
    func deleteUser(_ user: Keyword,
                    completion: ((Bool) -> Void)) {
        self.deleteRecord(user)
        self.saveContext()
        completion(true)
    }
}
