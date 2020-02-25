//
//  UserModel.swift
//  News
//
//  Created by Duy Linh Tran on 2/25/20.
//  Copyright © 2020 Duy Linh Tran. All rights reserved.
//

import Foundation

struct UserModel: Codable {
    // MARK: - Properties
    var username: String = ""
    var password: String = ""
    var keywords: [KeywordModel] = []
    
    init(username: String, password: String, keywords: [KeywordModel]) {
        self.username = username
        self.password = password
        self.keywords = keywords
    }
    
    // MARK: - CodingKeys
    enum CodingKeys: String, CodingKey {
        case username
        case password
    }
}
