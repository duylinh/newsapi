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
    
    func fetchKeywordsActive() {
        CoreDataManager.shared.fetchAllKeywordsActive { (results) in
            var keys: [KeywordModel] = []
            for item in results {
                guard let keyword = item.keyword else { return }
                let key = KeywordModel(keyword: keyword, isSelected: true)
                keys.append(key)
            }
            self.keywords = keys
        }
    }
}
