//
//  ArticleModel.swift
//  News
//
//  Created by Duy Linh Tran on 2/23/20.
//  Copyright © 2020 Duy Linh Tran. All rights reserved.
//

import Foundation

struct ArticleModel: Decodable {
    
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    let source: Source?
    
    struct Source: Decodable {
        let id: String?
        let name: String?
    }
}
