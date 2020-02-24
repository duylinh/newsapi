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
    
    var selectedIndex: Int = 0 {
        didSet {
            self.keyword = self.keywords[selectedIndex].keyword
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
        CoreDataManager.shared.fetchAllKeywordsActive { (results) in
            var keys: [KeywordModel] = []
            for (index, item) in results.enumerated() {
                guard let key = item.keyword else { return }
                let keyword = KeywordModel(keyword: key, isSelected: index == self.selectedIndex)
                keys.append(keyword)
            }
            self.keywords = keys
        }
    }
    
    func updateKeywords(with indexPath: IndexPath) {
        var keys: [KeywordModel] = []
        for (index, keyword) in keywords.enumerated() {
            let key = KeywordModel(keyword: keyword.keyword, isSelected: index == indexPath.row)
            keys.append(key)
        }
        self.keywords = keys
        self.selectedIndex = indexPath.row
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
