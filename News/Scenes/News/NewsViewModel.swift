//
//  NewsViewModel.swift
//  News
//
//  Created by Duy Linh Tran on 2/23/20.
//  Copyright © 2020 Duy Linh Tran. All rights reserved.
//

import Foundation

protocol NewsViewModelDelegate: class {
    func fetchNewsAndDidUpdateTable(_ viewModel: NewsViewModel)
    func didSelectItem(_ article: ArticleModel)
    func loadKeywordsAndDidUpdateKeysCollection(_ viewModel: NewsViewModel)
    func showAlertError(_ error: ErrorViewModel)
}

final class NewsViewModel {
    
    // MARK: - Vars
    
    weak var delegate: NewsViewModelDelegate?
    var articles = [ArticleModel]() {
        didSet {
            delegate?.fetchNewsAndDidUpdateTable(self)
        }
    }
    
    var keywords = [KeywordModel]() {
        didSet {
            delegate?.loadKeywordsAndDidUpdateKeysCollection(self)
        }
    }
    
    var index: Int = 0 {
        didSet {
            self.keyword = self.keywords[index].keyword
        }
    }
    
    private var keyword: String = "bitcoin" {
        didSet {
            fetchNews()
        }
    }
        
    // MARK: - Fetch
    
    private func fetchNews() {
        APIService.shared.getEverything(keyword: keyword) { (result) in
            switch result {
            case .success(let news):
                self.handleSuccessFetchedNews(news)
            case .failure(let error):
                self.handleError(error)
            }
        }
    }
    
    func fetchKeywords() {
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
        self.index = indexPath.row
    }
    
    // MARK: Helpers
    
    private func handleSuccessFetchedNews(_ news: [ArticleModel]?) {
        guard let news = news else { return }
        self.articles = news
    }
    
    private func handleError(_ error: Error) {
        let errorViewModel = ErrorViewModel(error: error)
        delegate?.showAlertError(errorViewModel)
    }
}
