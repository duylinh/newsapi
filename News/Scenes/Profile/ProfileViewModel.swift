//
//  ProfileViewModel.swift
//  News
//
//  Created by Duy Linh Tran on 2/23/20.
//  Copyright © 2020 Duy Linh Tran. All rights reserved.
//

import Foundation

protocol ProfileViewModelDelegate: class {
    func loadKeywordsAndDidUpdateKeysCollection(_ viewModel: ProfileViewModel)
}

final class ProfileViewModel {
    
    // MARK: - Vars
    
    weak var delegate: ProfileViewModelDelegate?
    
    var keywords = [KeywordModel]() {
        didSet {
            delegate?.loadKeywordsAndDidUpdateKeysCollection(self)
        }
    }
        
    // MARK: - Fetch
    
    func fetchKeywordsFromDB() {
        let keyword1 = KeywordModel(keyword: "bitcoin", isSelected: true)
        let keyword2 = KeywordModel(keyword: "apple", isSelected: false)
        let keyword3 = KeywordModel(keyword: "earthquake", isSelected: false)
        let keyword4 = KeywordModel(keyword: "animal", isSelected: false)
        keywords = [keyword1, keyword2, keyword3, keyword4]
    }
    
    func updateKeywords(with indexPath: IndexPath) {
        var keys: [KeywordModel] = []
        for (index, keyword) in keywords.enumerated() {
            if indexPath.row == index {
                let key = KeywordModel(keyword: keyword.keyword, isSelected: true)
                keys.append(key)
            } else {
                let key = KeywordModel(keyword: keyword.keyword, isSelected: false)
                keys.append(key)
            }
        }
        self.keywords = keys
    }
}
