//
//  HeadlineViewModel.swift
//  News
//
//  Created by Duy Linh Tran on 2/23/20.
//  Copyright © 2020 Duy Linh Tran. All rights reserved.
//

import Foundation

protocol HeadlineViewModelDelegate: class {
    func fetchDataAndDidUpdate(_ viewModel: HeadlineViewModel)
    func didSelectItem(_ item: ArticleModel)
    func showAlertError(_ error: ErrorViewModel)
}

final class HeadlineViewModel {
    
    // MARK: - Properties
    
    weak var delegate: HeadlineViewModelDelegate?
    var items = [ArticleModel]() {
        didSet {
            delegate?.fetchDataAndDidUpdate(self)
        }
    }
        
    // MARK: - Internal methods
    
    func fetchData() {
        APIService.shared.getTopHeadlines(in: "us") { (result) in
            switch result {
            case .success(let news):
                self.handleSuccessFetchedNews(news)
            case .failure(let error):
                self.handleError(error)
            }
        }
    }
    
    // MARK: Private Helpers
    
    private func handleSuccessFetchedNews(_ news: [ArticleModel]?) {
        guard let news = news else { return }
        self.items = news
    }
    
    private func handleError(_ error: Error) {
        let errorViewModel = ErrorViewModel(error: error)
        delegate?.showAlertError(errorViewModel)
    }
}
