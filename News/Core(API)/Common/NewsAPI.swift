//
//  NewsAPI.swift
//  News
//
//  Created by Duy Linh Tran on 2/23/20.
//  Copyright © 2020 Duy Linh Tran. All rights reserved.
//

import UIKit

public typealias VoidResult = Result<Void>

struct NewsAPI {
    
    static let base = "https://newsapi.org"
    
    static let headlines = "/v2/top-headlines?"
    static let everything = "/v2/everything?"
    
    static let countryParam = "country="
    static let categoryParam = "category="
    static let sourcesParam = "&sources="
    static let keywordParam = "q="
    
    ///for everything URL and for filtering purposes
    static let domainParam = "domains="
    static let sortByParam = "sortBy="
    
    static let key = "&apiKey=55bd4fe21af1433b81ddaf9234c9b54c"
    
    //create url for headlines
    static func getHeadlinesURL(country: String) -> String {
        return base + headlines + countryParam + country + key
    }
    
    static func getEverythingURL(searchKeyword: String) -> String {
        return base + everything + keywordParam + searchKeyword + key
    }
    
    static func getFilterEverythingURL(searchKeyword: String, source: String) -> String {
        return base + everything + keywordParam + searchKeyword + sourcesParam + source + key
    }
    
}
