//
//  ServicesProtocol.swift
//  News
//
//  Created by Duy Linh Tran on 2/23/20.
//  Copyright © 2020 Duy Linh Tran. All rights reserved.
//

import Foundation
// swiftlint:disable all

protocol ServicesProtocol {
    func getTopHeadlines(in country: String, completion: @escaping (Result<[ArticleModel]?>) -> Void)
    func getEverything(with keyword: String, completion: @escaping (Result<[ArticleModel]?>) -> Void)
    func getFilteredEverything(with keyword: String, and param: String, completion: @escaping (Result<[ArticleModel]?>) -> Void)
}
