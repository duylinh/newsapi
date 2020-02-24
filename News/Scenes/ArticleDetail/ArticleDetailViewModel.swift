//
//  ArticleDetailViewModel.swift
//  News
//
//  Created by Duy Linh Tran on 2/24/20.
//  Copyright © 2020 Duy Linh Tran. All rights reserved.
//

import Foundation

protocol ArticleDetailViewModelDelegate: class {
    func didUpdateTableView(_ viewModel: ArticleDetailViewModel)
    func didSelectOnView(_ article: ArticleModel)
}

final class ArticleDetailViewModel {
    
    // MARK: - Vars
    
    weak var delegate: ArticleDetailViewModelDelegate?
    var article: ArticleModel? {
        didSet {
            delegate?.didUpdateTableView(self)
        }
    }
}
