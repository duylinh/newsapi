//
//  CoreDataManager+Keyword.swift
//  News
//
//  Created by Duy Linh Tran on 2/24/20.
//  Copyright © 2020 Duy Linh Tran. All rights reserved.
//

import Foundation
// swiftlint:disable all
extension CoreDataManager {
    
    func fetchAllKeywords(completion: @escaping (_ keys: [Keyword]) -> ()) {
        self.fetchRecords(entityName: .Keyword, predicate: nil, sortDescriptors: [], completion: { (results) in
            guard let keywords = results as? [Keyword], keywords.count > 0 else {
                completion([])
                return
            }
            completion(keywords)
        })
    }
    
    func fetchAllKeywordsActive(completion: @escaping (_ keys: [Keyword]) -> ()) {
        let predicate = NSPredicate(format: "isSelected == YES")
        self.fetchRecords(entityName: .Keyword, predicate: predicate, sortDescriptors: [], completion: { (results) in
            guard let keywords = results as? [Keyword], keywords.count > 0 else {
                completion([])
                return
            }
            completion(keywords)
        })
    }
    
    func fetchAllKeywordsInactive(completion: @escaping (_ keys: [Keyword]) -> ()) {
        let predicate = NSPredicate(format: "isSelected == NO")
        self.fetchRecords(entityName: .Keyword, predicate: predicate, sortDescriptors: [], completion: { (results) in
            guard let keywords = results as? [Keyword], keywords.count > 0 else {
                completion([])
                return
            }
            completion(keywords)
        })
    }
    
    func createKeyword(keyword: String,
                       isSelected: Bool,
                       completion: ((Bool) -> Void)) {
        if keyword.isEmpty {
            completion(false)
            return
        }
        
        guard let newKeyword = self.getNewObject(entityName: .Keyword) as? Keyword else {
            completion(false)
            return
        }
        
        newKeyword.keyword = keyword
        newKeyword.isSelected = isSelected
        
        self.saveContext()
        completion(true)
    }
    
    func updateKeyword(for object: Keyword,
                       keyword: String,
                       isSelected: Bool,
                       completion: ((Bool) -> Void)) {
        if keyword.isEmpty {
            completion(false)
            return
        }
        object.keyword = keyword
        object.isSelected = isSelected
        self.saveContext()
        completion(true)
    }
    
    func deleteKeyword(_ keyword: Keyword,
                       completion: ((Bool) -> Void)) {
        self.deleteRecord(keyword)
        self.saveContext()
        completion(true)
    }
}
