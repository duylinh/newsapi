//
//  APIService.swift
//  News
//
//  Created by Duy Linh Tran on 2/23/20.
//  Copyright © 2020 Duy Linh Tran. All rights reserved.
//

import Foundation
// swiftlint:disable all

final class APIService: ServicesProtocol {
    
    static let shared = APIService()
    
    // create session allowing caching of data
    private let session: URLSession
    private init() {
        let config = URLSessionConfiguration.default
        config.allowsCellularAccess = false
        config.requestCachePolicy = .returnCacheDataElseLoad
        session = URLSession.init(configuration: config)
    }
    
    func getTopHeadlines(in countryCode: String, completion: @escaping (Result<[ArticleModel]?>) -> Void) {
        guard let url = URL(string: NewsAPI.getHeadlinesURL(country: countryCode)) else {return}
        session.dataTask(with: url) { (data, response
            , error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let news = try decoder.decode(NewsModel.self, from: data)
                completion(Result.success(news.articles))
                
            } catch let err {
                print("Err", err)
            }
        }.resume()
    }
    
    func getEverything(with keyword: String, completion: @escaping (Result<[ArticleModel]?>) -> Void) {
        guard let url = URL(string: NewsAPI.getEverythingURL(searchKeyword: keyword)) else {return}
        session.dataTask(with: url) { (data, response
            , error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let news = try decoder.decode(NewsModel.self, from: data)
                completion(Result.success(news.articles))
                
            } catch let err {
                print("Err", err)
            }
        }.resume()
    }
    
    func getFilteredEverything(with keyword: String, and param: String, completion: @escaping (Result<[ArticleModel]?>) -> Void) {
        guard let url = URL(string: NewsAPI.getFilterEverythingURL(searchKeyword: keyword, source: param)) else {return}
        session.dataTask(with: url) { (data, response
            , error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let news = try decoder.decode(NewsModel.self, from: data)
                completion(Result.success(news.articles))
                
            } catch let err {
                print("Err", err)
            }
        }.resume()
    }
}
