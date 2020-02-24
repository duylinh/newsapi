//
//  KeywordModel.swift
//  News
//
//  Created by Tran Duy Linh on 2/24/20.
//  Copyright © 2020 Duy Linh Tran. All rights reserved.
//

import Foundation

struct KeywordModel: Codable {
    // MARK: - Properties
    var keyword: String = ""
    var isSelected: Bool = false
    
    init(keyword: String = "", isSelected: Bool = false) {
        self.keyword = keyword
        self.isSelected = isSelected
    }
    
    // MARK: - CodingKeys
    enum CodingKeys: String, CodingKey {
        case keyword
        case isSelected
    }
}
